  
                ifndef _CORE_DISPLAY_TILE_MAP_
                define _CORE_DISPLAY_TILE_MAP_

DisplayTile:    ;
                LD A, (BC)
                ;JR C, .SpiritLevel
                EXX
                ; calculation sprite address
                ADD A, A
                JR NC, .SkipMask
                LD HL, MemoryPage_0.FulltMask
                JR .Fill
.SkipMask       LD H, HIGH MemoryPage_0.TableSprites
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
                INC C
                INC C
                ; move to the next cell in a tile
                EXX
                INC C
                INC HL
                INC HL
                JP (HL)
DisplayTileMap: ; initialize execute blocks
                DI
                LD (.ContainerSP), SP
                ; toggle to memory page with tile sprites
                LD BC, PORT_7FFD
                LD A, %00010000 | Page_TitleMapSprites
                OUT (C), A
                ; initialize display row of tile
                LD A, #03
                LD (.CountExecute), A
.TileMapRow     EQU $+1
                LD BC, MemoryPage_5.TileMap 
                LD IX, DisplayTile
                LD IY, .CheckExecuted
                ; 
.ExecuteBlocks  EQU $+1
                LD HL, .FirstBlock
                JP (HL)
                ;
.FirstBlock     EQU $
                defarray Table #4000, #4040, #4080, #40C0, #4800, #4840, #4880, #48C0, #5000, #5040, #5080;, #50C0
.Line           defl 0
                dup Table[#]
                EXX
                LD BC, Table[.Line]
                EXX
                LD HL, $+3
                rept 16                             ; number of columns per row
                JP (IX)
                endr
                ; calculate next line of the tilemap
                LD HL, #0030                        ; -16 + 64 = 48
                ADD HL, BC
                LD B, H
                LD C, L
                ;
                LD HL, $+5
                JP (IY)               
.Line = .Line + 1
                edup
                EXX
                LD BC, #50C0
                EXX
                LD HL, $+3
                rept 16                             ; number of columns per row
                JP (IX)
                endr
                LD HL, .FirstBlock
                LD BC, MemoryPage_5.TileMap
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
                LD DE, #0131
                RET
DisplayTileFOW: ;
                LD A, (BC)
                RRA
                JP C, .NextTile                                         ; текущий тайл невидим (переходим к следующему)
.CheckLeft      ; проверим на достижение левого края тайловой карты
                LD A, D
                SUB #01
                JP C, .LeftEdge                                         ; достигли левый край карты
                ; прочитаем значение слева от текущей
                DEC BC
                LD A, (BC)
                RRA
                RL L                                                    ; запись первого бита (находящийся слева)
.ChecRight      ; проверим на достижение правого края тайловой карты
                LD A, D
                INC A
                CP 64
                CCF
                JR C, .RightEdge                                        ; достигли правый край карты
                ; прочитаем значение справа от текущей
                INC BC
                INC BC
                LD A, (BC)
                RRA
.RightEdge      RL L                                                    ; запись второго бита (находящийся справа)
                JP .CheckTop

.LeftEdge       ; т.к. мы находимся у левого края, проверять на превышение справа, не нужно!
                RL L                                                    ; запись первого бита (находящийся слева)
                ; прочитаем значение слева от текущей
                INC BC
                LD A, (BC)
                RRA
                RL L                                                    ; запись второго бита (находящийся справа)
.CheckTop       ; проверим на достижение верхнего края тайловой карты
                LD A, E
                SUB #01
                JP C, .TopEdge
                ; прочитаем значение сверху от текущей
                LD A, C
                SUB #41                                                 ; 65
                LD C, A
                JR C, $+3
                DEC B
                LD A, (BC)
                RRA
                RL L                                                    ; запись третьего бита (находящийся сверху)
.CheckBottom    ; проверим на достижение нижнего края тайловой карты
                LD A, E
                INC A
                CP 64
                CCF
                JR C, .BottomEdge                                       ; достигли нижний край карты
                ; прочитаем значение снизу от текущей
                LD A, C
                ADD A, #80
                LD C, A
                JR C, $+3
                INC B
                LD A, (BC)
                RRA
.BottomEdge     RL L                                                    ; запись четвёртого бита (находящийся снизу)
                JP .CheckDrawFOW

.TopEdge        ; т.к. мы находимся у верхнего края, проверять на превышение снизу, не нужно!
                RL L                                                    ; запись третьего байта (находящийся сверху)
                ; прочитаем значение снизу от текущей
                LD A, C
                ADD A, #3F                                              ; 63
                LD C, A
                JR C, $+3
                INC B
                LD A, (BC)
                RRA
                RL L                                                    ; запись четвёртого бита (находящийся снизу)
.CheckDrawFOW   ; проверим что получили вокруг текущей позиции
                LD A, %00001111
                AND L
                JP Z, .NextTile                                         ; вокруг текущего тайла нет заполненых тайлов (переходим к следующему)
                EXX
                EX DE, HL
                DEC A
                ADD A, A
                LD HL, MemoryPage_0.TableSprites
                ADD A, L
                LD L, A
                JR C, $+3
                INC H
                ; получим адрес спрайта
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                ; рисуем верхнюю часть
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
                ; переход к следующей колонке
                INC C
                INC C









                
.NextTile       ; переход к следующему тайлу
                EXX
                ;INC D
                INC HL
                INC HL
                JP (HL)

                RET
  
; TileAddressTable:
;                 DW #4000 + #0000 + #00
;                 DW #4000 + #0000 + #40
;                 DW #4000 + #0000 + #80
;                 DW #4000 + #0000 + #C0
;                 DW #4000 + #0800 + #00
;                 DW #4000 + #0800 + #40
;                 DW #4000 + #0800 + #80
;                 DW #4000 + #0800 + #C0
;                 DW #4000 + #1000 + #00
;                 DW #4000 + #1000 + #40
;                 DW #4000 + #1000 + #80
;                 DW #4000 + #1000 + #C0

                endif ; ~_CORE_DISPLAY_TILE_MAP_