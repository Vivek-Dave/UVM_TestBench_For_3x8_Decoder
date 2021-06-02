
/***************************************************
** class name  : decoder sequence
** description : generate input in continious order
                 i.e, 0,1,2...7 ; en==1
***************************************************/
class decoder_sequence extends uvm_sequence#(decoder_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(decoder_sequence)            
  //----------------------------------------------------------------------------

  decoder_sequence_item txn;
  int unsigned REPEAT=1;
  bit [7:0] delay;
  //----------------------------------------------------------------------------
  function new(string name="decoder_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(REPEAT) begin
      for(int i=0;i<8;i++) begin   
        txn=decoder_sequence_item::type_id::create("txn");
        start_item(txn);
        txn.randomize()with{txn.en==1; txn.in==i;};
        #5;
        finish_item(txn);
      end
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:decoder_sequence

/***************************************************
** class name  : decoder_random_sequence
** description : generate random inputs for DUT
***************************************************/
class decoder_random_sequence extends decoder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(decoder_random_sequence)      
  //----------------------------------------------------------------------------
  
  decoder_sequence_item txn;
  int unsigned REPEAT=50;
  bit [7:0] delay;
  
  //----------------------------------------------------------------------------
  function new(string name="decoder_random_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(REPEAT) begin 
      txn=decoder_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.en==1;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass


class decoder_random_sequence_en0 extends decoder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(decoder_random_sequence_en0)      
  //----------------------------------------------------------------------------
  
  decoder_sequence_item txn;
  int unsigned REPEAT=10;
  
  //----------------------------------------------------------------------------
  function new(string name="decoder_random_sequence_en0");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(REPEAT) begin 
      txn=decoder_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.en==0;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass
