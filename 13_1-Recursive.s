# Recursive implementation of triangular numbers

# write some data into regs to test recovery
ADDI a1, x0, 110
ADDI a2, x0, 100

ADDI a0, x0, 15     # run for i = 15
JAL ra, Calc        # call function
JAL x0, END




Calc:
# recursive call
ADDI sp,sp,-12      # decrement stack pointer
SW ra, 8(sp)
SW a2, 4(sp)
SW a1, 0(sp)
ADDI a1, a0, 0      # save own i
ADDI a2, x0, 1      # (const for base case check)
# Logic
BEQ a0, a2, BaseCase    # is a0 == 1?
ADDI a0, a0, -1
JAL ra, Calc        # recursive call with i-1

# return of the recursion
ADD a0, a0, a1      # add own i on returned value
JAL x0, Cleanup


# i == 1
BaseCase:
ADDI a0, x0, 1      # return auf 1 setzen (unnötig) 

Cleanup:
LW ra, 8(sp)
LW a2, 4(sp)
LW a1, 0(sp)
ADDI sp,sp,12
JALR x0, ra, 0      # return to caller




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