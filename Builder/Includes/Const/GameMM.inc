
                ifndef _CONST_GAME_MEMORY_MAP_
                define _CONST_GAME_MEMORY_MAP_

                module Page
                module Module
GameFirst       EQU 0x05                                                        ; первая страница игрового кода
GameSecond      EQU 0x01                                                        ; вторая страница игрового кода
GameThird       EQU 0x00                                                        ; третий страница игрового кода

                endmodule
Game:
.First          EQU Module.GameFirst
.Second         EQU Module.GameSecond
.Third          EQU Module.GameThird

                endmodule

                module Adr
EntryPoint      EQU MemBank_01_DOS
ModuleTile      EQU Adr.Module.FileSystem - Game.SizeSecond

                module Module
Game:
.First          EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"
.Second         EQU Adr.ModuleTile                                              ; адрес модуля "работы с тайлами"
.Third          EQU Adr.EntryPoint

                endmodule

                endmodule

                endif ; ~_CONST_GAME_MEMORY_MAP_
