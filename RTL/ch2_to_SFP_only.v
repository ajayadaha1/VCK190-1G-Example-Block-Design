`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2025 09:29:59 AM
// Design Name: 
// Module Name: ch2_to_SFP_only
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ch2_to_SFP_only(
    input[3:0] gtytxn_out,
    input[3:0] gtytxp_out,
    input  sfp_rxp,
    input  sfp_rxn,
    
    output sfp_txn,
    output sfp_txp,
    output[3:0] gtyrxn_in,
    output[3:0] gtyrxp_in
    );
    
 assign gtyrxn_in[2]  =  sfp_rxn;
  assign gtyrxp_in[2]  =  sfp_rxp;
  assign sfp_txn = gtytxn_out[2];
  assign sfp_txp = gtytxp_out[2];
 
  assign gtyrxp_in[1:0]=  2'h0;
  assign gtyrxn_in[1:0]=  2'h0;
  assign gtyrxp_in[3]=  1'h0;
  assign gtyrxn_in[3]=  1'h0;
  
endmodule
