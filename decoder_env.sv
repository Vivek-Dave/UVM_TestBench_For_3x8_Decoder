
class decoder_env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(decoder_env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="decoder_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
  decoder_agent    agent_h;
  decoder_coverage coverage_h;
  decoder_scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h      = decoder_agent::type_id::create("agent_h",this);
    coverage_h   = decoder_coverage::type_id::create("coverage_h",this);
    scoreboard_h = decoder_scoreboard::type_id::create("scoreboard_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);
    // monitor to scoreboard connection
    agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
    // driver to scoreboard connection
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
  endfunction
  //----------------------------------------------------------------------------
endclass:decoder_env

