
                    ifndef _CORE_MODULE_UTILS_PATH_FINDING_QUEUE_
                    define _CORE_MODULE_UTILS_PATH_FINDING_QUEUE_

                    module Pathfinding
; -----------------------------------------
; добавить значение в очередь
; In:
;   A  - стоимость
;   DE - позиция тайла (D - y, E - x)
; Out:
;   flag C - 0 = значение помещено, 1 - значение не помещенно
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AddToQueue:         ;
                    EX AF, AF'
                    LD HL, PathfindingQueue

.Loop               LD A, (HL)
                    INC A
                    JR Z, .Set

                    INC L
                    JR NZ, .Loop

                    SCF
                    RET

.Set                EX AF, AF'
                    LD (HL), A
                    INC H
                    LD (HL), E
                    INC H
                    LD (HL), D

                    OR A
                    RET

GetBestCostInQueue: ;
                    LD C, #FF
                    LD HL, PathfindingQueue

.Loop               LD A, (HL)
                    CP C
                    JR C, .SetLess

.NextElement        INC L
                    JR NZ, .Loop
.ContainerHL        EQU $+1
                    LD HL, #0000
                    LD (HL), #FF

                    RET

.SetLess            INC H
                    LD E, (HL)
                    INC H
                    LD D, (HL)
                    DEC H
                    DEC H

                    LD C, A
                    LD (.ContainerHL), HL
                    
                    JR .NextElement
                
                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_QUEUE_