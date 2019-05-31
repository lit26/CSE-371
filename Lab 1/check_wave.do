onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /check_testbench/clk
add wave -noupdate /check_testbench/enter
add wave -noupdate /check_testbench/exit
add wave -noupdate /check_testbench/a
add wave -noupdate /check_testbench/b
add wave -noupdate /check_testbench/dut/ps
add wave -noupdate /check_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {388 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 76
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
WaveRestoreZoom {0 ps} {1089 ps}
