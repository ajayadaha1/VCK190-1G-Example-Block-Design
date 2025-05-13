# Project and board setup
set project_name "axi_ethernet_vivado_example_design_vck190"
set project_dir "../Proj/$project_name"
set board_part "xilinx.com:vck190:part0:3.0"
set part_name "xcvc1902-vsva2197-2MP-e-S"

create_project $project_name $project_dir -part $part_name -force
set_property board_part $board_part [current_project]
update_ip_catalog

# Create and configure the AXI Ethernet IP
set ip_name "axi_ethernet"
set module_name "axi_ethernet_0"
create_ip -name $ip_name -vendor xilinx.com -library ip -version 7.2 -module_name $module_name

set_property -dict [list \
  CONFIG.ClockSelection {Async} \
  CONFIG.Component_Name {design_1_axi_ethernet_0_0} \
  CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
  CONFIG.ENABLE_AVB {false} \
  CONFIG.ENABLE_LVDS {false} \
  CONFIG.ETHERNET_BOARD_INTERFACE {Custom} \
  CONFIG.EnableAsyncSGMII {false} \
  CONFIG.Enable_1588 {false} \
  CONFIG.Enable_1588_1step {false} \
  CONFIG.Enable_Pfc {false} \
  CONFIG.Frame_Filter {true} \
  CONFIG.GTinEx {true} \
  CONFIG.Include_IO {true} \
  CONFIG.InstantiateBitslice0 {false} \
  CONFIG.MCAST_EXTEND {false} \
  CONFIG.MDIO_BOARD_INTERFACE {Custom} \
  CONFIG.Number_of_Table_Entries {4} \
  CONFIG.PHYADDR {1} \
  CONFIG.PHYRST_BOARD_INTERFACE {Custom} \
  CONFIG.PHYRST_BOARD_INTERFACE_DUMMY_PORT {Custom} \
  CONFIG.PHY_TYPE {1000BaseX} \
  CONFIG.RXCSUM {None} \
  CONFIG.RXMEM {4k} \
  CONFIG.RXVLAN_STRP {false} \
  CONFIG.RXVLAN_TAG {false} \
  CONFIG.RXVLAN_TRAN {false} \
  CONFIG.SIMULATION_MODE {false} \
  CONFIG.Statistics_Counters {true} \
  CONFIG.Statistics_Reset {false} \
  CONFIG.Statistics_Width {64bit} \
  CONFIG.SupportLevel {0} \
  CONFIG.TIMER_CLK_PERIOD {4000} \
  CONFIG.TXCSUM {None} \
  CONFIG.TXMEM {4k} \
  CONFIG.TXVLAN_STRP {false} \
  CONFIG.TXVLAN_TAG {false} \
  CONFIG.TXVLAN_TRAN {false} \
  CONFIG.Timer_Format {0} \
  CONFIG.TransceiverControl {false} \
  CONFIG.USE_BOARD_FLOW {true} \
  CONFIG.VERSAL_GT_BOARD_FLOW {0} \
  CONFIG.axiliteclkrate {160} \
  CONFIG.axisclkrate {160} \
  CONFIG.drpclkrate {50.0} \
  CONFIG.gt_type {GTY} \
  CONFIG.gtlocation {X0Y3} \
  CONFIG.gtrefclkrate {156.25} \
  CONFIG.gtrefclksrc {clk0} \
  CONFIG.lvdsclkrate {125} \
  CONFIG.processor_mode {true} \
  CONFIG.rxlane0_placement {DIFF_PAIR_0} \
  CONFIG.rxlane1_placement {DIFF_PAIR_1} \
  CONFIG.rxnibblebitslice0used {false} \
  CONFIG.speed_1_2p5 {1G} \
  CONFIG.tx_in_upper_nibble {true} \
  CONFIG.txlane0_placement {DIFF_PAIR_0} \
  CONFIG.txlane1_placement {DIFF_PAIR_1} \
] [get_ips $module_name]

generate_target all [get_ips $module_name]

# Open example project to generate it
#open_example_project -force -in_process -ip [get_ips $module_name]
open_example_project -force -dir ../Proj [get_ips  $module_name]

# Wait for the generation process to finish before proceeding
#wait_on_runs

close_project

# Open the generated example project
open_project ../Proj/axi_ethernet_0_ex/axi_ethernet_0_ex.xpr

import_files -norecurse ../RTL/ch2_to_SFP_only.v
import_files -norecurse ../RTL/clockWire.v
import_files -norecurse ../RTL/rxcommaalignen_out_shifter.v

# Replace the XDC constraint files
file copy -force ../XDC/axi_ethernet_0_example_design.xdc ../Proj/axi_ethernet_0_ex/imports/
file copy -force ../XDC/axi_ethernet_0_ex_des_loc.xdc ../Proj/axi_ethernet_0_ex/imports/

#Replace clock file
file copy -force ../RTL/axi_ethernet_0_clocks_resets.v ../Proj/axi_ethernet_0_ex/imports/

# Source the block design Tcl
source ./source_bd.tcl

# Save the modified project with a new name
#save_project_as ../Proj/example_axi_ethernet_with_bd -force

make_wrapper -files [get_files ../Proj/${module_name}_ex/${module_name}_ex.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ../Proj/${module_name}_ex/${module_name}_ex.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v

set_property top design_1_wrapper [current_fileset]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

validate_bd_design
save_bd_design

set_property synth_checkpoint_mode None [get_files ../Proj/${module_name}_ex/${module_name}_ex.srcs/sources_1/bd/design_1/design_1.bd]

launch_runs impl_1 -to_step write_device_image -jobs 37
