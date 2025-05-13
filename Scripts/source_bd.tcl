
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# axi_ethernet_0_axi_lite_ctrl, axi_ethernet_0_clocks_resets, axi_ethernet_0_streaming_generator, axi_ethernet_0_support_resets, ch2_to_SFP_only, clockWire, rxcommaalignen_out_shifter

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvc1902-vsva2197-2MP-e-S
   set_property BOARD_PART xilinx.com:vck190:part0:3.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_ethernet:7.2\
xilinx.com:ip:axis_ila:1.1\
xilinx.com:ip:axis_vio:1.0\
xilinx.com:ip:versal_cips:3.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:bufg_gt:1.0\
xilinx.com:ip:gt_quad_base:1.1\
xilinx.com:ip:util_ds_buf:2.2\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
axi_ethernet_0_axi_lite_ctrl\
axi_ethernet_0_clocks_resets\
axi_ethernet_0_streaming_generator\
axi_ethernet_0_support_resets\
ch2_to_SFP_only\
clockWire\
rxcommaalignen_out_shifter\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: streaming_gen_consts
proc create_hier_cell_streaming_gen_consts { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_streaming_gen_consts() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 47 -to 0 dout
  create_bd_pin -dir O -from 31 -to 0 dout1
  create_bd_pin -dir O -from 31 -to 0 dout2
  create_bd_pin -dir O -from 15 -to 0 dout3
  create_bd_pin -dir O -from 15 -to 0 dout4
  create_bd_pin -dir O -from 47 -to 0 dout5
  create_bd_pin -dir O -from 15 -to 0 dout6
  create_bd_pin -dir O -from 15 -to 0 dout7
  create_bd_pin -dir O -from 15 -to 0 dout8
  create_bd_pin -dir O -from 15 -to 0 dout9
  create_bd_pin -dir O -from 11 -to 0 dout10
  create_bd_pin -dir O -from 2 -to 0 dout11
  create_bd_pin -dir O -from 0 -to 0 dout12
  create_bd_pin -dir O -from 1 -to 0 dout13
  create_bd_pin -dir O -from 1 -to 0 dout14
  create_bd_pin -dir O -from 0 -to 0 dout15
  create_bd_pin -dir O -from 4 -to 0 dout16

  # Create instance: mtrlb_config_dest_addr, and set properties
  set mtrlb_config_dest_addr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_dest_addr ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xDA0203040506} \
   CONFIG.CONST_WIDTH {48} \
 ] $mtrlb_config_dest_addr

  # Create instance: mtrlb_config_ip_dest_addr, and set properties
  set mtrlb_config_ip_dest_addr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_ip_dest_addr ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xDA060708} \
   CONFIG.CONST_WIDTH {32} \
 ] $mtrlb_config_ip_dest_addr

  # Create instance: mtrlb_config_ip_src_addr, and set properties
  set mtrlb_config_ip_src_addr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_ip_src_addr ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x5A060708} \
   CONFIG.CONST_WIDTH {32} \
 ] $mtrlb_config_ip_src_addr

  # Create instance: mtrlb_config_max_size, and set properties
  set mtrlb_config_max_size [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_max_size ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x0500} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_max_size

  # Create instance: mtrlb_config_min_size, and set properties
  set mtrlb_config_min_size [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_min_size ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x0040} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_min_size

  # Create instance: mtrlb_config_src_addr, and set properties
  set mtrlb_config_src_addr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_src_addr ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xCA0203040506} \
   CONFIG.CONST_WIDTH {48} \
 ] $mtrlb_config_src_addr

  # Create instance: mtrlb_config_tcp_dest_port, and set properties
  set mtrlb_config_tcp_dest_port [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_tcp_dest_port ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xDA09} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_tcp_dest_port

  # Create instance: mtrlb_config_tcp_src_port, and set properties
  set mtrlb_config_tcp_src_port [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_tcp_src_port ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x5A09} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_tcp_src_port

  # Create instance: mtrlb_config_udp_dest_port, and set properties
  set mtrlb_config_udp_dest_port [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_udp_dest_port ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xDA0A} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_udp_dest_port

  # Create instance: mtrlb_config_udp_src_port, and set properties
  set mtrlb_config_udp_src_port [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_udp_src_port ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x5A0A} \
   CONFIG.CONST_WIDTH {16} \
 ] $mtrlb_config_udp_src_port

  # Create instance: mtrlb_config_vlan_id, and set properties
  set mtrlb_config_vlan_id [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_vlan_id ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {12} \
 ] $mtrlb_config_vlan_id

  # Create instance: mtrlb_config_vlan_priority, and set properties
  set mtrlb_config_vlan_priority [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_config_vlan_priority ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {3} \
 ] $mtrlb_config_vlan_priority

  # Create instance: mtrlb_da_sa_swap_en, and set properties
  set mtrlb_da_sa_swap_en [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_da_sa_swap_en ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $mtrlb_da_sa_swap_en

  # Create instance: mtrlb_en_cs_offload, and set properties
  set mtrlb_en_cs_offload [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mtrlb_en_cs_offload ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {2} \
 ] $mtrlb_en_cs_offload

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {b11} \
   CONFIG.CONST_WIDTH {2} \
 ] $xlconstant_1

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_3

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {5} \
 ] $xlconstant_4

  # Create port connections
  connect_bd_net -net Net1 [get_bd_pins dout15] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net mtrlb_config_dest_addr_dout [get_bd_pins dout] [get_bd_pins mtrlb_config_dest_addr/dout]
  connect_bd_net -net mtrlb_config_ip_dest_addr_dout [get_bd_pins dout1] [get_bd_pins mtrlb_config_ip_dest_addr/dout]
  connect_bd_net -net mtrlb_config_ip_src_addr_dout [get_bd_pins dout2] [get_bd_pins mtrlb_config_ip_src_addr/dout]
  connect_bd_net -net mtrlb_config_max_size_dout [get_bd_pins dout3] [get_bd_pins mtrlb_config_max_size/dout]
  connect_bd_net -net mtrlb_config_min_size_dout [get_bd_pins dout4] [get_bd_pins mtrlb_config_min_size/dout]
  connect_bd_net -net mtrlb_config_src_addr_dout [get_bd_pins dout5] [get_bd_pins mtrlb_config_src_addr/dout]
  connect_bd_net -net mtrlb_config_tcp_dest_port_dout [get_bd_pins dout6] [get_bd_pins mtrlb_config_tcp_dest_port/dout]
  connect_bd_net -net mtrlb_config_tcp_src_port_dout [get_bd_pins dout7] [get_bd_pins mtrlb_config_tcp_src_port/dout]
  connect_bd_net -net mtrlb_config_udp_dest_port_dout [get_bd_pins dout8] [get_bd_pins mtrlb_config_udp_dest_port/dout]
  connect_bd_net -net mtrlb_config_udp_src_port_dout [get_bd_pins dout9] [get_bd_pins mtrlb_config_udp_src_port/dout]
  connect_bd_net -net mtrlb_config_vlan_id_dout [get_bd_pins dout10] [get_bd_pins mtrlb_config_vlan_id/dout]
  connect_bd_net -net mtrlb_config_vlan_priority_dout [get_bd_pins dout11] [get_bd_pins mtrlb_config_vlan_priority/dout]
  connect_bd_net -net mtrlb_da_sa_swap_en_dout [get_bd_pins dout12] [get_bd_pins mtrlb_da_sa_swap_en/dout]
  connect_bd_net -net mtrlb_en_cs_offload_dout [get_bd_pins dout13] [get_bd_pins mtrlb_en_cs_offload/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins dout14] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_4_dout [get_bd_pins dout16] [get_bd_pins xlconstant_4/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_ethernet_0_gt_wrapper
proc create_hier_cell_axi_ethernet_0_gt_wrapper { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_ethernet_0_gt_wrapper() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_rx_interface_rtl:1.0 RX0_GT_IP_Interface

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_tx_interface_rtl:1.0 TX0_GT_IP_Interface


  # Create pins
  create_bd_pin -dir I -type clk apb3clk_0
  create_bd_pin -dir O ch0_rxprogdivresetdone_0
  create_bd_pin -dir O ch0_txprogdivresetdone_0
  create_bd_pin -dir I -from 2 -to 0 ch2_loopback
  create_bd_pin -dir I -from 15 -to 0 gpi_0
  create_bd_pin -dir I -from 3 -to 0 gt_rxn_in_0
  create_bd_pin -dir I -from 3 -to 0 gt_rxp_in_0
  create_bd_pin -dir O -from 3 -to 0 gt_txn_out_0
  create_bd_pin -dir O -from 3 -to 0 gt_txp_out_0
  create_bd_pin -dir O gtpowergood
  create_bd_pin -dir I -from 0 -to 0 gtrefclk_n_0
  create_bd_pin -dir O -from 0 -to 0 -type clk gtrefclk_out
  create_bd_pin -dir I -from 0 -to 0 gtrefclk_p_0
  create_bd_pin -dir O hsclk0_lcplllock
  create_bd_pin -dir O -type gt_usrclk rxuserclk
  create_bd_pin -dir O -type gt_usrclk rxuserclk2
  create_bd_pin -dir O -type gt_usrclk userclk
  create_bd_pin -dir O -type gt_usrclk userclk2

  # Create instance: bufg_gt_0, and set properties
  set bufg_gt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {62.5e6} \
 ] $bufg_gt_0

  # Create instance: bufg_gt_1, and set properties
  set bufg_gt_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_1 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125e6} \
 ] $bufg_gt_1

  # Create instance: bufg_gt_2, and set properties
  set bufg_gt_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_2 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {62.5} \
 ] $bufg_gt_2

  # Create instance: bufg_gt_3, and set properties
  set bufg_gt_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_3 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {62.5e6} \
 ] $bufg_gt_3

  # Create instance: gt_quad_base_1, and set properties
  set gt_quad_base_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base:1.1 gt_quad_base_1 ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {unconnected {RX0 RX1 RX3 TX0 TX1 TX3} PROT0 {RX2 TX2}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {APB3_INTF}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.REFCLK_STRING {HSCLK1_LCPLLGTREFCLK0 refclk_PROT0_R0_156.25_MHz_unique1} \
 ] $gt_quad_base_1

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net RX0_GT_IP_Interface_1 [get_bd_intf_pins RX0_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/RX2_GT_IP_Interface]
  connect_bd_intf_net -intf_net TX0_GT_IP_Interface_1 [get_bd_intf_pins TX0_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/TX2_GT_IP_Interface]

  # Create port connections
  connect_bd_net -net apb3clk_0_1 [get_bd_pins apb3clk_0] [get_bd_pins gt_quad_base_1/apb3clk]
  connect_bd_net -net bufg_gt_0_usrclk [get_bd_pins userclk] [get_bd_pins bufg_gt_0/usrclk] [get_bd_pins gt_quad_base_1/ch2_rxusrclk] [get_bd_pins gt_quad_base_1/ch2_txusrclk]
  connect_bd_net -net bufg_gt_1_usrclk [get_bd_pins userclk2] [get_bd_pins bufg_gt_1/usrclk]
  connect_bd_net -net bufg_gt_2_usrclk [get_bd_pins rxuserclk] [get_bd_pins bufg_gt_2/usrclk]
  connect_bd_net -net bufg_gt_3_usrclk [get_bd_pins rxuserclk2] [get_bd_pins bufg_gt_3/usrclk]
  connect_bd_net -net ch2_loopback_1 [get_bd_pins ch2_loopback] [get_bd_pins gt_quad_base_1/ch2_loopback]
  connect_bd_net -net gpi_0_1 [get_bd_pins gpi_0] [get_bd_pins gt_quad_base_1/gpi]
  connect_bd_net -net gt_quad_base_0_ch0_rxoutclk [get_bd_pins bufg_gt_2/outclk] [get_bd_pins bufg_gt_3/outclk] [get_bd_pins gt_quad_base_1/ch2_rxoutclk]
  connect_bd_net -net gt_quad_base_0_ch0_txoutclk [get_bd_pins bufg_gt_0/outclk] [get_bd_pins bufg_gt_1/outclk] [get_bd_pins gt_quad_base_1/ch2_txoutclk]
  connect_bd_net -net gt_quad_base_0_ch2_rxprogdivresetdone [get_bd_pins ch0_rxprogdivresetdone_0] [get_bd_pins gt_quad_base_1/ch2_rxprogdivresetdone]
  connect_bd_net -net gt_quad_base_0_ch2_txprogdivresetdone [get_bd_pins ch0_txprogdivresetdone_0] [get_bd_pins gt_quad_base_1/ch2_txprogdivresetdone]
  connect_bd_net -net gt_quad_base_0_gtpowergood [get_bd_pins gtpowergood] [get_bd_pins gt_quad_base_1/gtpowergood]
  connect_bd_net -net gt_quad_base_0_hsclk0_lcplllock [get_bd_pins hsclk0_lcplllock] [get_bd_pins gt_quad_base_1/hsclk0_lcplllock]
  connect_bd_net -net gt_quad_base_0_txn [get_bd_pins gt_txn_out_0] [get_bd_pins gt_quad_base_1/txn]
  connect_bd_net -net gt_quad_base_0_txp [get_bd_pins gt_txp_out_0] [get_bd_pins gt_quad_base_1/txp]
  connect_bd_net -net gt_rxn_in_0_1 [get_bd_pins gt_rxn_in_0] [get_bd_pins gt_quad_base_1/rxn]
  connect_bd_net -net gt_rxp_in_0_1 [get_bd_pins gt_rxp_in_0] [get_bd_pins gt_quad_base_1/rxp]
  connect_bd_net -net gtrefclk_n_0_1 [get_bd_pins gtrefclk_n_0] [get_bd_pins util_ds_buf_0/IBUF_DS_N]
  connect_bd_net -net gtrefclk_p_0_1 [get_bd_pins gtrefclk_p_0] [get_bd_pins util_ds_buf_0/IBUF_DS_P]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins gtrefclk_out] [get_bd_pins gt_quad_base_1/GT_REFCLK0] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins bufg_gt_0/gt_bufgtclr] [get_bd_pins bufg_gt_1/gt_bufgtclr] [get_bd_pins bufg_gt_2/gt_bufgtclr] [get_bd_pins bufg_gt_3/gt_bufgtclr] [get_bd_pins gt_quad_base_1/altclk] [get_bd_pins gt_quad_base_1/ch0_rxusrclk] [get_bd_pins gt_quad_base_1/ch0_txusrclk] [get_bd_pins gt_quad_base_1/ch1_rxusrclk] [get_bd_pins gt_quad_base_1/ch1_txusrclk] [get_bd_pins gt_quad_base_1/ch3_rxusrclk] [get_bd_pins gt_quad_base_1/ch3_txusrclk] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins bufg_gt_0/gt_bufgtdiv] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins bufg_gt_0/gt_bufgtce] [get_bd_pins bufg_gt_0/gt_bufgtcemask] [get_bd_pins bufg_gt_0/gt_bufgtclrmask] [get_bd_pins bufg_gt_1/gt_bufgtce] [get_bd_pins bufg_gt_1/gt_bufgtcemask] [get_bd_pins bufg_gt_1/gt_bufgtclrmask] [get_bd_pins bufg_gt_2/gt_bufgtce] [get_bd_pins bufg_gt_2/gt_bufgtcemask] [get_bd_pins bufg_gt_2/gt_bufgtclrmask] [get_bd_pins bufg_gt_3/gt_bufgtce] [get_bd_pins bufg_gt_3/gt_bufgtcemask] [get_bd_pins bufg_gt_3/gt_bufgtclrmask] [get_bd_pins xlconstant_2/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set SFP0_TX_DISABLE [ create_bd_port -dir O -from 0 -to 0 SFP0_TX_DISABLE ]
  set gtrefclk_n_0 [ create_bd_port -dir I gtrefclk_n_0 ]
  set gtrefclk_p_0 [ create_bd_port -dir I gtrefclk_p_0 ]
  set sfp_rxn [ create_bd_port -dir I sfp_rxn ]
  set sfp_rxp [ create_bd_port -dir I sfp_rxp ]
  set sfp_txn [ create_bd_port -dir O sfp_txn ]
  set sfp_txp [ create_bd_port -dir O sfp_txp ]

  # Create instance: axi_ethernet_0, and set properties
  set axi_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.2 axi_ethernet_0 ]
  set_property -dict [ list \
   CONFIG.ClockSelection {Async} \
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
   CONFIG.axiliteclkrate {160} \
   CONFIG.axisclkrate {160} \
   CONFIG.drpclkrate {50.0} \
   CONFIG.gt_type {GTY} \
   CONFIG.gtrefclkrate {156.25} \
   CONFIG.lvdsclkrate {125} \
   CONFIG.processor_mode {true} \
   CONFIG.speed_1_2p5 {1G} \
 ] $axi_ethernet_0

  # Create instance: axi_ethernet_0_axi_l_0, and set properties
  set block_name axi_ethernet_0_axi_lite_ctrl
  set block_cell_name axi_ethernet_0_axi_l_0
  if { [catch {set axi_ethernet_0_axi_l_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_ethernet_0_axi_l_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_ethernet_0_clock_0, and set properties
  set block_name axi_ethernet_0_clocks_resets
  set block_cell_name axi_ethernet_0_clock_0
  if { [catch {set axi_ethernet_0_clock_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_ethernet_0_clock_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /axi_ethernet_0_clock_0/sys_rst]

  # Create instance: axi_ethernet_0_gt_wrapper
  create_hier_cell_axi_ethernet_0_gt_wrapper [current_bd_instance .] axi_ethernet_0_gt_wrapper

  # Create instance: axi_ethernet_0_strea_0, and set properties
  set block_name axi_ethernet_0_streaming_generator
  set block_cell_name axi_ethernet_0_strea_0
  if { [catch {set axi_ethernet_0_strea_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_ethernet_0_strea_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_ethernet_0_suppo_0, and set properties
  set block_name axi_ethernet_0_support_resets
  set block_cell_name axi_ethernet_0_suppo_0
  if { [catch {set axi_ethernet_0_suppo_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_ethernet_0_suppo_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /axi_ethernet_0_suppo_0/pma_reset]

  # Create instance: axis_ila_0, and set properties
  set axis_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_ila:1.1 axis_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_MON_TYPE {Net_Probes} \
   CONFIG.C_NUM_OF_PROBES {3} \
   CONFIG.C_PROBE0_TYPE {0} \
   CONFIG.C_PROBE0_WIDTH {16} \
   CONFIG.C_PROBE1_TYPE {0} \
   CONFIG.C_PROBE1_WIDTH {1} \
   CONFIG.C_PROBE2_TYPE {0} \
   CONFIG.C_PROBE2_WIDTH {1} \
 ] $axis_ila_0

  # Create instance: axis_vio_0, and set properties
  set axis_vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_vio:1.0 axis_vio_0 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
   CONFIG.C_NUM_PROBE_OUT {3} \
   CONFIG.C_PROBE_OUT0_WIDTH {8} \
 ] $axis_vio_0

  # Create instance: ch2_to_SFP_only_0, and set properties
  set block_name ch2_to_SFP_only
  set block_cell_name ch2_to_SFP_only_0
  if { [catch {set ch2_to_SFP_only_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ch2_to_SFP_only_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: cips_0, and set properties
  set cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.2 cips_0 ]
  set_property -dict [ list \
   CONFIG.CLOCK_MODE {Custom} \
   CONFIG.DDR_MEMORY_MODE {Custom} \
   CONFIG.DEBUG_MODE {Custom} \
   CONFIG.PS_BOARD_INTERFACE {Custom} \
   CONFIG.PS_PMC_CONFIG {\
     CLOCK_MODE {Custom}\
     DDR_MEMORY_MODE {Custom}\
     DEBUG_MODE {Custom}\
     DESIGN_MODE {1}\
     PMC_ALT_REF_CLK_FREQMHZ {33.333}\
     PMC_CRP_EFUSE_REF_CTRL_SRCSEL {IRO_CLK/4}\
     PMC_CRP_HSM0_REF_CTRL_FREQMHZ {33.333}\
     PMC_CRP_HSM1_REF_CTRL_FREQMHZ {133.333}\
     PMC_CRP_LSBUS_REF_CTRL_FREQMHZ {100}\
     PMC_CRP_NOC_REF_CTRL_FREQMHZ {960}\
     PMC_CRP_NPLL_CTRL_CLKOUTDIV {4}\
     PMC_CRP_NPLL_TO_XPD_CTRL_DIVISOR0 {2}\
     PMC_CRP_PL0_REF_CTRL_DIVISOR0 {4}\
     PMC_CRP_PL0_REF_CTRL_FREQMHZ {300}\
     PMC_CRP_PL0_REF_CTRL_SRCSEL {PPLL}\
     PMC_CRP_PL5_REF_CTRL_FREQMHZ {400}\
     PMC_CRP_PPLL_CTRL_FBDIV {72}\
     PMC_GPIO0_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 0 .. 25}}}\
     PMC_GPIO1_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 26 .. 51}}}\
     PMC_MIO37 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA high}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE GPIO}}\
     PMC_OSPI_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 0 .. 11}} {MODE Single}}\
     PMC_PL_ALT_REF_CLK_FREQMHZ {33.333}\
     PMC_QSPI_COHERENCY {0}\
     PMC_QSPI_FBCLK {{ENABLE 1} {IO {PMC_MIO 6}}}\
     PMC_QSPI_PERIPHERAL_DATA_MODE {x4}\
     PMC_QSPI_PERIPHERAL_ENABLE {1}\
     PMC_QSPI_PERIPHERAL_MODE {Dual Parallel}\
     PMC_REF_CLK_FREQMHZ {33.3333}\
     PMC_SD1 {{CD_ENABLE 1} {CD_IO {PMC_MIO 28}} {POW_ENABLE 1} {POW_IO {PMC_MIO 51}}\
{RESET_ENABLE 0} {RESET_IO {PMC_MIO 12}} {WP_ENABLE 0} {WP_IO {PMC_MIO\
1}}}\
     PMC_SD1_COHERENCY {0}\
     PMC_SD1_DATA_TRANSFER_MODE {8Bit}\
     PMC_SD1_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x3} {CLK_200_SDR_OTAP_DLY 0x2}\
{CLK_50_DDR_ITAP_DLY 0x36} {CLK_50_DDR_OTAP_DLY 0x3}\
{CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x4} {ENABLE\
1} {IO {PMC_MIO 26 .. 36}}}\
     PMC_SD1_SLOT_TYPE {SD 3.0}\
     PMC_USE_PMC_NOC_AXI0 {0}\
     PSPMC_MANUAL_CLK_ENABLE {1}\
     PS_BOARD_INTERFACE {Custom}\
     PS_CAN1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 40 .. 41}}}\
     PS_ENET0_MDIO {{ENABLE 1} {IO {PS_MIO 24 .. 25}}}\
     PS_ENET0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 11}}}\
     PS_ENET1_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 12 .. 23}}}\
     PS_GEN_IPI0_ENABLE {1}\
     PS_GEN_IPI0_MASTER {A72}\
     PS_GEN_IPI1_ENABLE {1}\
     PS_GEN_IPI2_ENABLE {1}\
     PS_GEN_IPI3_ENABLE {1}\
     PS_GEN_IPI4_ENABLE {1}\
     PS_GEN_IPI5_ENABLE {1}\
     PS_GEN_IPI6_ENABLE {1}\
     PS_HSDP_EGRESS_TRAFFIC {JTAG}\
     PS_HSDP_INGRESS_TRAFFIC {JTAG}\
     PS_HSDP_MODE {NONE}\
     PS_I2C0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 46 .. 47}}}\
     PS_I2C1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 44 .. 45}}}\
     PS_MIO19 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO21 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO7 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO9 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_NUM_FABRIC_RESETS {1}\
     PS_PCIE_RESET {{ENABLE 1}}\
     PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 42 .. 43}}}\
     PS_USB3_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 13 .. 25}}}\
     PS_USE_FPD_CCI_NOC {0}\
     PS_USE_FPD_CCI_NOC0 {0}\
     PS_USE_NOC_LPD_AXI0 {0}\
     PS_USE_PMCPL_CLK0 {1}\
     PS_USE_PMCPL_IRO_CLK {1}\
     SMON_ALARMS {Set_Alarms_On}\
     SMON_ENABLE_TEMP_AVERAGING {0}\
     SMON_TEMP_AVERAGING_SAMPLES {0}\
   } \
   CONFIG.PS_PMC_CONFIG_APPLIED {1} \
 ] $cips_0

  # Create instance: clockWire_0, and set properties
  set block_name clockWire
  set block_cell_name clockWire_0
  if { [catch {set clockWire_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $clockWire_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: rst_clk_wiz_100M, and set properties
  set rst_clk_wiz_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_100M ]

  # Create instance: rxcommaalignen_out_s_0, and set properties
  set block_name rxcommaalignen_out_shifter
  set block_cell_name rxcommaalignen_out_s_0
  if { [catch {set rxcommaalignen_out_s_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $rxcommaalignen_out_s_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: streaming_gen_consts
  create_hier_cell_streaming_gen_consts [current_bd_instance .] streaming_gen_consts

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_ethernet_0_axi_l_0_m_axi [get_bd_intf_pins axi_ethernet_0/s_axi] [get_bd_intf_pins axi_ethernet_0_axi_l_0/m_axi]
  connect_bd_intf_net -intf_net axi_ethernet_0_gt_rx_interface [get_bd_intf_pins axi_ethernet_0/gt_rx_interface] [get_bd_intf_pins axi_ethernet_0_gt_wrapper/RX0_GT_IP_Interface]
  connect_bd_intf_net -intf_net axi_ethernet_0_gt_tx_interface [get_bd_intf_pins axi_ethernet_0/gt_tx_interface] [get_bd_intf_pins axi_ethernet_0_gt_wrapper/TX0_GT_IP_Interface]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxd [get_bd_intf_pins axi_ethernet_0/m_axis_rxd] [get_bd_intf_pins axi_ethernet_0_strea_0/s_axis_str_gen_d]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxs [get_bd_intf_pins axi_ethernet_0/m_axis_rxs] [get_bd_intf_pins axi_ethernet_0_strea_0/s_axis_str_gen_s]
  connect_bd_intf_net -intf_net axi_ethernet_0_strea_0_m_axis_str_gen_c [get_bd_intf_pins axi_ethernet_0/s_axis_txc] [get_bd_intf_pins axi_ethernet_0_strea_0/m_axis_str_gen_c]
  connect_bd_intf_net -intf_net axi_ethernet_0_strea_0_m_axis_str_gen_d [get_bd_intf_pins axi_ethernet_0/s_axis_txd] [get_bd_intf_pins axi_ethernet_0_strea_0/m_axis_str_gen_d]

  # Create port connections
  connect_bd_net -net axi_ethernet_0_axi_l_0_ex_des_blink_on_tx [get_bd_pins axi_ethernet_0_axi_l_0/ex_des_blink_on_tx] [get_bd_pins axi_ethernet_0_strea_0/ex_des_blink_on_tx]
  connect_bd_net -net axi_ethernet_0_axi_l_0_ex_des_en_slvlb_addr_swap [get_bd_pins axi_ethernet_0_axi_l_0/ex_des_en_slvlb_addr_swap] [get_bd_pins axi_ethernet_0_strea_0/slvlb_en_l2_addr_swap]
  connect_bd_net -net axi_ethernet_0_axi_l_0_ex_des_line_speed [get_bd_pins axi_ethernet_0_axi_l_0/ex_des_line_speed] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_line_speed]
  connect_bd_net -net axi_ethernet_0_axi_l_0_ex_des_mtr_slv_lb_mode [get_bd_pins axi_ethernet_0_axi_l_0/ex_des_mtr_slv_lb_mode] [get_bd_pins axi_ethernet_0_strea_0/loopback_master_slaven]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_chk_en_pkt_drop_chk [get_bd_pins axi_ethernet_0_axi_l_0/pat_chk_en_pkt_drop_chk] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_en_pkt_drop_chk]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_chk_enable [get_bd_pins axi_ethernet_0_axi_l_0/pat_chk_enable] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_en_packet_chk]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_chk_rst_error [get_bd_pins axi_ethernet_0_axi_l_0/pat_chk_rst_error] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_reset_error]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_gen_da_sa_swap_en [get_bd_pins axi_ethernet_0_axi_l_0/pat_gen_da_sa_swap_en] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_da_sa_swap_en]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_gen_en_pkt_types [get_bd_pins axi_ethernet_0_axi_l_0/pat_gen_en_pkt_types] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_select_packet_type]
  connect_bd_net -net axi_ethernet_0_axi_l_0_pat_gen_enable [get_bd_pins axi_ethernet_0_axi_l_0/pat_gen_enable] [get_bd_pins axi_ethernet_0_strea_0/mtrlb_en_packet_gen]
  connect_bd_net -net axi_ethernet_0_axi_l_0_soft_rst_except_to_mmcm [get_bd_pins axi_ethernet_0_axi_l_0/soft_rst_except_to_mmcm] [get_bd_pins axi_ethernet_0_clock_0/soft_rst]
  connect_bd_net -net axi_ethernet_0_clock_0_axi_lite_clk_bufg [get_bd_pins axi_ethernet_0/s_axi_lite_clk] [get_bd_pins axi_ethernet_0_axi_l_0/axi_lite_clk] [get_bd_pins axi_ethernet_0_clock_0/axi_lite_clk_bufg]
  connect_bd_net -net axi_ethernet_0_clock_0_axi_lite_resetn [get_bd_pins axi_ethernet_0/s_axi_lite_resetn] [get_bd_pins axi_ethernet_0_axi_l_0/axi_lite_resetn] [get_bd_pins axi_ethernet_0_clock_0/axi_lite_resetn] [get_bd_pins axi_ethernet_0_suppo_0/resetn]
  connect_bd_net -net axi_ethernet_0_clock_0_axis_clk_bufg [get_bd_pins axi_ethernet_0/axis_clk] [get_bd_pins axi_ethernet_0_clock_0/axis_clk_bufg] [get_bd_pins axi_ethernet_0_gt_wrapper/apb3clk_0] [get_bd_pins axi_ethernet_0_strea_0/axis_clk]
  connect_bd_net -net axi_ethernet_0_clock_0_ref_clk_50_bufg [get_bd_pins axi_ethernet_0/ref_clk] [get_bd_pins axi_ethernet_0_clock_0/ref_clk_50_bufg] [get_bd_pins axi_ethernet_0_suppo_0/ref_clk]
  connect_bd_net -net axi_ethernet_0_gt_wrapper_gt_txn_out_0 [get_bd_pins axi_ethernet_0_gt_wrapper/gt_txn_out_0] [get_bd_pins ch2_to_SFP_only_0/gtytxn_out]
  connect_bd_net -net axi_ethernet_0_gt_wrapper_gt_txp_out_0 [get_bd_pins axi_ethernet_0_gt_wrapper/gt_txp_out_0] [get_bd_pins ch2_to_SFP_only_0/gtytxp_out]
  connect_bd_net -net axi_ethernet_0_gt_wrapper_userclk2 [get_bd_pins axi_ethernet_0/userclk2] [get_bd_pins axi_ethernet_0_gt_wrapper/userclk2]
  connect_bd_net -net axi_ethernet_0_rxpcommaalignen_out [get_bd_pins axi_ethernet_0/rxpcommaalignen_out] [get_bd_pins rxcommaalignen_out_s_0/rxcommaalignen_in_ch2]
  connect_bd_net -net axi_ethernet_0_suppo_0_pma_reset [get_bd_pins axi_ethernet_0/pma_reset] [get_bd_pins axi_ethernet_0_suppo_0/pma_reset]
  connect_bd_net -net axis_vio_0_probe_out0 [get_bd_pins axi_ethernet_0_axi_l_0/cmnd_data] [get_bd_pins axis_vio_0/probe_out0]
  connect_bd_net -net axis_vio_0_probe_out1 [get_bd_pins axi_ethernet_0_axi_l_0/cmnd_data_valid] [get_bd_pins axis_vio_0/probe_out1]
  connect_bd_net -net axis_vio_0_probe_out2 [get_bd_pins axi_ethernet_0_axi_l_0/start_config] [get_bd_pins axis_vio_0/probe_out2]
  connect_bd_net -net bufg_gt_0_usrclk [get_bd_pins axi_ethernet_0/userclk] [get_bd_pins axi_ethernet_0_gt_wrapper/userclk]
  connect_bd_net -net bufg_gt_3_usrclk [get_bd_pins axi_ethernet_0/rxuserclk] [get_bd_pins axi_ethernet_0/rxuserclk2] [get_bd_pins axi_ethernet_0_gt_wrapper/rxuserclk2]
  connect_bd_net -net ch2_to_SFP_only_0_upgraded_ipi_gtyrxn_in [get_bd_pins axi_ethernet_0_gt_wrapper/gt_rxn_in_0] [get_bd_pins ch2_to_SFP_only_0/gtyrxn_in]
  connect_bd_net -net ch2_to_SFP_only_0_upgraded_ipi_sfp_txn [get_bd_ports sfp_txn] [get_bd_pins ch2_to_SFP_only_0/sfp_txn]
  connect_bd_net -net ch2_to_SFP_only_0_upgraded_ipi_sfp_txp [get_bd_ports sfp_txp] [get_bd_pins ch2_to_SFP_only_0/sfp_txp]
  connect_bd_net -net cips_0_pl0_ref_clk [get_bd_pins axis_ila_0/clk] [get_bd_pins axis_vio_0/clk] [get_bd_pins cips_0/pl0_ref_clk] [get_bd_pins clockWire_0/wireIn] [get_bd_pins rst_clk_wiz_100M/slowest_sync_clk]
  connect_bd_net -net cips_0_pl0_resetn [get_bd_pins cips_0/pl0_resetn] [get_bd_pins rst_clk_wiz_100M/ext_reset_in]
  connect_bd_net -net clockWire_0_wireOut [get_bd_pins axi_ethernet_0_clock_0/clk_in1] [get_bd_pins clockWire_0/wireOut]
  connect_bd_net -net gt_quad_base_0_ch0_rxprogdivresetdone [get_bd_pins axi_ethernet_0/gtwiz_reset_rx_done_in] [get_bd_pins axi_ethernet_0_gt_wrapper/ch0_rxprogdivresetdone_0]
  connect_bd_net -net gt_quad_base_0_ch0_txprogdivresetdone [get_bd_pins axi_ethernet_0/gtwiz_reset_tx_done_in] [get_bd_pins axi_ethernet_0_gt_wrapper/ch0_txprogdivresetdone_0]
  connect_bd_net -net gt_quad_base_0_gtpowergood [get_bd_pins axi_ethernet_0/gtpowergood_in] [get_bd_pins axi_ethernet_0_gt_wrapper/gtpowergood] [get_bd_pins axis_ila_0/probe1]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets gt_quad_base_0_gtpowergood]
  connect_bd_net -net gt_quad_base_0_hsclk0_lcplllock [get_bd_pins axi_ethernet_0/cplllock_in] [get_bd_pins axi_ethernet_0_gt_wrapper/hsclk0_lcplllock] [get_bd_pins axis_ila_0/probe2]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets gt_quad_base_0_hsclk0_lcplllock]
  connect_bd_net -net gt_rxp_in_0_1 [get_bd_pins axi_ethernet_0_gt_wrapper/gt_rxp_in_0] [get_bd_pins ch2_to_SFP_only_0/gtyrxp_in]
  connect_bd_net -net gtrefclk_n_0_1 [get_bd_ports gtrefclk_n_0] [get_bd_pins axi_ethernet_0_gt_wrapper/gtrefclk_n_0]
  connect_bd_net -net gtrefclk_p_0_1 [get_bd_ports gtrefclk_p_0] [get_bd_pins axi_ethernet_0_gt_wrapper/gtrefclk_p_0]
  connect_bd_net -net mtrlb_config_dest_addr_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_dest_addr] [get_bd_pins streaming_gen_consts/dout]
  connect_bd_net -net mtrlb_config_ip_dest_addr_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_ip_dest_addr] [get_bd_pins streaming_gen_consts/dout1]
  connect_bd_net -net mtrlb_config_ip_src_addr_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_ip_src_addr] [get_bd_pins streaming_gen_consts/dout2]
  connect_bd_net -net mtrlb_config_max_size_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_max_size] [get_bd_pins streaming_gen_consts/dout3]
  connect_bd_net -net mtrlb_config_min_size_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_min_size] [get_bd_pins streaming_gen_consts/dout4]
  connect_bd_net -net mtrlb_config_src_addr_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_src_addr] [get_bd_pins streaming_gen_consts/dout5]
  connect_bd_net -net mtrlb_config_tcp_dest_port_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_tcp_dest_port] [get_bd_pins streaming_gen_consts/dout6]
  connect_bd_net -net mtrlb_config_tcp_src_port_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_tcp_src_port] [get_bd_pins streaming_gen_consts/dout7]
  connect_bd_net -net mtrlb_config_udp_dest_port_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_udp_dest_port] [get_bd_pins streaming_gen_consts/dout8]
  connect_bd_net -net mtrlb_config_udp_src_port_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_udp_src_port] [get_bd_pins streaming_gen_consts/dout9]
  connect_bd_net -net mtrlb_config_vlan_id_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_vlan_id] [get_bd_pins streaming_gen_consts/dout10]
  connect_bd_net -net mtrlb_config_vlan_priority_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_config_vlan_priority] [get_bd_pins streaming_gen_consts/dout11]
  connect_bd_net -net mtrlb_en_cs_offload_dout [get_bd_pins axi_ethernet_0_strea_0/mtrlb_en_cs_offload] [get_bd_pins streaming_gen_consts/dout13]
  connect_bd_net -net rst_clk_wiz_100M_1_peripheral_aresetn [get_bd_pins axi_ethernet_0/axi_rxd_arstn] [get_bd_pins axi_ethernet_0/axi_rxs_arstn] [get_bd_pins axi_ethernet_0/axi_txc_arstn] [get_bd_pins axi_ethernet_0/axi_txd_arstn] [get_bd_pins axi_ethernet_0_clock_0/axis_rstn] [get_bd_pins axi_ethernet_0_strea_0/axi_rxd_arstn] [get_bd_pins axi_ethernet_0_strea_0/axi_rxs_arstn] [get_bd_pins axi_ethernet_0_strea_0/axi_txc_arstn] [get_bd_pins axi_ethernet_0_strea_0/axi_txd_arstn]
  connect_bd_net -net rst_clk_wiz_100M_peripheral_aresetn [get_bd_pins rst_clk_wiz_100M/peripheral_aresetn] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net rxcommaalignen_out_s_0_gpi_out [get_bd_pins axi_ethernet_0_gt_wrapper/gpi_0] [get_bd_pins rxcommaalignen_out_s_0/gpi_out]
  connect_bd_net -net sfp_rxn_1 [get_bd_ports sfp_rxn] [get_bd_pins ch2_to_SFP_only_0/sfp_rxn]
  connect_bd_net -net sfp_rxp_1 [get_bd_ports sfp_rxp] [get_bd_pins ch2_to_SFP_only_0/sfp_rxp]
  connect_bd_net -net status_vector [get_bd_pins axi_ethernet_0/status_vector] [get_bd_pins axis_ila_0/probe0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets status_vector]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axi_ethernet_0_clock_0/sys_rst] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_ethernet_0/mmcm_locked] [get_bd_pins axi_ethernet_0/signal_detect] [get_bd_pins axi_ethernet_0_suppo_0/locked] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins axi_ethernet_0_gt_wrapper/ch2_loopback] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_ports SFP0_TX_DISABLE] [get_bd_pins xlconstant_2/dout]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_ethernet_0_axi_l_0/m_axi] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


