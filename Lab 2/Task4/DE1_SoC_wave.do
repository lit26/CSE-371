onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/clk
add wave -noupdate -label w {/DE1_SoC_testbench/dut/SW[9]}
add wave -noupdate -expand -group wadd {/DE1_SoC_testbench/dut/SW[8]}
add wave -noupdate -expand -group wadd {/DE1_SoC_testbench/dut/SW[7]}
add wave -noupdate -expand -group wadd {/DE1_SoC_testbench/dut/SW[6]}
add wave -noupdate -expand -group wadd {/DE1_SoC_testbench/dut/SW[5]}
add wave -noupdate -expand -group wadd {/DE1_SoC_testbench/dut/SW[4]}
add wave -noupdate -expand -group din {/DE1_SoC_testbench/dut/SW[3]}
add wave -noupdate -expand -group din {/DE1_SoC_testbench/dut/SW[2]}
add wave -noupdate -expand -group din {/DE1_SoC_testbench/dut/SW[1]}
add wave -noupdate -expand -group din {/DE1_SoC_testbench/dut/SW[0]}
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate /DE1_SoC_testbench/HEX4
add wave -noupdate /DE1_SoC_testbench/HEX3
add wave -noupdate /DE1_SoC_testbench/HEX2
add wave -noupdate /DE1_SoC_testbench/HEX1
add wave -noupdate /DE1_SoC_testbench/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {219 ps} 0}
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
WaveRestoreZoom {2643 ps} {3387 ps}
