onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /drawNumber_testbench/clk
add wave -noupdate /drawNumber_testbench/start
add wave -noupdate -radix unsigned /drawNumber_testbench/value
add wave -noupdate -radix unsigned /drawNumber_testbench/x
add wave -noupdate -radix unsigned /drawNumber_testbench/y
add wave -noupdate /drawNumber_testbench/number_done
add wave -noupdate /drawNumber_testbench/dut/x0
add wave -noupdate /drawNumber_testbench/dut/y0
add wave -noupdate /drawNumber_testbench/dut/x1
add wave -noupdate /drawNumber_testbench/dut/y1
add wave -noupdate /drawNumber_testbench/dut/x_pre
add wave -noupdate /drawNumber_testbench/dut/y_pre
add wave -noupdate /drawNumber_testbench/dut/ps
add wave -noupdate /drawNumber_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {224035 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {195583 ps} {252487 ps}
