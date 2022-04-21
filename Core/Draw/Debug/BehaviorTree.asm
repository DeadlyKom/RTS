
                ifndef _CORE_DRAW_DEBUG_BEHAVIOR_TREE_
                define _CORE_DRAW_DEBUG_BEHAVIOR_TREE_
DrawStateBT:    ; проверка на наличие юнитов в масиве
                LD A, (AI_NumUnitsRef)
                OR A
                RET Z

                ;
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                SET_PAGE_UNITS_ARRAY

                ; JR$
                LD DE, #55AA
                CALL UART.SendWord
                RET NC
                LD DE, #00AA
                CALL UART.SendWord
                RET NC
                LD A, UNIT_SIZE
                CALL UART.SendByte
                RET NC

                ; отправка данных состояения юнита
                LD HL, UnitArrayPtr
                LD D, UNIT_SIZE
                CALL UART.SendPack

                ;
.RestoreMemPage EQU $+1
                LD A, #00
                CALL Memory.SetPage

                RET

                endif ; ~_CORE_DRAW_DEBUG_BEHAVIOR_TREE_
