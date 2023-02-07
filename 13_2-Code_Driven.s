.data 
msg: .string "ETIEETTIETI eti"

.text
# prepare memory address
LA t0, msg          # Load Address
# set characters to compare
ADDI a1, x0, 0x45  # E
ADDI a2, x0, 0x54  # T
ADDI a3, x0, 0x49  # I

Start:
LB x1, 0(t0)
ADDI t0, t0, 1
BEQ x1, x0, END
BEQ x1, a1, E
JAL x0, Start

E:
LB x1, 0(t0)
ADDI t0, t0, 1
BEQ x1, x0, END
BEQ x1, a2, ET
BEQ x1, a1, E
JAL x0, Start

ET:
LB x1, 0(t0)
ADDI t0, t0, 1
BEQ x1, x0, END
BEQ x1, a3, ETI
BEQ x1, a1, E
JAL x0, Start

ETI:
ADDI x10, x10, 1  # increment Counter
LB x1, 0(t0)
ADDI t0, t0, 1
BEQ x1, x0, END
BEQ x1, a1, E
JAL x0, Start




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