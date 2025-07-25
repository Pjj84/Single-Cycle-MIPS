#push buttons on the main board:
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN U18 [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports {button_mb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_mb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_mb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_mb[3]}]

set_property PACKAGE_PIN T14 [get_ports {button_mb[0]}]
set_property PACKAGE_PIN T15 [get_ports {button_mb[1]}]
set_property PACKAGE_PIN T11 [get_ports {button_mb[2]}]
set_property PACKAGE_PIN T10 [get_ports {button_mb[3]}]


#push buttons on the extension board:
set_property IOSTANDARD LVCMOS33 [get_ports button_1]
set_property IOSTANDARD LVCMOS33 [get_ports button_2]

set_property PACKAGE_PIN J20 [get_ports button_1]
set_property PACKAGE_PIN H20 [get_ports button_2]


#dip switches on the extension board:
set_property IOSTANDARD LVCMOS33 [get_ports {dip[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip[7]}]

set_property PACKAGE_PIN M20 [get_ports {dip[0]}]
set_property PACKAGE_PIN M19 [get_ports {dip[1]}]
set_property PACKAGE_PIN L20 [get_ports {dip[2]}]
set_property PACKAGE_PIN L19 [get_ports {dip[3]}]
set_property PACKAGE_PIN M15 [get_ports {dip[4]}]
set_property PACKAGE_PIN M14 [get_ports {dip[5]}]
set_property PACKAGE_PIN J14 [get_ports {dip[6]}]
set_property PACKAGE_PIN K14 [get_ports {dip[7]}]


#leds on the main board:
set_property IOSTANDARD LVCMOS33 [get_ports {led_mb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_mb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_mb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_mb[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_mb[4]}]

set_property PACKAGE_PIN V17 [get_ports {led_mb[0]}]
set_property PACKAGE_PIN V18 [get_ports {led_mb[1]}]
set_property PACKAGE_PIN W18 [get_ports {led_mb[2]}]
set_property PACKAGE_PIN W19 [get_ports {led_mb[3]}]
set_property PACKAGE_PIN V20 [get_ports {led_mb[4]}]


#leds on the extension board:
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]

set_property PACKAGE_PIN G18 [get_ports {led[0]}]
set_property PACKAGE_PIN G17 [get_ports {led[1]}]
set_property PACKAGE_PIN E19 [get_ports {led[2]}]
set_property PACKAGE_PIN E18 [get_ports {led[3]}]
set_property PACKAGE_PIN D18 [get_ports {led[4]}]
set_property PACKAGE_PIN E17 [get_ports {led[5]}]
set_property PACKAGE_PIN B20 [get_ports {led[6]}]
set_property PACKAGE_PIN C20 [get_ports {led[7]}]
set_property PACKAGE_PIN N16 [get_ports {led[8]}]
set_property PACKAGE_PIN N15 [get_ports {led[9]}]


#7-Segments on the extension board:
set_property IOSTANDARD LVCMOS33 [get_ports dig0]
set_property IOSTANDARD LVCMOS33 [get_ports dig1]
set_property IOSTANDARD LVCMOS33 [get_ports dig2]
set_property IOSTANDARD LVCMOS33 [get_ports dig3]
set_property IOSTANDARD LVCMOS33 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports b]
set_property IOSTANDARD LVCMOS33 [get_ports c]
set_property IOSTANDARD LVCMOS33 [get_ports d]
set_property IOSTANDARD LVCMOS33 [get_ports e]
set_property IOSTANDARD LVCMOS33 [get_ports f]
set_property IOSTANDARD LVCMOS33 [get_ports g]
set_property IOSTANDARD LVCMOS33 [get_ports colon]

set_property PACKAGE_PIN D20 [get_ports dig0]
set_property PACKAGE_PIN D19 [get_ports dig1]
set_property PACKAGE_PIN G20 [get_ports dig2]
set_property PACKAGE_PIN B19 [get_ports dig3]
set_property PACKAGE_PIN F16 [get_ports a]
set_property PACKAGE_PIN F17 [get_ports b]
set_property PACKAGE_PIN H15 [get_ports c]
set_property PACKAGE_PIN G15 [get_ports d]
set_property PACKAGE_PIN J18 [get_ports e]
set_property PACKAGE_PIN H18 [get_ports f]
set_property PACKAGE_PIN H16 [get_ports g]
set_property PACKAGE_PIN H17 [get_ports colon]


#display on the extension board (Note that these pins are shared with pins assigned to a,b,c,d,e,f,g. So one of them should be assigned at a time):
#set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}];

#set_property PACKAGE_PIN H16 [get_ports {display[0]}];
#set_property PACKAGE_PIN H18 [get_ports {display[1]}];
#set_property PACKAGE_PIN J18 [get_ports {display[2]}];
#set_property PACKAGE_PIN G15 [get_ports {display[3]}];
#set_property PACKAGE_PIN H15 [get_ports {display[4]}];
#set_property PACKAGE_PIN F17 [get_ports {display[5]}];
#set_property PACKAGE_PIN F16 [get_ports {display[6]}];

create_clock -period 20.000 -name mojtabaclock [get_ports clk]
