
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class decoder_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(decoder_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(decoder_sequence_item, decoder_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(decoder_sequence_item, decoder_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(decoder_sequence_item) expfifo;
  uvm_tlm_fifo #(decoder_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT ,UNKNOWN_CNT;
  logic t_en,temp_en;
  logic [2:0] t_in,temp_in;
  logic [7:0] t_out,temp_out; 

  function new(string name="decoder_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
	    super.build_phase(phase);
	    aport_drv = new("aport_drv", this);
	    aport_mon = new("aport_mon", this);
	    expfifo= new("expfifo",this);
	    outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_drv(decoder_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    //write scoreboard code here
    t_en = tr.en;
    t_in = tr.in;
	temp_out = t_out;
    if(t_en==1'b1)
        begin
          case(t_in)
              3'b000:t_out=8'b0000_0001;
              3'b001:t_out=8'b0000_0010;
              3'b010:t_out=8'b0000_0100;
              3'b011:t_out=8'b0000_1000;
              3'b100:t_out=8'b0001_0000;
              3'b101:t_out=8'b0010_0000;
              3'b110:t_out=8'b0100_0000;
              3'b111:t_out=8'b1000_0000;
              default:t_out=8'bx;
          endcase
        end
    else if(t_en==0)
        begin
           t_out=8'b0000_0000;
        end
    tr.out = temp_out;
    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(decoder_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
	decoder_sequence_item exp_tr, out_tr;
    static int unsigned count=0;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        

        if(out_tr.out===exp_tr.out && count>0) begin
            PASS();
          `uvm_info ("\n [PASS ",out_tr.convert2string() , UVM_MEDIUM)
	    end
      
        else if(out_tr.out!==exp_tr.out && count>0)
          begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
         count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",
                      $sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",
            $sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	  VECT_CNT++;
	  PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

  function void UNKNOWN();
  	VECT_CNT++;
    UNKNOWN_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

