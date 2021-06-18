
                ifndef _CORE_MODULE_AI_BEHAVIOR_HANDLER_
                define _CORE_MODULE_AI_BEHAVIOR_HANDLER_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        ; проверка на необходимость обновлять кластер
                LD HL, UnitClusterRef
                LD A, (HL)
                INC HL
                CP (HL)
                RET NZ

                ; проверка на наличие юнитов в в текущем кластере
                INC HL
                LD D, #00
                AND %00000111
                LD E, A
                ADD HL, DE
                LD A, (HL)
                OR A
                JP Z, .NextCluster
                EX AF, AF'                                      ; A' - количество юнитов в кластере

                ; включить страницу карты
                SeMemoryPage MemoryPage_Tilemap, AI_HANDLER_BEGIN_ID

                LD C, E

                ; расчитаем адрес временного массива 
                LD E, FUnitCluster.TmpNumArray - 2
                ADD HL, DE
                PUSH HL                                         ; HL - адрес на количество требуемых обработку юнитов

                ; инициализация временного массива, если там пусто              
                LD A, (HL)
                OR A
                JR NZ, .Continue
                EX AF, AF'
                LD (HL), A
                LD HL, (UnitArrayRef)
                LD A, C
                ADD A, A
                ADD A, A
                LD E, A
                ADD HL, DE
                LD (.CurrentUnit), HL
                JR .Continue

.Loop           ; проверка прерывания


.Continue       ;
.CurrentUnit    EQU $+2
                LD IX, #0000                                                ; IX - указывает на FUnitState

                ;
                LD HL, (BehaviorTableRef)

                LD A, (IX + FUnitState.Type)                                ; A = Type
                AND %00011111
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ;
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL
                
                ;
                CALL HandlerRoot

                ; переход к следующему юниту (IX += 4)
                LD HL, .CurrentUnit
                LD A, (HL)
                ADD A, #04
                LD (HL), A

                POP HL                                          ; адрес счётчика оставшихся юнитов
                DEC (HL)                                        ; уменьшим счётчик оставшихся юнитов
                JR NZ, .Loop
                
.NextCluster    ; укажем что текущий кластер юнитов обработан (можно переходить к следующему)
                LD HL, UnitClusterRef + FUnitCluster.Next
                INC (HL)

                RET

                endif ; ~ _CORE_MODULE_AI_BEHAVIOR_HANDLER_