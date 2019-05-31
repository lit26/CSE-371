onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /shuffle_testbench/clk
add wave -noupdate -radix hexadecimal /shuffle_testbench/shuffle_index
add wave -noupdate -radix hexadecimal -childformat {{{/shuffle_testbench/dut/shuffle_ram[7]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[6]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[5]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[4]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[3]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[2]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[1]} -radix hexadecimal} {{/shuffle_testbench/dut/shuffle_ram[0]} -radix hexadecimal}} -subitemconfig {{/shuffle_testbench/dut/shuffle_ram[7]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[6]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[5]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[4]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[3]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[2]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[1]} {-height 15 -radix hexadecimal} {/shuffle_testbench/dut/shuffle_ram[0]} {-height 15 -radix hexadecimal}} /shuffle_testbench/dut/shuffle_ram
add wave -noupdate /shuffle_testbench/dut/shuffle_puzzle
add wave -noupdate -radix unsigned /shuffle_testbench/dut/address
add wave -noupdate -radix unsigned /shuffle_testbench/dut/data
add wave -noupdate -radix unsigned /shuffle_testbench/dut/q
add wave -noupdate /shuffle_testbench/dut/wren
add wave -noupdate /shuffle_testbench/done
add wave -noupdate /shuffle_testbench/dut/shuffleDone
add wave -noupdate /shuffle_testbench/dut/ps
add wave -noupdate /shuffle_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1450 ps} 0}
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
WaveRestoreZoom {2400 ps} {3400 ps}
