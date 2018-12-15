######################################################################

# Created by Encounter(R) RTL Compiler v12.10-p006_1 on Tue Nov 20 18:32:36 -0800 2018

# This file contains the RC script for /designs/led_top

######################################################################

set_attribute -quiet information_level 9 /
set_attribute -quiet gui_auto_update false /
set_attribute -quiet lib_search_path ./lib/ /
set_attribute -quiet gen_module_prefix G2C_DP_ /
set_attribute -quiet ple_correlation_factors {1.9000 2.0000} /
set_attribute -quiet maximum_interval_of_vias infinity /
set_attribute -quiet interconnect_mode wireload /
set_attribute -quiet wireload_mode enclosed /
set_attribute -quiet tree_type balanced_tree /libraries/typical/operating_conditions/typical
set_attribute -quiet tree_type balanced_tree /libraries/typical/operating_conditions/_nominal_
# BEGIN MSV SECTION
# END MSV SECTION
define_clock -name clk -domain domain_1 -period 5000000.0 -divide_period 1 -rise 0 -divide_rise 1 -fall 1 -divide_fall 2 -design /designs/led_top /designs/led_top/ports_in/clk
external_delay -accumulate -input {2000.0 2000.0 2000.0 2000.0} -clock /designs/led_top/timing/clock_domains/domain_1/clk -name in_del_1 {/designs/led_top/ports_in/key_key /designs/led_top/ports_in/key_os /designs/led_top/ports_in/rst_n /designs/led_top/ports_in/clk}
external_delay -accumulate -output {2000.0 2000.0 2000.0 2000.0} -clock /designs/led_top/timing/clock_domains/domain_1/clk -name ou_del_1 /designs/led_top/ports_out/led
# BEGIN DFT SECTION
set_attribute -quiet dft_scan_style muxed_scan /
set_attribute -quiet dft_scanbit_waveform_analysis false /
# END DFT SECTION
set_attribute -quiet hdl_user_name led_top /designs/led_top
set_attribute -quiet hdl_filelist {{default -v1995 {SYNTHESIS} {RTL/led_top.v}} {default -v1995 {SYNTHESIS} {RTL/led_func.v}} {default -v1995 {SYNTHESIS} {RTL/key_filter.v}}} /designs/led_top
set_attribute -quiet ovf_current_verification_directory fv/led_top /designs/led_top
set_attribute -quiet external_pin_cap {5.0 5.0} /designs/led_top/ports_out/led
set_attribute -quiet hdl_user_name key_filter /designs/led_top/subdesigns/key_filter_1
set_attribute -quiet hdl_parameters {{IDLE 2'h0 0 2'h0} {W_LOW 2'h1 0 2'h1} {W_HIG 2'h3 0 2'h3} {S_HIG 2'h2 0 2'h2}} /designs/led_top/subdesigns/key_filter_1
set_attribute -quiet hdl_filelist {{default -v1995 {SYNTHESIS} {RTL/key_filter.v}}} /designs/led_top/subdesigns/key_filter_1
set_attribute -quiet hdl_user_name key_filter /designs/led_top/subdesigns/key_filter
set_attribute -quiet hdl_parameters {{IDLE 2'h0 0 2'h0} {W_LOW 2'h1 0 2'h1} {W_HIG 2'h3 0 2'h3} {S_HIG 2'h2 0 2'h2}} /designs/led_top/subdesigns/key_filter
set_attribute -quiet hdl_filelist {{default -v1995 {SYNTHESIS} {RTL/key_filter.v}}} /designs/led_top/subdesigns/key_filter
set_attribute -quiet hdl_user_name led_func /designs/led_top/subdesigns/led_func
set_attribute -quiet hdl_parameters {{IDLE 2'h0 0 2'h0} {KEY 2'h1 0 2'h1} {OS 2'h3 0 2'h3}} /designs/led_top/subdesigns/led_func
set_attribute -quiet hdl_filelist {{default -v1995 {SYNTHESIS} {RTL/led_func.v}}} /designs/led_top/subdesigns/led_func
