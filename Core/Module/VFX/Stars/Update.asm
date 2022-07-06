
                ifndef _CORE_MODULE_VFX_STARS_UPDATE_
                define _CORE_MODULE_VFX_STARS_UPDATE_
; -----------------------------------------
; обновление позиции звёзд
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Update:         ; инициализация
                LD HL, StarsArray
                LD A, (StarCounter)
                OR A
                RET Z

                LD B, A

.Loop           ; обработка данных звезды
                LD A, (HL)                                                      ; HL - FStar.Speed
                OR A
                JP Z, .Destroyed

                ; приращение скорости звезды к положению на экране
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
                JR Z, .Generate
                JR .Destroy

.NotOverflow    LD C, (HL)                                                      ; старший X
                INC HL

                ; затересть значение
                LD E, (HL)
                INC HL
                LD D, (HL)

                ; проверка отображения только звёзд
                LD A, (StarFlags)
                BIT STAR_BIT, A
                LD A, #00
                JR Z, .DrawStar

                ; копирование данных с теневого экрана 
                SET 7, D
                LD A, (DE)
                RES 7, D
.DrawStar       LD (DE), A

                ; получение спрайта звезды по горизонтали
                LD A, C
                CPL
                AND #07
                ADD A, A
                ADD A, A
                ADD A, A
                OR #C7
                LD (.BIT), A
                XOR A
.BIT            EQU $+1                                                         ; SET n, A
                DB #CB, #00
                EX AF, AF'

                ; конверсия позиции звезды по горизонтали в знакоместа
                LD A, C
                RRA
                RRA
                RRA
                XOR E
                AND %00011111
                XOR E
                LD E, A

                ; проверка отображения только звёзд
                LD A, (StarFlags)
                BIT STAR_BIT, A
                JR Z, .Star

                ; проверка копирования данных теневого экрана
                SET 7, D
                LD A, (DE)
                RES 7, D
                OR A
                JR Z, .Star                                                     ; в теневом экране нет данных для копирования

                ; добавление искажения картинки
                LD C, A
                RRCA
                RRCA
                OR C
                LD (DE), A
                JR .SetScreenAdr

.Star           ; отображение звезды
                EX AF, AF'
                LD (DE), A

.SetScreenAdr   ; сохранение адреса экрана
                DEC HL
                LD (HL), E
                INC HL
                INC HL

.Next           DJNZ .Loop

                RET

.Generate       CALL Generate
                JR .Next
                
.Destroy        LD (HL), #00
.Destroyed      LD DE, FStar
                ADD HL, DE
                JR .Next

                endif ; ~ _CORE_MODULE_VFX_STARS_UPDATE_
