
                ifndef _CORE_MODULE_AI_COMPOSITE_HANDLER_
                define _CORE_MODULE_AI_COMPOSITE_HANDLER_
; -----------------------------------------
; запуск behavior tree
; In:
;   HL - адрес дерева поведения
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RunBTT:         ; расчёт текущего исполняемого узла
                LD C, (IX + FUnit.BehaviorTree.Info)
                LD A, C
                AND BT_INDEX_MASK
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; переход к обработчику узла
                LD E, (HL)
                INC HL
                LD D, (HL)
                LD A, BT_TYPE_MASK
                AND D
                RRCA
                RRCA
                RRCA
                RRCA
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; звуковое оповещение об ошибке
                ifdef DEBUG
                JP SFX.BEEP.Fail
                DB #00                                                          ; dummy
                else
                DS 4, 0
                endif

                ; переход к selector'у
                JP Selector
                DB #00                                                          ; dummy

                ; переход к sequence'у
                JP Sequence
                DB #00                                                          ; dummy

                ; переход к task'е
                JP Task
                DB #00                                                          ; dummy

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_