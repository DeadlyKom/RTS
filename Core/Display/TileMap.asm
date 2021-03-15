  
                ifndef _CORE_DISPLAY_TILE_MAP_
                define _CORE_DISPLAY_TILE_MAP_

DisplayTile:    
                LD A, (BC)
                ;JR C, .SpiritLevel
                EXX
                ; расчёт адрес спрайта
                LD H, HIGH MemoryPage_0.TileSprites;#C0
                ADD A, A
                LD L, A
                LD SP, HL
                POP HL
                LD SP, HL
                ; HL - адрес начала строки экрана
                LD H, B
                LD L, C
                ; рисуем верхнюю часть
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
                ; переход к нижней части
                LD A, #20
                ADD A, L
                LD L, A
                ; рисуем нижнюю часть
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
                ; переход к следующей колонке
                INC C
                INC C
                ; переход к следующей ячейке тайла
                EXX
                INC C
                INC HL
                INC HL
                JP (HL)
DisplayTileMap: DI
                LD (.ContainerSP), SP
                ; переключить на страницу памяти со спрайтами тайлов
                LD BC, PORT_7FFD
                LD A, %00010000
                OUT (C), A
                ; инициализация отрисовки
                LD DE, #0000
                LD BC, MemoryPage_5.TileMap 
                LD IX, DisplayTile
                defarray Table #4000, #4040, #4080, #40C0, #4800, #4840, #4880, #48C0, #5000, #5040, #5080;, #50C0
.Line           defl 0
                dup Table[#]
                EXX
                LD BC, Table[.Line]
                EXX
                LD HL, $+3
                rept 16                             ; количество колонок
                JP (IX)
                endr
                ; перейти к следующей строке тайловой карыт
                LD HL, #0030                        ; -16 + 64 = 48
                ADD HL, BC
                LD B, H
                LD C, L
.Line = .Line + 1
                edup
                ;endr
                EXX
                LD BC, #50C0
                EXX
                LD HL, $+3
                rept 16                             ; количество колонок
                JP (IX)
                endr

.ContainerSP    EQU $+1
                LD SP, #0000
                EI
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