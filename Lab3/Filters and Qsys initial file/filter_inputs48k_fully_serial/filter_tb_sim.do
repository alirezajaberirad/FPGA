onbreak resume
onerror resume
vsim -novopt work.filter_tb
add wave sim:/filter_tb/u_filter_inputs48k_fully_serial/clk
add wave sim:/filter_tb/u_filter_inputs48k_fully_serial/clk_enable
add wave sim:/filter_tb/u_filter_inputs48k_fully_serial/reset
add wave sim:/filter_tb/u_filter_inputs48k_fully_serial/filter_in
add wave sim:/filter_tb/u_filter_inputs48k_fully_serial/filter_out
add wave sim:/filter_tb/filter_out_ref
run -all
