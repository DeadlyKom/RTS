
                ifndef _CONST_GAME_MEMORY_MAP_
                define _CONST_GAME_MEMORY_MAP_

                module Page
                module Module
GameMain        EQU PAGE_5                                                      ; модуль "основной блок"
GameUnit        EQU PAGE_0                                                      ; модуль "работы с юнитами"
GameTilemap     EQU PAGE_1                                                      ; модуль "работа с тайлами"
GameTilemapEx   EQU PAGE_7                                                      ; модуль "работа с тайлами расширение"

                endmodule
Game:
.Main           EQU Module.GameMain
.Unit           EQU Module.GameUnit
.Tilemap        EQU Module.GameTilemap
.TilemapEx      EQU Module.GameTilemapEx

                endmodule

                module Adr
EntryPoint      EQU MemBank_01_DOS
Unit:           EQU MemBank_03
UnitCode:       EQU MemBank_03 + BankSize - Game.SizeUnitCode
Tilemap:        EQU MemBank_03
TilemapCode:    EQU Adr.Module.FileSystem - Game.SizeTilemapCode

                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"
.Unit           EQU Adr.Unit
.UnitCode       EQU Adr.UnitCode
.Tilemap        EQU Adr.Tilemap
.TilemapCode    EQU Adr.TilemapCode                                             ; адрес модуля "работы с тайлами"
.TilemapEx      EQU Adr.Tilemap.BypassFOW                                       ; адрес модуля "работа с тайлами расширение"


                endmodule
                endmodule

                endif ; ~_CONST_GAME_MEMORY_MAP_
