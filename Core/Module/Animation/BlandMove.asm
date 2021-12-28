
                ifndef _CORE_MODULE_ANIMATION_BLAND_MOVE_
                define _CORE_MODULE_ANIMATION_BLAND_MOVE_

; -----------------------------------------
; бленд анимаций перемещения
; In:
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
MoveDown:       ; получение адреса анимации перемещения для текущего типа юнита
                LD HL, (AnimMoveTableRef)
                LD A, (IX + FUnitState.Type)                                    ; A = Type
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
                EX DE, HL

                INC IXH                                                         ; FSpriteLocation     (2)

                ;
                CALL Utils.Surface.GetPassability
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; HL - указывает на текущий FAnimation
                LD D, (HL)

                INC IXH                                                         ; FUnitTargets      (3)
                INC IXH                                                         ; FUnitAnimation    (4)

                ; ; проверка перемещения по диагонали
                ; LD A, (IX + FUnitAnimation.Flags)
                ; SRL A                                                           ; пропустим FUAF_TURN_MOVE
                ; LD E, A
                ; SRL A
                ; XOR E
                ; JR NZ, $+3                                                      ; если XOR FUAF_X и FUAF_Y равен 1 перемещение под 90 градусом
                ; ; в противном случае увеличим время перемещения по диагонали
                ; INC D

                ; пропустим если значени анимации равно нулю
                LD A, D
                OR A
                SCF
                JR Z, .Exit

                ; проверка на инициализацию счётчика после перемещения
                BIT FUAF_TURN_MOVE, (IX + FUnitAnimation.Flags)
                JR Z, .FirstInit

                ; проверка на первичную инициализацию (мб вообще убрать её!)
                LD E, (IX + FUnitAnimation.CounterDown)                         ; получим значение текущего счётчика
                LD A, E
                AND %00011111
                JR Z, .Init

                DEC A

                JR NZ, $+3
                SCF

.Set            LD (IX + FUnitAnimation.CounterDown), A                         ; сохраним значение

.Exit           ; завершение работы
                DEC IXH                                                         ; FUnitTargets      (3)
                DEC IXH                                                         ; FSpriteLocation   (2)
                DEC IXH                                                         ; FUnitState        (1)

                RET

.FirstInit      LD A, D                                                         ; A - новый счётчик
                SCF
                JR .Set

.Init           LD A, D                                                         ; A - новый счётчик
                OR A
                JR .Set


                endif ; ~_CORE_MODULE_ANIMATION_BLAND_MOVE_
