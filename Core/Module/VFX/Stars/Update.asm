
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
                OR A
                JP Z, .Destroyed

                LD C, A
                INC HL                                                          ; HL - FStar.X

                ADD A, (HL)
                LD (HL), A
                JR NC, .NotOverflow_

                INC HL
                INC (HL)
                JR Z, .Overflow

                DEC HL
.NotOverflow_   LD A, C
                ADD A, (HL)
                LD (HL), A
                INC HL
                JR NC, .NotOverflow
                INC (HL)
                JR NZ, .NotOverflow

; достижение правого края
.Overflow       ; затересть значение
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                XOR A
                LD (DE), A

                LD DE, -FStar
                ADD HL, DE

                LD A, (StarFlags)
                BIT STAR_DESTROY_BIT, A
                JR Z, .ASSS
                JR .Destroy

.NotOverflow    LD C, (HL)                                                      ; старший X
                INC HL

                ; затересть значение
                LD E, (HL)
                INC HL
                LD D, (HL)

                LD A, (StarFlags)
                BIT STAR_BIT, A
                JR Z, .L2

                ; проверка 
                SET 7, D
                LD A, (DE)
                RES 7, D
                OR A
                JR Z, .L2
                LD (DE), A

                ; DEC H
                ; LD (DE), A
                ; INC H

                JR .L3

.L2             XOR A
                LD (DE), A
.L3
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

                LD A, (StarFlags)
                BIT STAR_BIT, A
                JR Z, .L1

                ;
                SET 7, D
                LD A, (DE)
                RES 7, D
                OR A
                JR Z, .L1

                LD (DE), A
                DEC H
                RRCA
                LD (DE), A
                INC H
                JR .LA

.L1             EX AF, AF'
                LD (DE), A

.LA
                DEC HL
                LD (HL), E
                INC HL
                INC HL

.Next           DJNZ .Loop

                RET

.ASSS           CALL Generate
                JR .Next
                
.Destroy        LD (HL), #00
.Destroyed      LD DE, FStar
                ADD HL, DE
                JR .Next

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_UPDATE_
