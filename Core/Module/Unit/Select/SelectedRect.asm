
                ifndef _CORE_MODULE_UNIT_SELECTED_RECT_
                define _CORE_MODULE_UNIT_SELECTED_RECT_

; -----------------------------------------
; сканирование выделение прямоугольником
; In:
;   IX - указывает на структуру FUnit
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
                SET_PAGE_UNITS_ARRAY

                ; single selected
                LD HL, SelectRectStartRef
                LD E, (HL)                                                      ; StartX
                INC HL
                LD D, (HL)                                                      ; StartY
                INC HL

                ; DeltaX = EndX - StartX
                LD A, (HL)                                                      ; EndX
                SUB E
                CP #02
                LD A, #37
                JR NC, .NotSingle

                ; DeltaY = EndY - StartY
                INC HL
                LD A, (HL)  ; EndY
                SUB D
                CP #02
                LD A, #37                                                       ; (SCF)
                JR NC, .NotSingle    
                LD A, #B7                                                       ; is single selected (OR A)

.NotSingle      LD (.IsSingle_), A
                LD A, #37
                LD (.IsSingle), A
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
                LD IX, UnitArrayPtr

.Loop           LD BC, (IX + FUnit.Position)

                ; RES FUSF_SELECTED_BIT, (HL)
                LD A, #86 | FUSF_SELECTED_BIT << 3
                LD (.SET_RES), A




                ; RES FUSF_ATTACK_BIT, (IX + FUnit.State)
                ; XOR A
                ; LD (IX + FUnit.Animation), A



.IsSingle       EQU $
                SCF
                JR NC, .Next

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
                CALL Utils.GetIdxUnit

                ; сохраним индекс
.NumSelected    EQU $+1                                                         ; количество выделенных юнитов в буфере
                LD DE, #0000
                LD (DE), A
                
                ; перейдём к следующему элементу
                INC E
                BIT 5, E
                JP NZ, SFX.BEEP.Fail                                            ; выход, т.к. буфер выделенных объектов переполнен
                LD (.NumSelected), DE
  
                ; SET FUSF_SELECTED_BIT, (HL)
                LD A, #C6 | FUSF_SELECTED_BIT << 3
                LD (.SET_RES), A

                ; SET FUSF_ATTACK_BIT, (IX + FUnit.State)

.IsSingle_      EQU $
                SCF
                JR C, .Next

                ; is single selected
                LD A, #B7                                                       ; is single selected (OR A)
                LD (.IsSingle), A

.Next           ; ---------------------------------------------
.SET_RES        EQU $+3
                SET FUSF_SELECTED_BIT, (IX + FUnit.State)
                
                ; пометим что юнита необходимо обноить
                LD A, FUSF_RENDER
                OR (IX + FUnit.State)
                LD (IX + FUnit.State), A

                ; очистка юнита
                PUSH HL
                CALL Unit.RefUnitOnScr
                POP HL

                ; переход к следующему юниту
                LD DE, UNIT_SIZE
                ADD IX, DE
                DEC (HL)
                JP NZ, .Loop

                RET

.ProcessedUnits DB #00

                endif ; ~ _CORE_MODULE_UNIT_SELECTED_RECT_
