
                ifndef _CORE_MODULE_AI_BEHAVIOR_HANDLER_
                define _CORE_MODULE_AI_BEHAVIOR_HANDLER_

                include "BehaviorTable.inc"

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        ; включить страницу
                SeMemoryPage MemoryPage_Tilemap, AI_HANDLER_BEGIN_ID
                
                ; проверка на наличие юнитов в массиве
                LD A, (CountUnitsRef)
                OR A
                RET Z
                
                ;
                LD HL, MapStructure + FMap.UnitsArray
                LD E, (HL)
                INC L
                LD D, (HL)
                PUSH DE
                POP IX

                ;
                LD HL, BehaviorTable

                ; DE - указывает на FUnitState.Behavior
                INC E                                           ; Direction
                INC E                                           ; Type
                LD A, (DE)                                      ; A = Type
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

                RET

                endif ; ~ _CORE_MODULE_AI_BEHAVIOR_HANDLER_