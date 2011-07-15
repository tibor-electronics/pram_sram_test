# Verilog project to test the SRAM chip on the Papilio RAM board

This project serves as a basic sanity check for the data and address lines going from the Spartan 3A on the Papilio RAM board to the board's SRAM chip. A collection of bit patterns are written to all addresses, one pattern at a time. Once the pattern has been written, all addresses are read and compared to the current pattern. If the SRAM data and pattern do not match, the process is halted.

## Output

* The current address is displayed on a 4-digit 7-segment display plus two LEDs for the two high bits. 
* The current value is displayed on a 4-digit 7-segment display as well.
* Two more LEDs are used to show "good" and "bad" conditions.

## Wiring

Note that the following refers to pin locations by wing slot and pin index. In the links selection below, it may be helpful to follow along using the Papilio RAM pin diagram.

At a minimum, you will need a Papilio RAM board and a single Button/LED wing. Richer information is provided if you have any 7-segment displays handy.

* Connect the address' digit select pins so that A[12:15] = anode1[3:0]
* Connect the address' segment pins so that A[5:11] = segments1[6:0]
* Connect the value's digit select pins so that B[3:0] = anode2[3:0]
* Connect the value's segment pins so that B[10:4] = segments2[6:0]
* Connect the B/LED wing into slot DL

## Usage

Once the bit file has been loaded on the board, you will need to press PB1 to reset the board. This starts the pattern tests. The board runs at 100MHz and writes take 2-3 clocks, depending on how you count. Reads are purposely slowed down to make it easier to see that part of the process. This could easily run at full speed.

## Links

* [Papilio RAM Pin Diagram](https://github.com/thelonious/papilio_pins/raw/master/Papilio-RAM-Pins.png)
* [Papilio Platform](http://www.gadgetfactory.net)
* [Button/LED Wing](http://www.gadgetfactory.net/index.php?main_page=product_info&cPath=4&products_id=10)
* [4-digit 7-segment LED](http://www.sparkfun.com/products/9480) - Multiple colors available
* [Papilio.cc](http://papilio.cc/)