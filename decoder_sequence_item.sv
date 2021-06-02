class decoder_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic       en;  //i/p
  rand logic [2:0] in;

  logic [7:0] out;      //o/p
  
  //---------------- register decoder_sequence_item class with factory --------
  `uvm_object_utils_begin(decoder_sequence_item) 
     `uvm_field_int( en  ,UVM_ALL_ON)
     `uvm_field_int( in  ,UVM_ALL_ON)
     `uvm_field_int( out ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="decoder_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("in=%3b  en=%0b",in,en));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("out=%8b", out));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), " || ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:decoder_sequence_item
