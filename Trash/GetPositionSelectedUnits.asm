
                    ifndef _CORE_MODULE_UTILS_SELECTED_UNITS_
                    define _CORE_MODULE_UTILS_SELECTED_UNITS_

                    module Units
; -----------------------------------------
; get the average position of the selected units
; In:
; Out:
;   D - average position Y, E - average position X
; Corrupt:
;   HL, DE, BC, AF, B'
; Note:
;   requires included memory page
; ToDo
;   make averaging over preselected units
; -----------------------------------------
GetSelected:        ;
                    LD A, (AI_NumUnitsRef)
                    OR A
                    RET Z
                    EXX
                    LD B, A
                    EXX
                    
                    ;
                    LD HL, (UnitArrayRef)                   ; HL = FUnitState.State             (1)

.LoopFirst          ;
                    BIT FUSF_SELECTED_BIT, (HL)
                    JR Z, .FindFirstUnit

                    INC H                                   ; HL = FSpriteLocation.TilePosition.X (2)
                    
                    ; min
                    LD E, (HL)
                    INC L                                   ; HL = FSpriteLocation.TilePosition.Y (2)
                    LD D, (HL)
                    RET     ; !!!!!!!!!!!!!!!!! выход
                    DEC L                                   ; HL = FSpriteLocation.TilePosition.X (2)
                    ; max
                    LD C, E
                    LD B, D

                    EXX
                    DEC B
                    EXX
                    RET Z                                   ; exit if last

                    DEC H                                   ; HL = FUnitState.State             (1)

                    JR .Average

.FindFirstUnit      ;
                    LD A, #04
                    ADD A, L
                    LD L, A

                    EXX
                    DJNZ .LoopFirst

                    RET                                     ; only one unit selected

.Average            EXX

.Loop               EXX

                    ;
                    BIT FUSF_SELECTED_BIT, (HL)
                    JR Z, .NextUnit

                    ;
                    INC H                                   ; HL = FSpriteLocation.TilePosition.X (2)
                    INC L                                   ; HL = FSpriteLocation.TilePosition.Y (2)

                    ; D - minY, E - minX
                    ; B - maxY, C - maxX

                    ; minY = min(minY, Y)
                    LD A, (HL)
                    CP D
                    JR NC, $+3
                    LD D, A

                    ; maxY = max(maxY, Y)
                    CP B
                    JR C, $+3
                    LD B, A
                    
                    DEC L                                   ; HL = FSpriteLocation.TilePosition.X (2)

                    ; minX = min(minX, X)
                    LD A, (HL)
                    CP E
                    JR NC, $+3
                    LD E, A

                    ; maxX = max(maxX, X)
                    CP C
                    JR C, $+3
                    LD C, A

                    DEC H                                   ; HL = FUnitState.State             (1)
                    
.NextUnit           ;
                    LD A, #04
                    ADD A, L
                    LD L, A

                    EXX
                    DJNZ .Loop
                    EXX

                    ; X = minX + (maxX - minX) / 2
                    LD A, C
                    SUB E
                    RRA
                    ADD A, E
                    LD E, A
                    
                    ; Y = minY + (maxY - minY) / 2
                    LD A, B
                    SUB D
                    RRA
                    ADD A, D
                    LD D, A

                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_SELECTED_UNITS_