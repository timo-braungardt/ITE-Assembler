# Recursive implementation of triangular numbers

# write some data into regs to test recovery
ADDI a1, x0, 110
ADDI a2, x0, 100

ADDI a0, x0, 15     # run for i = 15
JAL ra, Calc        # call function
JAL x0, END




# recursive function
Calc:

# return to caller
JALR x0, ra, 0




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