
                ifndef _CONST_MAIN_MENU_
                define _CONST_MAIN_MENU_

                module Page
                module Module
Menu            EQU 0x05                                                        ; страница меню
MenuGraphics    EQU 0x00                                                        ; страница графики меню

                endmodule
Core            EQU Module.Menu
Main            EQU Module.Menu
Options         EQU Module.Menu
NewGame         EQU Module.Menu
MenuGraphics:
.A              EQU Module.MenuGraphics
                endmodule


                module Adr
Menu:           EQU MemBank_01_DOS

                module Module
Core            EQU Adr.Menu
Options:        EQU Adr.Module.Core + Menu.Core.Size
Text:           EQU Adr.Module.Options + Menu.Options.Size
Main:           EQU Adr.Module.Text + Language.Text.Menu.Size
NewGame:        EQU Adr.Module.Main + Menu.Main.Size

MenuGraphics:
.A              EQU MemBank_03
.Interact_1     EQU MemBank_03 + Menu.MenuGraphics.Interact_1
.Interact_2     EQU MemBank_03 + Menu.MenuGraphics.Interact_2
.Interact_3     EQU MemBank_03 + Menu.MenuGraphics.Interact_3
.Interact_4     EQU MemBank_03 + Menu.MenuGraphics.Interact_4
.Interact_5     EQU MemBank_03 + Menu.MenuGraphics.Interact_5
.Interact_6     EQU MemBank_03 + Menu.MenuGraphics.Interact_6
.Interact_7     EQU MemBank_03 + Menu.MenuGraphics.Interact_7
.Interact_8     EQU MemBank_03 + Menu.MenuGraphics.Interact_8
.Interact_9     EQU MemBank_03 + Menu.MenuGraphics.Interact_9
.Interact_10    EQU MemBank_03 + Menu.MenuGraphics.Interact_10

; анимация 1 фрейма (левая)
.Cooler_1_0     EQU MemBank_03 + Menu.MenuGraphics.Cooler_1_0
.Cooler_1_1     EQU MemBank_03 + Menu.MenuGraphics.Cooler_1_1
.Cooler_1_2     EQU MemBank_03 + Menu.MenuGraphics.Cooler_1_2
.Cooler_2_0     EQU MemBank_03 + Menu.MenuGraphics.Cooler_2_0
.Cooler_2_1     EQU MemBank_03 + Menu.MenuGraphics.Cooler_2_1
.Cooler_2_2     EQU MemBank_03 + Menu.MenuGraphics.Cooler_2_2
.Monitor_0      EQU MemBank_03 + Menu.MenuGraphics.Monitor_0
.Monitor_1      EQU MemBank_03 + Menu.MenuGraphics.Monitor_1
.Monitor_2      EQU MemBank_03 + Menu.MenuGraphics.Monitor_2
.Storage_0      EQU MemBank_03 + Menu.MenuGraphics.Storage_0
.Storage_1      EQU MemBank_03 + Menu.MenuGraphics.Storage_1
.Storage_2      EQU MemBank_03 + Menu.MenuGraphics.Storage_2

                endmodule
                endmodule

                endif ; ~_CONST_MAIN_MENU_
