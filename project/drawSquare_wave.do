onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /drawPuzzle_testbench/clk
add wave -noupdate /drawPuzzle_testbench/reset
add wave -noupdate -radix unsigned /drawPuzzle_testbench/x
add wave -noupdate -radix unsigned /drawPuzzle_testbench/y
add wave -noupdate /drawPuzzle_testbench/drawPuzzle_done
add wave -noupdate -radix unsigned /drawPuzzle_testbench/dut/index
add wave -noupdate /drawPuzzle_testbench/control
add wave -noupdate /drawPuzzle_testbench/dut/getshuffleData/empty_po
add wave -noupdate /drawPuzzle_testbench/dut/original_position
add wave -noupdate /drawPuzzle_testbench/dut/movingPosition
add wave -noupdate -radix unsigned /drawPuzzle_testbench/empty_position
add wave -noupdate -radix unsigned /drawPuzzle_testbench/dut/switchPosition
add wave -noupdate /drawPuzzle_testbench/dut/movingPosition
add wave -noupdate /drawPuzzle_testbench/dut/moving_data
add wave -noupdate /drawPuzzle_testbench/dut/moving_data1
add wave -noupdate /drawPuzzle_testbench/dut/clear
add wave -noupdate /drawPuzzle_testbench/dut/legal
add wave -noupdate -radix unsigned /drawPuzzle_testbench/dut/shuffle_index
add wave -noupdate /drawPuzzle_testbench/dut/fifteenSq/draw_done
add wave -noupdate /drawPuzzle_testbench/dut/address
add wave -noupdate /drawPuzzle_testbench/dut/ps
add wave -noupdate /drawPuzzle_testbench/dut/ns
add wave -noupdate /drawPuzzle_testbench/dut/overwrite
add wave -noupdate -radix unsigned /drawPuzzle_testbench/dut/q
add wave -noupdate /drawPuzzle_testbench/dut/wren
add wave -noupdate -radix unsigned /drawPuzzle_testbench/dut/data
add wave -noupdate -radix unsigned -childformat {{{/drawPuzzle_testbench/dut/readWrite/valueArray[15]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[14]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[13]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[12]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[11]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[10]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[9]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[8]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[7]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[6]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[5]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[4]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[3]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[2]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[1]} -radix unsigned} {{/drawPuzzle_testbench/dut/readWrite/valueArray[0]} -radix unsigned}} -subitemconfig {{/drawPuzzle_testbench/dut/readWrite/valueArray[15]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[14]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[13]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[12]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[11]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[10]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[9]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[8]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[7]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[6]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[5]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[4]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[3]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[2]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[1]} {-height 15 -radix unsigned} {/drawPuzzle_testbench/dut/readWrite/valueArray[0]} {-height 15 -radix unsigned}} /drawPuzzle_testbench/dut/readWrite/valueArray
add wave -noupdate /drawPuzzle_testbench/dut/fifteenSq/ps
add wave -noupdate /drawPuzzle_testbench/dut/fifteenSq/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1035705 ps} 0}
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
WaveRestoreZoom {583398 ps} {1443558 ps}
