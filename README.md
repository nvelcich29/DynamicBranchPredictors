# DynamicBranchPredictors
HDL Implementation of Dynamic Branch Predictors

## Overview
Branches in programs have the potential to be a major source of poor performance in a system. Branch prediction is a way to avoid these poor performance pitfalls by preemptively loading instructions following a branch according to some prediction scheme. Dynamic branch prediction describes a branch prediction scheme that changes the prediction, either branch taken or branch not taken, based on some previous data. This project explores three different types of dynamic branch prediction schemes: 1-bit, 2-bit, and (3,2) correlating predictors. These predictors were built from scratch using VHDL hardware description language and simulated using [ModelSim](https://eda.sw.siemens.com/en-US/ic/modelsim/) software. In order to achieve this, the prediction concepts had to be converted to hardware devices that would perform the function necessary for each prediction scheme. This was done with mux, counters, and shift register devices. Test bench programs were written in VHDL to test the prediction schemes for correctness and performance. The branches of a simple nested for loop algorithm were recorded to a .txt file using python.  This .txt file was imported into the test bench programs and used as a test sample of branch outcomes.  Finally, the algorithm that was implemented in python was also implemented in RISCV assembly language to further illustrate where the branch decisions will be taking place.  

## Branch predictor schemes
A one bit predictor can be thought of as a finite state machine with only two states. These states
can be represented as state ‘0’ and state ‘1’. This finite state machine takes an input of ‘0’ or ‘1’. This
finite state machine is illustrated below:

![1-bit fsm](https://user-images.githubusercontent.com/46805337/129281481-f95fda8c-747a-4ca1-81bf-5460c5ca0b90.png)


The 2-bit prediction scheme is a saturating counter. The scheme can be thought of as a finite
state machine with four states: T*, T*N, N*T, N*. The finite state machine can be seen below:

![image](https://user-images.githubusercontent.com/46805337/129281287-1e59ff04-92cd-4229-a6dd-1a529d24563f.png)

Essentially, the 2-bit predictor keeps track of the last two branch decisions taken by the program. There
are strong taken and strong not taken at the ends of the FSM and weak taken and not taken in the
middle states of the FSM.

The (3,2) correlating branch predictor uses two metrics to predict the next branch outcome: the
last three global branch decisions as well as a local 2-bit branch predictor. The global branch decisions
are based on the last three branch decisions regardless of which branch made that decision. The local
2-bit branch predictor only updates when a single particular branch is taken. Given this configuration,
each branch will have 8 independent 2-bit branch predictors based on the 8 possible outcomes of the
last three branch decisions: NT NT NT, NT NT T, NT T NT, NT T T, T NT NT, T NT T, T T NT, T T T.

## Usage
First, the python script test.py should be ran to produce the test.txt file for the test branch outcomes.  Then, as long as all the files are in the same folder, the test bench programs should run on any VHDL simulator but it has only been tested using ModelSim software.  The format of the test input is B{1 or 2} {T or NT}, e.g.:
```B1 T```
would represent that branch 1 was taken.  Given this format, one could create their own branch outcomes for testing.  

