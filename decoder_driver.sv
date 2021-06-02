
class decoder_driver extends uvm_driver #(decoder_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(decoder_driver)
  //----------------------------------------------------------------------------

  uvm_analysis_port #(decoder_sequence_item) drv2sb;

  //----------------------------------------------------------------------------
  function new(string name="decoder_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    decoder_sequence_item txn=decoder_sequence_item::type_id::create("txn");
    initilize(); // initilize dut at time 0
    forever begin
      seq_item_port.get_next_item(txn);
      drive_item(txn);
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task initilize();
    vif.in = 0;
    vif.en = 0;
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task drive_item(decoder_sequence_item txn);
    vif.in = txn.in;
    vif.en = txn.en;
  endtask
  //----------------------------------------------------------------------------
endclass:decoder_driver

