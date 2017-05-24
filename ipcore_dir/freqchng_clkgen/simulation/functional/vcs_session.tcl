gui_open_window Wave
gui_sg_create freqchng_clkgen_group
gui_list_add_group -id Wave.1 {freqchng_clkgen_group}
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.test_phase}
gui_set_radix -radix {ascii} -signals {freqchng_clkgen_tb.test_phase}
gui_sg_addsignal -group freqchng_clkgen_group {{Input_clocks}} -divider
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.CLK_IN1}
gui_sg_addsignal -group freqchng_clkgen_group {{Output_clocks}} -divider
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.dut.clk}
gui_list_expand -id Wave.1 freqchng_clkgen_tb.dut.clk
gui_sg_addsignal -group freqchng_clkgen_group {{Status_control}} -divider
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.RESET}
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.LOCKED}
gui_sg_addsignal -group freqchng_clkgen_group {{Counters}} -divider
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.COUNT}
gui_sg_addsignal -group freqchng_clkgen_group {freqchng_clkgen_tb.dut.counter}
gui_list_expand -id Wave.1 freqchng_clkgen_tb.dut.counter
gui_zoom -window Wave.1 -full
