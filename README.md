# VCK190 AXI 1G Vivado Example Design (2022.1)  
*Created using Block Design*

## Prerequisites  
- Vivado 2022.1  
- Sourced environment using `kuiper.sh`

## Description
This script creates a dummy project(`Proj/axi_ethernet_vivado_example_design_vck190`) to configure the AXI 1G Ethernet design and uses it to open the Vivado example design. 
Once the example design is created, it utilizes the RTL files to build a Block Design (BD) and runs through the full implementation flow.

## Steps  
1. cd to `Scripts`
2. Source the `kuiper.sh` file:  
   `source kuiper.sh`
3. Launch Vivado 2022.1 with the example design script:
   `vivado -source create_example_design_first.tcl &`
4. Project is located inside `Proj/axi_ethernet_0_ex`
