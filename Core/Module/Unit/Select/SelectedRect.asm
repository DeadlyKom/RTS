
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

                ; включить страницу
                CALL Memory.SetPage1

                ; single selected
                LD HL, SelectRectStartRef
                LD E, (HL)  ; StartX
                INC HL
                LD D, (HL)  ; StartY
                INC HL

                ; DeltaX = EndX - StartX
                LD A, (HL)  ; EndX
                SUB E
                CP #02
                LD A, #37
                JR NC, .NotSingle

                ; DeltaY = EndY - StartY
                INC HL
                LD A, (HL)  ; EndY
                SUB D
                CP #02
                LD A, #37
                JR NC, .NotSingle    
                LD A, #B7                                                       ; is single selected

.NotSingle      LD (.IsSingle), A
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

                ; swap Y?
                LD C, A
                LD A, (.StartY)
                LD B, A
                SUB C
                JR C, .SkipSwapY
                LD A, B
                LD (.EndY), A
                LD A, C
                LD (.StartY), A
.SkipSwapY
                ; swap X?
                LD A, (.EndX)
                LD C, A
                LD A, (.StartX)
                LD B, A
                SUB C
                JR C, .SkipSwapX
                LD A, B
                LD (.EndX), A
                LD A, C
                LD (.StartX), A
.SkipSwapX                
                LD HL, SelectedBufferFirst
                LD (NumberSelectedUnitRef), HL

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

                ; добавим индекс выделенного юнита в список
                LD A, L
                EXX
.NumSelected    EQU $+1                                                         ; количество выделенных юнитов в буфере
                LD HL, #0000

                ; получим индекс юнита
                RRA
                RRA
                AND %00111111
                LD (HL), A                                                      ; сохраним индекс
                
                ; перейдём к следующему элементу
                INC L
                BIT 5, L
                JP NZ, SFX.BEEP.Fail                                            ; выход, т.к. буфер выделенных объектов переполнен
                LD (.NumSelected), HL
                EXX
  
                ; SET FUSF_SELECTED_BIT, (HL)
                LD A, #C6 | FUSF_SELECTED_BIT << 3
                LD (.SET_RES), A

.IsSingle       EQU $
                SCF
                JR C, .Next
                ; is single selected
                LD A, #01
                LD (.ProcessedUnits), A

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
