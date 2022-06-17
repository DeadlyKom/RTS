
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_UPDATE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_UPDATE_
; -----------------------------------------
; обновление позиции звёзд
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Update:         LD HL, StarsArray
                LD A, (StarCounter)
                OR A
                RET Z

                LD B, A

.Loop           LD A, (HL)                                                      ; HL - FStar.Speed
                INC HL                                                          ; HL - FStar.X

                ADD A, (HL)
                LD (HL), A

                INC HL
                JR NC, .NotOverflow
                INC (HL)
                JR NZ, .NotOverflow

                ; затересть значение
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                XOR A
                LD (DE), A
                DEC HL
                DEC HL
                DEC HL

                DEC HL
                DEC HL
                CALL Generate
                JR .Next

.NotOverflow    LD C, (HL)                                                      ; старший X
                INC HL

                ; затересть значение
                LD E, (HL)
                INC HL
                LD D, (HL)
                XOR A
                LD (DE), A

                ; 
                LD A, C
                CPL
                AND #07
                ADD A, A
                ADD A, A
                ADD A, A
                OR #C7
                LD (.BIT), A
                XOR A
.BIT            EQU $+1                                                         ; SET n, C
                DB #CB, #00
                EX AF, AF'

                ;
                LD A, C
                RRA
                RRA
                RRA
                XOR E
                AND %00011111
                XOR E
                LD E, A

                EX AF, AF'
                LD (DE), A
                DEC HL
                LD (HL), E
                INC HL
                INC HL

.Next           DJNZ .Loop

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_UPDATE_
