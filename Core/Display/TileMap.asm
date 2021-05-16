  
                ifndef _CORE_DISPLAY_TILE_MAP_
                define _CORE_DISPLAY_TILE_MAP_

                defarray TileAddressTable #4000, #4040, #4080, #40C0, #4800, #4840, #4880, #48C0, #5000, #5040, #5080;, #50C0
DisplayTileRow: ;
                LD A, (BC)
                ;JR C, .SpiritLevel
                EXX
                ; calculation sprite address
                ADD A, A
                JP C, .NextTile
                ;JR NC, .SkipMask
                ;LD HL, MemoryPage_0.FulltMask
                ;JR .Fill
.SkipMask       LD H, HIGH MemoryPage_7.TableSprites
                LD L, A
                LD SP, HL
                POP HL
.Fill           LD SP, HL
                ; HL - the address of the start of the screen line
                LD H, B
                LD L, C
                ; draw the sprite top part
                rept 3
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                INC H
                endr
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                ; calculation to the sprite bottom part
                LD A, #20
                ADD A, L
                LD L, A
                ; draw the sprite bottom part
                rept 3
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                DEC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                DEC H
                endr
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                DEC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                ; move to next column
.NextTile       INC C
                INC C
                ; move to the next cell in a tile
                EXX
                INC BC
                INC HL
                INC HL
                JP (HL)

; InitTilemap:    LD HL, MemoryPage_5.TileMapSize
;                 ;
;                 LD A, (HL)
;                 LD (Tilemap_Down.Increment), A
;                 NEG                                         ; X = -X
;                 LD (Tilemap_Up.Decrement), A
;                 ADD A, #10                                  ; -X += 16
;                 LD (Tilemap_Right.Clamp), A
;                 ;
;                 INC HL                                      ; move to Y
;                 ; -(Y - 12)
;                 LD A, (HL)
;                 ADD A, #F4
;                 NEG
;                 LD (Tilemap_Down.Clamp), A
;                 RET

; Tilemap_Up:     ;
;                 LD HL, MemoryPage_5.TileMapOffset.Y
;                 XOR A
;                 OR (HL)
;                 RET Z
;                 DEC (HL)
;                 LD HL, (MemoryPage_5.TileMapPtr)
; .Decrement      EQU $+1
;                 LD DE, #FF00
;                 ADD HL, DE
;                 LD (MemoryPage_5.TileMapPtr), HL
;                 RET
; Tilemap_Down:   ;
;                 LD HL, MemoryPage_5.TileMapOffset.Y
; .Clamp          EQU $+1
;                 LD A, #00
;                 ADD A, (HL)
;                 RET C
;                 INC (HL)
;                 LD HL, (MemoryPage_5.TileMapPtr)
; .Increment      EQU $+1
;                 LD DE, #0000
;                 ADD HL, DE
;                 LD (MemoryPage_5.TileMapPtr), HL
;                 RET
; Tilemap_Left:   ;
;                 LD HL, MemoryPage_5.TileMapOffset.X
;                 XOR A
;                 OR (HL)
;                 RET Z
;                 DEC (HL)
;                 LD HL, (MemoryPage_5.TileMapPtr)
;                 DEC HL
;                 LD (MemoryPage_5.TileMapPtr), HL
;                 RET
; Tilemap_Right:  ;
;                 LD HL, MemoryPage_5.TileMapOffset.X
; .Clamp          EQU $+1
;                 LD A, #00
;                 ADD A, (HL)
;                 RET C
;                 INC (HL)
;                 LD HL, (MemoryPage_5.TileMapPtr)
;                 INC HL
;                 LD (MemoryPage_5.TileMapPtr), HL
;                 RET

PrepareTilemap: LD HL, (MemoryPage_5.TileMapPtr)
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Tilemap
                ; copy the visible block of the tilemap
                LD DE, SharedBuffer                         ; MemoryPage_5.TileMapBuffer
                rept 11
                rept 16
                LDI
                endr
                LD BC, #0030
                ADD HL, BC
                endr
                rept 16
                LDI
                endr
                RET
DisplayTilemap: ; initialize execute blocks
                DI
                LD (.ContainerSP), SP
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_TilSprites
                ; initialize display row of tile
                LD A, #03                                               ; number of code blocks executed
                LD (.CountExecute), A
.TileMapRow     EQU $+1
                LD BC, MemoryPage_5.TileMapBuffer 
                LD IX, DisplayTileRow
                LD IY, .CheckExecuted
                ; 
.ExecuteBlocks  EQU $+1
                LD HL, .FirstBlock
                JP (HL)
                ;
