
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_SCROLL_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_SCROLL_
; -----------------------------------------
; скрол текста вверх
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scroll:         
                LD HL, START_SCROLL + 0x100
                LD DE, START_SCROLL

                LD B, 35
                
.L1             LD C, H ; LD C, #FF

                rept ROW_LENGTH_CHR
                LDI
                endr

                LD A, L
                SUB ROW_LENGTH_CHR
                LD L, A

                LD D, H
                LD E, L

                ; classic method "DOWN_HL" 25/59
                INC H
                LD A, H
                AND #07
                JP NZ, .Next
                LD A, L
                SUB #E0
                LD L, A
                SBC A, A
                AND #F8
                ADD A, H
                LD H, A

.Next           DJNZ .L1

                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_SCROLL_
