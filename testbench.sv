
`include "interface.sv"
`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  //----------------------------------------------------------------------------
  intf i_intf();
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  decoder_3x8 DUT(.in(i_intf.in),
                  .en(i_intf.en),
                  .out(i_intf.out)
                 );
  //----------------------------------------------------------------------------               

  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("decoder_test");
  end
  //----------------------------------------------------------------------------
endmodule
