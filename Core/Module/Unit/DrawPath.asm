
                ifndef _CORE_MODULE_UNIT_DRAW_PATH_
                define _CORE_MODULE_UNIT_DRAW_PATH_

; DE = FUnit   (1)
DrawPath:       LD IXH, D
                LD IXL, E
                BIT FUTF_VALID_WP_BIT, (IX + FUnit.Data)                        ; бит валидности Way Point
                RET Z

                 ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; ---------------------------------------------
                CALL Utils.WaypointsSequencer.GetCurrentWaypoint

                LD B, H
                LD C, L
                LD HL, TilemapOffsetRef

                ; A = LxE - VxE
                LD A, (BC)
                SUB (HL)
                ADD A, A
                INC A
                ADD A, A
                ADD A, A
                ADD A, A
                EX AF, AF'

                INC L                                               ; HL = TilemapOffsetHeight
                INC B                                               ; BC = Y 

                ; A = LyE - VyE
                LD A, (BC)
                SUB (HL)
                ADD A, A
                INC A
                ADD A, A
                ADD A, A
                ADD A, A

                LD D, A
                EX AF, AF'
                LD E, A

                ; A = LyS - VyS
                LD A, (IX + FUnit.Position.Y)
                SUB (HL)

                ADD A, A
                INC A
                ADD A, A
                ADD A, A
                ADD A, A

                ADD A, (IX + FUnit.Offset.Y)
                EX AF, AF'

                DEC L                                               ; HL = TilemapOffsetWidth

                ; A = LxS - VxS
                LD A, (IX + FUnit.Position.X)
                SUB (HL)

                ADD A, A
                INC A
                ADD A, A
                ADD A, A
                ADD A, A

                ADD A, (IX + FUnit.Offset.X)
                
                LD L, A
                EX AF, AF'
                LD H, A

                ;   HL  - (H - y, L - x) start point    (S)
                ;   DE  - (D - y, E - x) end point      (E)
                CALL Memory.SetPage7
                CALL DrawLine
                SET_PAGE_UNITS_ARRAY

                RET

                endif ; ~ _CORE_MODULE_UNIT_DRAW_PATH_