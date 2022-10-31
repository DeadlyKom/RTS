
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
; -----------------------------------------
; инициализация после загрузки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PostInitialize: ; инициализация
.Surface        EQU $+1
                LD HL, #0000
                LD BC, Size.Tilemap.Surface

                PUSH HL
                PUSH BC

                ; -----------------------------------------
                ; перенос блока метаданных карты о юнитов
                ; -----------------------------------------
                LD DE, SharedBuffer
                ADD HL, BC
                LD C, (HL)
                LD B, #00
                INC HL
                CALL Memcpy.FastLDIR                                            ; перенос блока метаданных карты о юнитов

                ; -----------------------------------------
                ; перенос свойств тайлов (свойства всегда находятся после карты)
                ; -----------------------------------------
                POP BC
                POP HL

                LD DE, Adr.Tilemap.Surface
                OR A
                SBC HL, DE
                EX AF, AF'
                ADD HL, DE
                EX AF, AF'
                CALL NZ, Memcpy.FastLDIR                                        ; перенос свойств, если необходимо

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации
                ; -----------------------------------------
                LD DE, (Tilemap.Offset)
                CALL Game.Tilemap.GetAdrTilemap
                LD (Tilemap.CachedAddress), HL

                ; -----------------------------------------
                ; инициализация значений для работы с тайловой картой
                ; -----------------------------------------
                LD HL, Map.Size
  
                ; расчёт ограничения по горизонтали
                LD A, (HL)                                                      ; размер карты по горизонтали
                LD (Game.Tilemap.Move.Down.Increment), A                              
                NEG                                                             ; X = -X
                LD (Game.Tilemap.Move.Up.Decrement), A
                ADD A, SCREEN_TILE_X
                LD (Game.Tilemap.Move.Right.Clamp), A
                LD (Game.Tilemap.Memcpy.Buffer.RightClamp), A

                INC HL

                ; расчёт ограничений по вертикали
                LD A, (HL)                                                      ; размер карты по вертикали
                ; LD ( Utils.Tilemap.IsVisibleUnit.BottomClamp), A
                ADD A, -SCREEN_TILE_Y
                NEG
                LD (Game.Tilemap.Move.Down.Clamp), A
                LD (Game.Tilemap.Memcpy.Buffer.BottomClamp), A

                ; расчёт количество тайлов на экране TilemapWidth * TilesOnScreenY
                LD HL, #0000
                LD A, (Map.Width)
                LD E, A
                LD D, #00
                LD B, SCREEN_TILE_Y
                ADD HL, DE
                DJNZ $-1
                LD (Game.Tilemap.Memcpy.Buffer.BottomOffset), HL

                RET          

                display " - Load Level Post : \t\t\t\t\t", /A, PostInitialize, " = busy [ ", /D, $ - PostInitialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
