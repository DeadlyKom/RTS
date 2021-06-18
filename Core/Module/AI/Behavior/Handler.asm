
                ifndef _CORE_MODULE_AI_BEHAVIOR_HANDLER_
                define _CORE_MODULE_AI_BEHAVIOR_HANDLER_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        ; проверка на наличие юнитов в масиве
                LD A, (AI_NumUnitsRef)
                OR A
                RET Z
                EX AF, AF'                                      ; сохраним количество юнитов в масиве

                ; включить страницу
                SeMemoryPage MemoryPage_Tilemap, AI_HANDLER_BEGIN_ID

                ; сохраним текущий фрейм
                LD A, (TickCounterRef)
                LD (.LastFrame), A
                
                ; проверим остались ещё юниты для обработки
                LD A, (.UnitsCounter)
                OR A
                JP NZ, .Loop                                    ; есть ещё юниты

                ; инициализация
                LD HL, (UnitArrayRef)
                LD (.CurrentUnit), HL
                EX AF, AF'
                LD (.UnitsCounter), A

.Loop           ; проверка прерывания
                LD A, (TickCounterRef)
.LastFrame      EQU $+1
                CP #00
                JR Z, .Continue

                ; проверка включена ли синхронизация
                CheckAIFlag AI_SYNC_UPDATE_FLAG
                RET NZ
.Continue
.CurrentUnit    EQU $+2
                LD IX, #0000                                    ; IX - указывает на FUnitState

                ;
                LD HL, (BehaviorTableRef)

                LD A, (IX + FUnitState.Type)                    ; A = Type
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
                
                CALL HandlerRoot                                ; запустить дерево поведения юнита

                ; переход к следующему юниту (IX += 4)
                LD HL, .CurrentUnit
                LD A, (HL)
                ADD A, #04
                LD (HL), A

                LD HL, .UnitsCounter                            ; адрес счётчика оставшихся юнитов
                DEC (HL)                                        ; уменьшим счётчик оставшихся юнитов
                JR NZ, .Loop

                ResetAIFlag AI_UPDATE_FLAG                      ; сбросим флаг обновления 

                RET

.UnitsCounter   DB #00

                endif ; ~ _CORE_MODULE_AI_BEHAVIOR_HANDLER_