.FirstBlock     EQU $
.Row            defl 0
                dup TileAddressTable[#]
                EXX
                LD BC, TileAddressTable[.Row]
                EXX
                LD HL, $+3
                rept 16                                                 ; number of columns per row
                JP (IX)
                endr
                ;
                LD HL, $+5
                JP (IY)               
.Row = .Row + 1
                edup
                EXX
                LD BC, #50C0
                EXX
                LD HL, $+3
                rept 16                                                 ; number of columns per row
                JP (IX)
                endr
                LD HL, .FirstBlock
                LD BC, MemoryPage_5.TileMapBuffer
                JR .Exit
.CheckExecuted
.CountExecute   EQU $+1
                LD A, #00
                DEC A
                LD (.CountExecute), A
                JR Z, .Exit
                JP (HL)
                
.Exit           LD (.ExecuteBlocks), HL
                LD (.TileMapRow), BC
.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                LD DE, #0131                                            ; the time wasted to execute this block of code
                RET
DisplayTileFOW: ;
                ;DI
                ;LD (.ContainerSP), SP
                ; переключить на страницу памяти со спрайтами тайлов
                SeMemoryPage MemoryPage_Tilemap
                ; инициализация отрисовки
                LD BC, (MemoryPage_5.TileMapPtr) 
                LD IX, DisplayRowFOW
.Row            defl 0
                dup TileAddressTable[#]
                EXX
                LD BC, TileAddressTable[.Row]
                LD HL, $+3
                rept 16                             ; количество колонок
                JP (IX)
                endr
                ; перейти к следующей строке тайловой карыт
                EXX
                LD HL, #0030                        ; -16 + 64 = 48
                ADD HL, BC
                LD B, H
                LD C, L
.Row = .Row + 1
                edup
                EXX
                LD BC, #50C0
                LD HL, $+3
                rept 16                             ; количество колонок
                JP (IX)
                endr

;.ContainerSP    EQU $+1
                ;LD SP, #0000
                ;EI
                LD DE, #0200
                RET

DisplayRowFOW:  ;
                EXX
                LD A, (BC)
                RLA
                ;JP C, .NextTile                                         ; текущий тайл невидим (переходим к следующему)
                JP NC, .SkipFill
                EXX
                EX DE, HL
                LD HL, MemoryPage_1.FulltMask
                JP .DrawTileFOW
.SkipFill       ;
                LD D, B
                LD E, C
.CheckLeft      ; проверим на достижение левого края тайловой карты
                LD A, C
                AND %00111111
                SUB #01
                JP C, .LeftEdge                                         ; достигли левый край карты
                ; прочитаем значение слева от текущей
                DEC C
                LD A, (BC)
                RLA
                RL L                                                    ; запись первого бита (находящийся слева)
.CheckRight     ; проверим на достижение правого края тайловой карты
                INC C
                LD A, C
                AND %00111111
                ADD A, %11000001                                        ; -63
                JR C, .RightEdge                                        ; достигли правый край карты
                ; прочитаем значение справа от текущей
                INC C
                LD A, (BC)
                RLA
.RightEdge      RL L                                                    ; запись второго бита (находящийся справа)
                JP .CheckTop

.LeftEdge       ; т.к. мы находимся у левого края, проверять на превышение справа, не нужно!
                RL L                                                    ; запись первого бита (находящийся слева)
                ; прочитаем значение слева от текущей
                INC C
                LD A, (BC)
                RLA
                RL L                                                    ; запись второго бита (находящийся справа)
.CheckTop       ; проверим на достижение верхнего края тайловой карты
                LD A, B
                AND %00001111
                JP NZ, .Top
                LD A, C
                AND %11000000
                SUB %01000000
                JP C, .TopEdge
.Top            ; прочитаем значение сверху от текущей
                LD A, C
                SUB #41                                                 ; 65
                LD C, A
                JR NC, $+3
                DEC B
                LD A, (BC)
                RLA
                RL L                                                    ; запись третьего бита (находящийся сверху)
                LD B, D
.CheckBottom    ; проверим на достижение нижнего края тайловой карты
                LD A, E
                AND %11000000
                ADD A, %01000000
                LD C, A
                EX AF, AF'
                LD A, E
                AND %00111111
                OR C
                LD C, A
                EX AF, AF'
                JR NC, .Bottom
                LD A, B
                AND %00001111
                ADD A, %11110001                                        ;
                JR C, .BottomEdge                                       ; достигли нижний край карты
                INC B
.Bottom         ; прочитаем значение снизу от текущей
                LD A, (BC)
                RLA
.BottomEdge     RL L                                                    ; запись четвёртого бита (находящийся снизу)
                JP .CheckDrawFOW

.TopEdge        ; т.к. мы находимся у верхнего края, проверять на превышение снизу, не нужно!
                RL L                                                    ; запись третьего байта (находящийся сверху)
                ; прочитаем значение снизу от текущей
                LD A, C
                ADD A, #3F                                              ; 63
                LD C, A
                JR NC, $+3
                INC B
                ;INC D
                LD A, (BC)
                RLA
                RL L                                                    ; запись четвёртого бита (находящийся снизу)
.CheckDrawFOW   ;
                LD B, D
                LD C, E
                ; проверим что получили вокруг текущей позиции
                LD A, %00001111
                AND L
                JP Z, .NextTile                                         ; вокруг текущего тайла нет заполненых тайлов (переходим к следующему)
                EXX
                EX DE, HL
                DEC A
                ADD A, A
                LD HL, MemoryPage_1.TableFOW
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                ; получим адрес спрайта
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
.DrawTileFOW    ; рисуем верхнюю часть
                rept 3
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC B
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC B
                INC HL
                endr
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC B
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC HL
                ; переход к нижней части
                LD A, #20
                ADD A, C
                LD C, A
                ; рисуем нижнюю часть
                rept 3
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC B
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC B
                INC HL
                endr
                LD A, (BC)
                OR (HL)
                LD (BC), A
                INC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC B
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                DEC C
                INC HL
                LD A, (BC)
                OR (HL)
                LD (BC), A
                ; переход к следующей колонке
                LD A, #E2
                ADD A, C
                LD C, A
                EX DE, HL
                DEC C
                DEC C
                EXX             
                ; переход к следующему тайлу               
.NextTile       INC BC
                EXX
                INC C
                INC C
                INC HL
                INC HL
                JP (HL)

                RET

                endif ; ~_CORE_DISPLAY_TILE_MAP_