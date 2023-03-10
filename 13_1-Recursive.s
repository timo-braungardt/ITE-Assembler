# Recursive implementation of triangular numbers

# write some data into regs to test recovery
ADDI a1, x0, 110
ADDI a2, x0, 100

ADDI a0, x0, 15     # run for i = 15
JAL ra, Calc        # call function
JAL x0, END



# recursive function
Calc:
ADDI sp, sp, -12      # sichern der Register
SW ra, 0(sp)
SW a1, 4(sp)
SW a2, 8(sp)

Logic:
ADDI a1, a0, 0      # save own i
ADDI a2, x0, 1      # (const for base case check)
BEQ a0, a2, BaseCase        # is a0 == 1?
# if not - recursive call with i-1
ADDI a0, a0, -1
JAL ra, Calc        # call function

# return of the recursion - add own value to returned var of a0 
ADD a0, a0, a1
JAL x0, Cleanup

BaseCase:
ADDI a0, x0, 1      # return auf 1 setzen (unnötig) 

Cleanup:
LW ra, 0(sp)
LW a1, 4(sp)
LW a2, 8(sp)
ADDI sp, sp, 12      # wiederherstellen der Register
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