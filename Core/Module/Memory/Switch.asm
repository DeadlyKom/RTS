
                ifndef _MODULE_MEMORY_SWITCH_
                define _MODULE_MEMORY_SWITCH_

                module Memory
Begin:          EQU $
; -----------------------------------------
; установка страницы в 3 банк памяти (#C000-#FFFF)
; In:
;   A - номер страницы памяти
; Out:
; Corrupt:
;   BC, AF, AF'
; Note:
; -----------------------------------------
SetPage:        EX AF, AF'
                LD BC, PORT_7FFD
                LD A, (BC)
                LD C, A
                EX AF, AF'
                XOR C
                AND PAGE_MASK
                XOR C
                LD C, LOW PORT_7FFD
                LD (BC), A
                OUT (C), A
                RET
SetPage0:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                LD (BC), A
                OUT (C), A
                RET
SetPage1:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                INC A
                LD (BC), A
                OUT (C), A
                RET
SetPage3:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_3
                LD (BC), A
                OUT (C), A
                RET
SetPage4:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_4
                LD (BC), A
                OUT (C), A
                RET
SetPage5:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
.OR             OR PAGE_5
                LD (BC), A
                OUT (C), A
                RET
SetPage6:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_6
                LD (BC), A
                OUT (C), A
                RET
SetPage7:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET
ScrPageToC000:  LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                BIT SCREEN_BIT, A
                JR Z, SetPage5.OR
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET
ScrPageToC000_: LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                BIT SCREEN_BIT, A
                JR NZ, SetPage5.OR
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET

                display " - Memory Switch : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_MEMORY_SWITCH_
