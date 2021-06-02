class decoder_sequencer extends uvm_sequencer#(decoder_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(decoder_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="decoder_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:decoder_sequencer

