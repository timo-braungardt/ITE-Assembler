JAL ra, SETUP

# set characters to compare
ADDI a1, x0, 0x45   # E
ADDI a2, x0, 0x54   # T
ADDI a3, x0, 0x49   # I
# set states ?
ADDI x20, x0, 0     # _Start
ADDI x21, x0, 1     # E
ADDI x22, x0, 2     # ET
ADDI x23, x0, 3     # ETI

ADDI a5, x0, 0      # Set start state

Start:
# load data
LB x1, 0(sp)
ADDI sp, sp, 4
BEQ x1, x0, END     # if 0 then terminate

# check state
BEQ a5, x20, _Start
BEQ a5, x21, E
BEQ a5, x22, ET
BEQ a5, x23, ETI

# invalid state, goto start
JAL x0, _Start

# case 3
ETI:
ADDI x10, x10, 1
BEQ x1, a1, ETI_E   # if E Jump
ADDI a5, x0, 0      # goto state start
JAL x0, Start
ETI_E:
ADDI a5, x0, 1      # goto state E
JAL x0, Start


# case 2
ET:
BEQ x1, a1, ET_E    # if E Jump
BEQ x1, a3, ET_I    # if I Jump
ADDI a5, x0, 0      # goto state start
JAL x0, Start
ET_E:
ADDI a5, x0, 1      # goto state E
JAL x0, Start
ET_I:
ADDI a5, x0, 3      # goto state ETI
JAL x0, Start

# case 1
E:
BEQ x1, a1, E_E     # if E Jump
BEQ x1, a2, E_T     # if T Jump
ADDI a5, x0, 0      # goto state start
JAL x0, Start
E_E:
ADDI a5, x0, 1      # goto state E
JAL x0, Start
E_T:
ADDI a5, x0, 2      # goto state ET
JAL x0, Start

# case 0
_Start:
BEQ x1, a1, _Start_E  # if E Jump
ADDI a5, x0, 0      # goto state start
JAL x0, Start
_Start_E:
ADDI a5, x0, 1      # goto state E
JAL x0, Start




SETUP:
# load data into memory in reverse order
ADDI sp, sp, -4
ADDI a0, x0, 0x45  # E
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x49  # I
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x54  # T
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x45  # E
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x54  # T
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x49  # I
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x54  # T
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x45  # E
SB a0, 0(sp)

ADDI sp, sp, -4
ADDI a0, x0, 0x45  # E
SB a0, 0(sp)

ADDI a0, x0, 0
JALR x0, ra, 0




END:
# needed for Venus Interpreter
nop     # for break point to view registers

# print result and exit with code 0
addi a1, x10, 0         # copy x10
addi a0, x0, 1          # print a1
ecall
addi a1, x0, 0x0A       # Line Feed
addi a0, x0, 11         # print a1
ecall
ecall

addi a0, x0, 10         # exit code 0
ecall