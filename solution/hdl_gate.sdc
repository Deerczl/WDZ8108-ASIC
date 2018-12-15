# ####################################################################

#  Created by Encounter(R) RTL Compiler v12.10-p006_1 on Tue Nov 20 18:32:36 -0800 2018

# ####################################################################

set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design led_top

create_clock -name "clk" -add -period 5000.0 -waveform {0.0 2500.0} [get_ports clk]
set_load -pin_load -max 0.005 [get_ports led]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports key_key]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports key_os]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports rst_n]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports clk]
set_output_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports led]
set_wire_load_mode "enclosed"
set_dont_use [get_lib_cells typical/HOLDX1]
