
                ifndef _MACRO_INTERRUPT_
                define _MACRO_INTERRUPT_
RestoreHL:      macro
                LD A, #E5
                LD (RestoreRegister), A
                endm
RestoreDE:      macro
                LD A, #D5
                LD (RestoreRegister), A
                endm
RestoreBC:      macro
                LD A, #C5
                LD (RestoreRegister), A
                endm
SetUserHendler: macro Func?
                LD BC, Func?
                LD (UserInterrupt), BC
                endm
OffUserHendler: macro
                LD BC, Interrupt_RET
                LD (UserInterrupt), BC
                endm

                endif ; ~_MACRO_INTERRUPT_
