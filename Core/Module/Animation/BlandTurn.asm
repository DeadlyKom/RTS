
                ifndef _CORE_MODULE_ANIMATION_BLAND_TURN_
                define _CORE_MODULE_ANIMATION_BLAND_TURN_

; -----------------------------------------
; бленд вращение нижней части/всего объекта
; In:
;   A  - направление поворота (-1/1)
;   C  - текущий поворот
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
TurnDown:       ; B - направление поворота (-1/1)
                LD B, A

                ; получение адреса анимации поворота для текущего типа юнита
                LD HL, (AnimTurnDownTableRef)
                CALL Utils.GetAdrInTable
                CALL Utils.Surface.GetPassability
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; HL - указывает на текущий FAnimation
                LD D, (HL)

                ; проверка на инициализацию счётчика после перемещения
                BIT FUAF_TURN_MOVE, (IX + FUnit.Flags)                          ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                JR NZ, .Init

                ; проверка на первичную инициализацию (мб вообще убрать её!)
                LD E, (IX + FUnit.CounterDown)                                  ; получим значение текущего счётчика
                LD A, E
                AND FUAF_COUNT_DOWN_MASK
                JR Z, .Init                                                     ; счётчик равен нулю, проинициализируем его

                ; проверка изменения направления поворота
                LD A, B                                                         ; A - направление поворота (-1/1)
                XOR E
                ADD A, A
                JR NC, .Rotate                                                  ; направление поворота не изменилось
                
                ; обрежим счётчик
                LD A, E
                AND FUAF_COUNT_DOWN_MASK
                LD E, A

                ; вычислим сколько прошло от предыдущей анимациии
                LD A, D
                SUB E                                                           ; A = количествой пройденых тиков анимации (прошлой)
                ADD A, (HL)                                                     ; A += количество перехода тиков от текущей к предыдущей анимации
                EX AF, AF'

                ; направления поворота
                LD A, B                                                         ; A - направление поворота (-1/1)
                AND %11100000
                LD B, A
                
                EX AF, AF'
                ; проверим что если повороты будут часто менятся счётчик не ушёл за максимальные пределы
                CP %00100000
                JR C, $+4
                LD A, %00011111
                OR B                                                            ; добавим направление

.Set            ;JR$
                LD B, A
                LD A, %01100000
                AND (IX + FUnit.CounterDown)
                OR B
                LD (IX + FUnit.CounterDown), A                                  ; сохраним значение
                RET

.Init           ; сброс бита принадлежности
                RES FUAF_TURN_MOVE, (IX + FUnit.Flags)                          ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                
                ; установка нового счётчика анимации
                LD A, (HL)                                                      ; A - новый счётчик
                
                ; перенесём знак направления поворота
                ADD A, A
                RL B
                RRA

                JR .Set

.Decrement      ;
                ADD A, A
                RL B                                                            ; B - направление поворота (-1/1)
                RRA
                JR .Set

.Rotate         ; поворот по направлению
                LD A, E
                AND %00011111
                DEC A

                ; DEC (IX + FUnitAnimation.CounterDown)                           ; уменьшим счётчик
                JR NZ, .Decrement                                               ; чсётчик не нулевой продолжаем отсчёт

                LD A, E
                AND %01100000
                LD D, A

                ; установка нового счётчика анимации
                LD A, (HL)                                                      ; A - новый счётчик
                LD E, B                                                         ; E - направление поворота (-1/1)
                
                ; перенесём знак направления поворота
                ADD A, A
                RL E
                RRA
                OR D
                LD (IX + FUnit.CounterDown), A                                  ; сохраним значение

                ; меняем спрайт
                LD A, B                                                         ; A - направление поворота (-1/1)
                ADD A, C                                                        ; C = [0..7] номер поворота
                AND %00000111
                ADD A, A
                ADD A, A
                ADD A, A
                LD C, A
                LD A, (IX + FUnit.Direction)
                AND %11000111
                OR C
                LD (IX + FUnit.Direction), A

                ; обновление облости
                CALL Unit.RefUnitOnScr

                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_TURN_
