onbreak resume
onerror resume
vsim -novopt work.filter_tb
add wave sim:/filter_tb/u_filter_fully_parallel/clk
add wave sim:/filter_tb/u_filter_fully_parallel/clk_enable
add wave sim:/filter_tb/u_filter_fully_parallel/reset
add wave sim:/filter_tb/u_filter_fully_parallel/filter_in
add wave sim:/filter_tb/u_filter_fully_parallel/filter_out
add wave sim:/filter_tb/filter_out_ref
run -all
