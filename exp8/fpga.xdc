## This file is a general .xdc for the Nexys4 DDR Rev. C on FPGAOL_v1.1
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
## docs on https://github.com/fandahao17/FPGAOL-Examples

## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];


##leds, connecting to the led

#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L20N_T3_A19_15 Sch=led[0]
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L21N_T3_DQS_A18_15 Sch=led[1]
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21P_T3_DQS_15 Sch=led[2]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L18N_T2_A23_15 Sch=led[3]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { led[4] }]; #IO_L16N_T2_A27_15 Sch=led[4]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { led[5] }]; #IO_L16P_T2_A28_15 Sch=led[5]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { led[6] }]; #IO_L22N_T3_A16_15 Sch=led[6]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { led[7] }]; #IO_L22P_T3_A17_15 Sch=led[7]


##Switches, only need four switches

set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { increment }]; #IO_L1P_T0_AD0P_15 Sch=sw[0]
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L14N_T2_SRCC_15 Sch=sw[1]
#set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]; #IO_L13N_T2_MRCC_15 Sch=sw[2]
#set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; #IO_L15P_T2_DQS_15 Sch=sw[3]
#set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { sw[4] }]; #IO_L11N_T1_SRCC_15 Sch=sw[4]
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { sw[5] }]; #IO_L5P_T0_AD9P_15 Sch=sw[5]
#set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { sw[6] }]; #IO_0_15 Sch=sw[6]
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sw[7] }]; #IO_L13P_T2_MRCC_15 Sch=sw[7]


##Hex_play

set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVDS     } [get_ports { D[0] }]; #IO_L9N_T1_DQS_AD3N_15 Sch=d[0]
set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVDS     } [get_ports { D[1] }]; #IO_L9P_T1_DQS_AD3P_15 Sch=d[1]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVDS     } [get_ports { D[2] }]; #IO_L8N_T1_AD10N_15 Sch=d[2]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVDS     } [get_ports { D[3] }]; #IO_L8P_T1_AD10P_15 Sch=d[3]
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVDS     } [get_ports { AN[0] }]; #IO_L7N_T1_AD2N_15 Sch=an[0]
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVDS     } [get_ports { AN[1] }]; #IO_L7P_T1_AD2P_15 Sch=an[1]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVDS     } [get_ports { AN[2] }]; #IO_L10N_T1_AD11N_15 Sch=an[2]


## Button

set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { button }]; #IO_L10P_T1_AD11P_15 Sch=btn


## Seg_play
## Seg_play share port with leds, refer https://github.com/fandahao17/FPGAOL-Examples#seg_play


## Soft Clock
## ref https://github.com/fandahao17/FPGAOL-Examples#%E8%BD%AF%E6%97%B6%E9%92%9F%E4%B8%8E%E6%8C%89%E9%92%AE
