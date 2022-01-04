
                ifndef _CORE_MODULE_ANIMATION_BLAND_MOVE_
                define _CORE_MODULE_ANIMATION_BLAND_MOVE_

; -----------------------------------------
; бленд анимаций перемещения
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
MoveDown:       ; получение адреса анимации перемещения для текущего типа юнита
                LD HL, (AnimMoveTableRef)
                CALL Utils.GetAdrInTable

                ; получить проходимость тайла
                CALL Utils.Surface.GetPassability
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; HL - указывает на текущий FAnimation
                LD D, (HL)

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
                RET Z

                ; проверка на инициализацию счётчика после перемещения
                BIT FUAF_TURN_MOVE, (IX + FUnit.Flags)                          ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                JR Z, .FirstInit

                ; проверка на первичную инициализацию (мб вообще убрать её!)
                LD E, (IX + FUnit.CounterDown)                                  ; получим значение текущего счётчика
                LD A, E
                AND FUAF_COUNT_DOWN_MASK
                JR Z, .Init                                                     ; счётчик равен нулю, проинициализируем его

                DEC A

                JR NZ, $+3
                SCF

.Set            LD (IX + FUnit.CounterDown), A                                  ; сохраним значение
                RET

.FirstInit      LD A, D                                                         ; A - новый счётчик
                SCF
                JR .Set

.Init           LD A, D                                                         ; A - новый счётчик
                OR A
                JR .Set

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_MOVE_
