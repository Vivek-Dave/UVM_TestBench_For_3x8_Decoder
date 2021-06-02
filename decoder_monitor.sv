
class decoder_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(decoder_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="decoder_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  decoder_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(decoder_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    ap_mon=new("ap_mon",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    txn=decoder_sequence_item::type_id::create("txn");
    forever
    begin
      sample_dut(txn); 
      ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task sample_dut(output decoder_sequence_item txn);
    decoder_sequence_item t=decoder_sequence_item::type_id::create("t");
    //@(vif.in or vif.en or vif.out);  //  it works but generate one info msg in scoreboad 
    //@(vif.in or vif.en);  // scoreboard gives mismatch if value don't change in monitor
    #5;  // since there is no clock to sample data on i used hard coded method for delay
         // not recommended 
    t.in  = vif.in;
    t.en  = vif.en;
    t.out = vif.out;
    txn=t;
  endtask
  //----------------------------------------------------------------------------

endclass:decoder_monitor

