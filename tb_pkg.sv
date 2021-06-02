
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "decoder_sequence_item.sv"        // transaction class
 `include "decoder_sequence.sv"             // sequence class
 `include "decoder_sequencer.sv"            // sequencer class
 `include "decoder_driver.sv"               // driver class
 `include "decoder_monitor.sv"
 `include "decoder_agent.sv"                // agent class  
 `include "decoder_coverage.sv"             // coverage class
 `include "decoder_scoreboard.sv"           // scoreboard class
 `include "decoder_env.sv"                  // environment class

 `include "decoder_test.sv"                 // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


