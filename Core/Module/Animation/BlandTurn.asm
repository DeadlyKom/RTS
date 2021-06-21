
                ifndef _CORE_MODULE_ANIMATION_BLAND_TURN_
                define _CORE_MODULE_ANIMATION_BLAND_TURN_

; -----------------------------------------
; rotation of the bottom of the object/the whole object
; In:
;   A  - направление поворота (-1/1)
;   C  - текущий поворот
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
TurnDown:       ;sbJR $

                ;
                LD B, A                                     ; B - направление поворота (-1/1)
                
                ; получение адреса анимации поворота для текущего типа юнита
                LD HL, (AnimTurnTableRef)
                LD A, (IX + FUnitState.Type)                ; A = Type
                AND %00011111
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; чтение адреса
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL                                   ; HL - указывает на FSequencer

                PUSH HL                                     ; HL - указывает на 0 FAnimation
                
                ; получение текущего счётчика анимаций
                LD A, C                                     ; A = [0..7] номер поворота
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; HL - указывает на текущий FAnimation
                LD A, (HL)
                EX AF, AF'                                  ; A' - счётчик текущей анимации
                POP HL                                      ; HL - указывает на 0 FAnimation

                ; go to FUnitTargets
                INC IXH                                     ; FUnitLocation     (2)
                INC IXH                                     ; FUnitTargets      (3)
                INC IXH                                     ; FFUnitAnimation   (4)
                
                LD E, (IX + FFUnitAnimation.CounterDown)
                LD A, E
                OR A
                JR Z, .Init

                ; проверка изменения направления поворота
                LD A, B                                     ; A - направление поворота (-1/1)
                XOR E
                ADD A, A
                JR NC, .Rotate                              ; направление поворота не изменилось
                
                ; обрежим счётчик
                LD A, E
                AND %00011111
                LD E, A

                ; изменение направления поворота
                LD A, C                                     ; A = [0..7] номер поворота
                ADD A, B                                    ; переход к предыдущей анимации (B = -1 / 1)
                AND %00000111
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                ; HL - указывает на предыдущую FAnimation

                ; вычислим сколько прошло от предыдущей анимациии
                EX AF, AF'
                SUB E                                       ; A = количествой пройденых тиков анимации (прошлой)
                ADD A, (HL)                                 ; A += количество перехода тиков от текущей к предыдущей анимации
                EX AF, AF'

                ; направления поворота
                LD A, B                                     ; A - направление поворота (-1/1)
                ; CPL
                AND %10000000
                LD B, A
                
                EX AF, AF'
                ; проверим что если повороты будут часто менятся счётчик не ушёл за максимальные пределы
                CP %00100000
                JR C, $+4
                LD A, %00011111
                OR B                                        ; добавим направление
.Set            LD (IX + FFUnitAnimation.CounterDown), A    ; сохраним значение

.Exit           ; завершение работы
                DEC IXH                                     ; FUnitTargets      (3)
                DEC IXH                                     ; FUnitLocation     (2)
                DEC IXH                                     ; FUnitState        (1)

                RET

.Init           ; установка нового счётчика анимации

                ; изменение направления поворота
                LD A, C                                     ; A = [0..7] номер поворота
                ADD A, B                                    ; переход к предыдущей анимации (B = -1 / 1)
                AND %00000111
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                ; HL - указывает на следующую FAnimation

                LD A, (HL)                                  ; A - новый счётчик
                LD E, B
                
                ; перенесём знак направления поворота
                ADD A, A
                RL B
                RRA

                JR .Set 

.Decrement      ;
                ADD A, A
                RL E
                RRA
                JR .Set

.Rotate         ; поворот по направлению
                LD E, (IX + FFUnitAnimation.CounterDown)
                LD A, E
                AND %00011111
                DEC A

                ; DEC (IX + FFUnitAnimation.CounterDown)      ; уменьшим счётчик
                JR NZ, .Decrement                           ; чсётчик не нулевой продолжаем отсчёт

                ; установка нового счётчика анимации

                ; получение предыдущий/следующий поворот
                LD A, C                                     ; A = [0..7] номер поворота
                ADD A, B                                    ; переход к предыдущей анимации (B = -1 / 1)
                AND %00000111
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                ; HL - указывает на следующую FAnimation

                LD A, (HL)                                  ; A - новый счётчик
                LD E, B                                     ; E - направление поворота (-1/1)
                
                ; перенесём знак направления поворота
                ADD A, A
                RL E
                RRA
                LD (IX + FFUnitAnimation.CounterDown), A    ; сохраним значение

                ; завершение работы
                DEC IXH                                     ; FUnitTargets      (3)
                DEC IXH                                     ; FUnitLocation     (2)
                DEC IXH                                     ; FUnitState        (1)

                ; меняем спрайт
                LD A, B                                     ; A - направление поворота (-1/1)
                ADD A, C                                    ; C = [0..7] номер поворота
                AND %00000111
                ADD A, A
                ADD A, A
                ADD A, A
                LD C, A
                LD A, (IX + FUnitState.Direction)
                AND %11000111
                OR C
                LD (IX + FUnitState.Direction), A

                ; A - номер юнита
                LD A, IXL
                RRA
                RRA
                AND %00111111
                CALL Unit.RefUnitOnScr

                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_TURN_