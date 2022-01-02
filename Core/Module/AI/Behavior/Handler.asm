
                ifndef _CORE_MODULE_AI_BEHAVIOR_HANDLER_
                define _CORE_MODULE_AI_BEHAVIOR_HANDLER_

; -----------------------------------------
; обработчик поведения юнитов
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Behavior:       ; проверка на наличие юнитов в масиве
                LD A, (AI_NumUnitsRef)
                OR A
                RET Z
                EX AF, AF'                                                      ; сохраним количество юнитов в масиве

                SET_PAGE_UNITS_ARRAY

                ; сохраним текущий фрейм
                LD A, (TickCounterRef)
                LD (.LastFrame), A
                
                ; проверим остались ещё юниты для обработки
                LD A, (.UnitsCounter)
                OR A
                JP NZ, .Loop                                                    ; есть ещё юниты

                ; инициализация
                LD HL, UnitArrayPtr
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
                RET Z

.Continue       
                ; адрес обрабатываемого юниты
.CurrentUnit    EQU $+2
                LD IX, UnitArrayPtr                                             ; IX - указывает на FUnit

                ; адрес таблицы поведения юнитов по типу
.Table          EQU $+1
                LD HL, #0000

                ; определение необходимого поведения по типу
                CALL Utils.GetAdrInTable

                ; запустить дерево поведения юнита
                ; ---------------------------------------------
                ; HL - поведение юнита
                ; IX - указывает на структуру FUnit
                ; ---------------------------------------------
                CALL RunBTT

                ; переход к следующему юниту
                LD HL, .CurrentUnit
                LD A, (HL)
                ADD A, UNIT_SIZE
                LD (HL), A
                JP NC, $+5
                INC HL
                INC (HL)

                ; проверка заверщения обработки юнитов
                LD HL, .UnitsCounter                                            ; адрес счётчика оставшихся юнитов
                DEC (HL)                                                        ; уменьшим счётчик оставшихся юнитов
                JR NZ, .Loop

                SetAIFlag AI_UPDATE_FLAG                                        ; сбросим флаг обновления 

                RET

.UnitsCounter   DB #00

                endif ; ~ _CORE_MODULE_AI_BEHAVIOR_HANDLER_