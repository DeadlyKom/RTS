
                ifndef _CORE_MODULE_UNIT_SELECTED_RECT_
                define _CORE_MODULE_UNIT_SELECTED_RECT_

; -----------------------------------------
; сканирование выделение прямоугольником
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
ScanRectSelect: ; проверка на наличие юнитов в массиве
                LD A, (AI_NumUnitsRef)
                OR A
                RET Z
                LD (.ProcessedUnits), A

                ; очистим счётчик выбранных элементов
                ; XOR A
                ; LD (CountSelectedRef), A

                ; включить страницу
                CALL Memory.SetPage1

                ; 
                LD HL, TilemapOffsetRef                                         ; HL = позиция X, указатель смещения тайловой карты (координаты тайла, верхнего левого угла)
                LD C, (HL)                                                      ; X
                INC L
                LD B, (HL)                                                      ; Y
                LD DE, SelectRectStartRef

                ; StartX  
                LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, C
                LD (.StartX), A

                ;
                INC DE

                ; StartY
                LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, B
                LD (.StartY), A

                ;
                INC DE

                ; EndX  
                LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, C
                LD (.EndX), A

                ;
                INC DE

                ; EndY
                LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, B
                LD (.EndY), A

                ; swap?
                ; LD C, A
                ; LD A, (.StartX)
                ; SUB C
                

                ;
                LD HL, .ProcessedUnits
                LD DE, (UnitArrayRef)
                INC D                                                           ; FSpriteLocation

.Loop           EX DE, HL
                LD C, (HL)
                INC L
                LD B, (HL)

                ; RES FUSF_SELECTED_BIT, (HL)
                LD A, #86 | FUSF_SELECTED_BIT << 3
                LD (.SET_RES), A

                ; TilePosition.X < StartX
                LD A, C
.StartX         EQU $+1
                SUB #00
                JR C, .Next                                                     ; jump if TilePosition.X < StartX

                ; TilePosition.Y < StartY
                LD A, B
.StartY         EQU $+1
                SUB #00
                JR C, .Next                                                     ; jump if TilePosition.Y < StartY

                ; TilePosition.Y > EndY
.EndY           EQU $+1
                LD A, #00
                SUB B
                JR C, .Next                                                     ; jump if TilePosition.Y > EndY

                ; TilePosition.X > EndX
.EndX           EQU $+1
                LD A, #00
                SUB C
                JR C, .Next                                                     ; jump if TilePosition.X > EndX

                LD A, L
                EXX
                RRA
                RRA
                AND %00111111
                CALL Pathfinding.PushUnit
                EXX

                ; RET C                                                           ; выход, т.к. буфер выделенных объектов переполнен
                ; ToDo "ScanRectSelect", "Warning : необходимо подать сигнал!"

  
                ; SET FUSF_SELECTED_BIT, (HL)
                LD A, #C6 | FUSF_SELECTED_BIT << 3
                LD (.SET_RES), A
                
.Next           ; ---------------------------------------------
                DEC H                                                           ; FUnitState.Direction              (1)
                DEC L                                                           ; FUnitState.State                  (1)
.SET_RES        EQU $+1
                DB #CB, #00                                                     ; SET FUSF_SELECTED_BIT, (HL) / RES FUSF_SELECTED_BIT, (HL)
                LD A, (HL)
                OR FUSF_RENDER
                LD (HL), A
                INC L                                                           ; FUnitState.Direction              (1)
                INC H                                                           ; FSpriteLocation.TilePosition.Y    (2)

                ; очистка юнита
                PUSH HL
                PUSH DE
                ; A - номер юнита
                LD A, L
                RRA
                RRA
                AND %00111111
                CALL Unit.RefUnitOnScr
                POP DE
                POP HL

                ;
                INC L
                INC L
                INC L
                
                EX DE, HL
                DEC (HL)
                JP NZ, .Loop

                RET

.ProcessedUnits DB #00

                endif ; ~ _CORE_MODULE_UNIT_SELECTED_RECT_
