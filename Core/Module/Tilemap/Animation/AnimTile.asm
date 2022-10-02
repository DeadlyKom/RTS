
                ifndef _MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
                define _MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
; -----------------------------------------
; обновление анимации участка карты находящиеся в рендер буфере
; In:
;    HL - указывает на переменную GameVar.TilemapCountdown
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimTile:       ; установка обратного счётчика
                LD (HL), DURATION_TILE_ANIM

                ; проверка наличие в буфере анимированных тайлов
                LD A, (.Size)
                OR A
                CALL M, Sampling                                                ; если в массиве есть свободное место, произвести выборку тайла

                ; пройтись по всем анимациям
                LD A, (.Size)
                ADD A, ANIMATED_TILES
                RET Z                                                           ; выход в массиве нет анимированных тайлов

                ; инициализация поиска элемента
                LD HL, .Array
                LD D, HIGH RenderBuffer
                LD B, A
                LD C, %01110000

.Loop           LD A, B
                INC A

.SearchValid    ; поиск валидного элемента
                LD E, (HL)                                                      ; чтение FAnimTile.Offset
                INC HL

                BIT 7, (HL)
                JR Z, .ValidElement
                INC HL

                DEC A
                JR NZ, .SearchValid

                RET

.ValidElement   DEC (HL)
                JP M, .DecNextElement                                           ; счётчик обнулён, элемент не валидный

                LD A, (HL)
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A

                EX DE, HL
                XOR (HL)
                AND C
                XOR (HL)
                OR #03                                                          ; полный цикл обновления тайла
                LD (HL), A
                EX DE, HL

.NextElement    INC HL
                DJNZ .Loop

                RET

.DecNextElement ; уменьшение счётчика
                LD A, (.Size)
                DEC A
                LD (.Size), A
                JR .NextElement

.Array:         FAnimTile = $
                DS FAnimTile * ANIMATED_TILES, #FF
.Size:          DB -ANIMATED_TILES                                              ; количество свободных элементов

Sampling:       ; выборка тайла для анимации
                CALL TileSampling
                RET C                                                           ; выход, не получилось найти анимированный тайл

                ; поиск свободной ячейки
                LD HL, AnimTile.Array
                LD B, ANIMATED_TILES
                LD A, #FF

.NextLoop       INC HL
                CP (HL)
                JR Z, .SetSampling 
                INC HL
                DJNZ .NextLoop
                RET

.SetSampling    ; сохранение данных
                LD (HL), E
                DEC HL
                EX AF, AF'
                LD (HL), A  ; FAnimTile.Offset

                ; увеличение счётчика
                LD HL, AnimTile.Size
                INC (HL)

                RET

                display " - Anim Tile : \t\t\t", /A, AnimTile, " = busy [ ", /D, $ - AnimTile, " bytes  ]"

                endif ; ~_MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
