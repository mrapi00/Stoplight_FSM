# Stoplight_FSM
Designing a finite state machine (FSM) implement a controller for the traffic light at the intersection of two roads.

Compilation:
iverilog -g2005 -Wall -Wno-timescale -o StoplightTATest StoplightTA.t.v

Run:
vvp StoplightTATest

Viewing Simulation on GTKWave:
gtkwave StoplightTATest.vcd
