# Iterative implementation of triangular numbers

# write some data into regs to test recovery
ADDI a1, x0, 110
ADDI a2, x0, 100

ADDI a0, x0, 5  # run for i = 5
JAL ra, Calc    # call function first time
JAL ra, Calc    # call function second time
JAL x0, END



Calc:
# setup
ADDI sp,sp,-8   # decrease stack pointer
SW a2,4(sp)
SW a1,0(sp)
ADDI a2, x0, 1
ADD a1, x0, a0
ADD a0, x0, x0

Loop:
BLT a1, a2, Cleanup     # a1 < a2 ?
ADD a0, a0, a2          # a0 = a0 + a2
ADDI a2, a2, 1          # a2++
JAL x0, Loop

Cleanup:
LW a2,4(sp)
LW a1,0(sp)
ADDI sp,sp,8
JALR x0, x1, 0




END:
# needed for Venus Interpreter
nop     # for break point to view registers

# print result and exit with code 0
addi a1, a0, 0          # copy a0
addi a0, x0, 1          # print a1
ecall
addi a1, x0, 0x0A       # Line Feed
addi a0, x0, 11         # print a1
ecall
ecall

addi a0, x0, 10         # exit code 0
ecall