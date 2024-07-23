//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_sequence
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

class mem_sequence extends uvm_sequence#(mem_sequence_item);
  
  `uvm_object_utils(mem_sequence)
  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  `uvm_declare_p_sequencer(sequencer)

  virtual task body();
    repeat(2)begin
    req = mem_sequence_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
	end
  endtask
endclass

class mem_wr_sequence extends uvm_sequence#(mem_sequence_item);
  
  `uvm_object_utils(mem_wr_sequence)
   
  function new(string name = "mem_wr_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.wr_en==1;})
  endtask
endclass

class mem_rd_sequence extends uvm_sequence#(mem_sequence_item);
  
  `uvm_object_utils(mem_rd_sequence)
   
  function new(string name = "mem_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.rd_en==1;})
  endtask
endclass

class mem_wr_rd_sequence extends uvm_sequence#(mem_sequence_item);
  
  `uvm_object_utils(mem_wr_rd_sequence)
   
  function new(string name = "mem_wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.wr_en==1;})
    `uvm_do_with(req,{req.rd_en==1;})
  endtask
endclass

class mem_regression extends uvm_sequence#(mem_sequence_item);
  
  mem_wr_sequence  wr_seq;
  mem_rd_sequence  rd_seq;
  
  `uvm_object_utils(mem_regression)
   
  function new(string name = "mem_regression");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do(wr_seq)
    `uvm_do(rd_seq)
  endtask
endclass

