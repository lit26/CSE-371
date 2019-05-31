onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /line_move_testbench/clk
add wave -noupdate /line_move_testbench/reset
add wave -noupdate /line_move_testbench/move
add wave -noupdate /line_move_testbench/clear
add wave -noupdate -radix decimal /line_move_testbench/x0
add wave -noupdate -radix decimal /line_move_testbench/y0
add wave -noupdate -radix decimal /line_move_testbench/x
add wave -noupdate -radix decimal /line_move_testbench/y
add wave -noupdate /line_move_testbench/dut/ps
add wave -noupdate /line_move_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82620 ps} 0}
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
WaveRestoreZoom {82450 ps} {86450 ps}
