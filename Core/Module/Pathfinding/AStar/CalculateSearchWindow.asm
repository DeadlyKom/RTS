
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_CALCULATE_SEARCH_WINDOW_
                define _CORE_MODULE_PATHFINDING_ASTAR_CALCULATE_SEARCH_WINDOW_
; -----------------------------------------
; расчитать окно поиска
; In:
;   HL - конечная позиция тайла     (H - y, L - x)
;   DE - начальная позиция тайла    (D - y, E - x)
; Out:
;   DE - начальная позиция тайла    (D - y, E - x)
; Corrupt:
; Note:
; -----------------------------------------
SearchWindow:   ;

                ; JR$
                LD (GetHeuristics.EndLocation), HL
                PUSH DE                                                         ; сохранить начальную позицию тайла (D - y, E - x)

                ; ---------------------------------------------

                ; int NewX = _Start.x + (BufferCell >> 1);
                LD A, E
                ADD A, PFWinWidth >> 1
                LD E, A
                ; NewX = Clamp(NewX, 0, TilemapSizeX - 1);
                LD A, (TilemapWidth)
                DEC A
                LD C, A
                SUB E
                JR NC, $+3
                LD E, C 
                ; E = NewX
                ; int NewXX = NewX - BufferCell;
                LD A, E
                SUB PFWinWidth
                ; StartX = NewXX >= 0 ? NewXX + 1 : 0;
                ; EndX = NewXX >= 0 ? NewX: NewX + -NewXX - 1;

                ; NewXX >= 0
                JR NC, .MoreX
                ; StartX = 0;
                ; EndX   = NewX + -NewXX - 1;
                NEG         ; -NewXX
                DEC A       ; - 1
                ADD A, E    ; NewX
                LD L, A
                ; StartX = 0;
                LD E, #00
                JR .Y
.MoreX          ; StartX = NewXX + 1;
                ; EndX   = NewX;
                LD L, E
                INC A
                ; StartX = NewXX + 1;
                LD E, A

.Y              ; ---------------------------------------------

                ; int NewY = _Start.y + (BufferCell >> 1);
                LD A, D
                ADD A, PFWinHeight >> 1
                LD D, A
                ; NewY = Clamp(NewY, 0, TilemapSizeY - 1);
                LD A, (TilemapHeight)
                DEC A
                LD C, A
                SUB D
                JR NC, $+3
                LD D, C 
                ; D = NewY
                ; int NewYY = NewY - BufferCell;
                LD A, D
                SUB PFWinHeight
                ; StartY = NewYY >= 0 ? NewYY + 1 : 0;
                ; EndY = NewYY >= 0 ? NewY: NewY + -NewYY - 1;

                ; NewYY >= 0
                JR NC, .MoreY
                ; StartY = 0;
                ; EndY   = NewY + -NewYY - 1;
                NEG         ; -NewYY
                DEC A       ; - 1
                ADD A, D    ; NewY
                LD H, A
                ; StartY = 0;
                LD D, #00
                JR .End
.MoreY          ; StartY = NewYY + 1;
                ; EndY   = NewY;
                LD H, D
                INC A
                ; StartY = NewYY + 1;
                LD D, A

                ; ---------------------------------------------

.End            ; ---------------------------------------------
                ; HL - BufferEnd      (H - y, L - x)
                ; DE - BufferStart    (D - y, E - x)
                ; ---------------------------------------------


                ; инициализация значений для поиска пути
                ; LD HL, #0F0F
                LD (Step.BufferEnd), HL
                EX DE, HL
                ; LD HL, #0000   
                LD (Step.BufferStart), HL
                LD (GetTileInfo.BufferStart), HL                                ; GetTileInfo.BufferStart
                ; LD (GetFoundPath.BufferStart), HL
                LD A, L
                LD (AddToOpenList.BufferStartX), A                              ; AddToOpenList.BufferStartX
                LD A, H
                LD (AddToOpenList.BufferStartY), A                              ; AddToOpenList.BufferStartY

                POP DE                                                          ; востановить начальную позицию тайла (D - y, E - x)

                ; ; X = (Coord.x - BufferStart.x) & 0x0F
                ; LD A, E
                ; SUB L
                ; LD E, A

                ; ; Y = (Coord.y - BufferStart.y) & 0x0F
                ; LD A, D
                ; SUB H
                ; LD D, A

                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_CALCULATE_SEARCH_WINDOW_
