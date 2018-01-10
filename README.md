# Vending Machine

We  designed a sequential circuit for a simple vending machine and implement it using
Verilog HDL. The vending machine can deliver 3 different products: tea, coffee and hot
chocolate. It has a single coin slot that accepts one coin (25 Krş, 50 Krş or 100 Krş) at a time.
The prices of tea, coffee and hot chocolate are 50 Krş, 75 Krş and 100 Krş, respectively.

First, you will use push buttons on the FPGA board to select the product you want to
purchase. You will use BTN1 for tea, BTN2 for coffee and BTN3 for hot chocolate. 

Then, you will again use push buttons on the FPGA board to insert coin to the vending
machine. You will use BTN1 for 25 Krş, BTN2 for 50 Krş and BTN3 for 100 Krş. The
following table shows the input combinations for coins.

You cannot press two push buttons simultaneously. When the total value of inserted coins is
50 Krş or more for the product tea, the vending machine delivers the product and returns coin
if necessary. Similarly, when the total value of inserted coins is 75 Krş or more for the
product coffee and 100 Krş or more for the product hot chocolate, the vending machine
delivers the product and returns coin if necessary.

The sequential circuit starts from ‘no product’ state. You should use Reset BTN as an
asynchronous reset input to put the sequential circuit into ‘no product’ initial state. When a
product is delivered, the sequential circuit should go to ‘product delivered’ state and it should
stay in this state until asynchronous reset is applied. This state is used to keep product output
as 1 when a product is delivered.

The sequential circuit have product output. This output is 1 whenever a
product is delivered, otherwise it is 0. We used LED 4 to show whether product
output is 1 or 0. We used LED7, LED6 and LED5 to show which product is selected. If
you select tea, LED7 will be on. If you select coffee, LED6 will be on. If you select hot
chocolate, LED5 will be on.

The sequential circuit also outputs the total value of inserted coins for a product in
terms of Krş and the total value of returned coins for a product in terms of Krş after a product
is delivered. These outputs will be shown on Seven Segment Displays (SSDs) on FPGA
board. For example, if you inserted two 25 Krş coins for the product coffee, you should see ’
0 - - ‘ on SSDs. Then, if you insert another 50 Krş coin for the same product, the product
should be delivered and 25 Krş should be returned. Therefore, you should see ‘- - 25’ on
SSDs. 

Using 7-bit ‘abcdefg’ control signals, you can display different digits and signs on an SSD. For example, ‘abcdefg’ should
be ‘0000001’ in order to display 0 and ‘0000110’ in order to display 3. There are four SSDs
on the FPGA board. First two SSDs should be used to display the total value of inserted coins
for a product while the last two SSDs should be used to display the total value of returned
coins for a product. Your Verilog module should have 7-bit output for each SSD; digit1 and
digit2 for the first and second decimal digits of the total value of inserted coins for a product,
digit3 and digit4 for the first and second decimal digits of the total value of returned coins for
a product.

Even though you press a push button on the FPGA board once, more than one logic 1 inputs
may be given to your sequential circuit. Verilog codes in the “debouncer.v” and
“clk_divider.v” provided to you solve this problem. When simulating your sequential circuit
do not use “debouncer.v” and “clk_divider.v”. You should use them when implementing your
sequential circuit on the FPGA.
