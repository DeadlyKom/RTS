
                ifndef _CONST_MAIN_MENU_
                define _CONST_MAIN_MENU_

                module Page
                module Module
Menu            EQU PAGE_5                                                      ; страница меню
CaptainBridge   EQU PAGE_0                                                      ; страница графики "капитанский мостик"
Graphics_A      EQU PAGE_1                                                      ; страница графики меню

                endmodule
Core            EQU Module.Menu
Main            EQU Module.Menu
Options         EQU Module.Menu
CaptainBridge   EQU Module.CaptainBridge
Graphics:
.A              EQU Module.Graphics_A
                endmodule

                module Adr
Menu:           EQU MemBank_01_DOS
CaptainBridge:  EQU MemBank_01_DOS

                module Module
Core            EQU Adr.Menu
Options:        EQU Adr.Module.Core + Menu.Core.Size
MenuText:       EQU Adr.Module.Options + Menu.Options.Size
Main:           EQU Adr.Module.MenuText + Language.Text.Menu.Size
CaptainBridge:  EQU Adr.CaptainBridge
MsgText:        EQU Adr.Module.CaptainBridge + Menu.CaptainBridge.Size

Graphics:
.A              EQU MemBank_03
.Interact_1     EQU MemBank_03 + Menu.Graphics.Interact_1
.Interact_2     EQU MemBank_03 + Menu.Graphics.Interact_2
.Interact_3     EQU MemBank_03 + Menu.Graphics.Interact_3
.Interact_4     EQU MemBank_03 + Menu.Graphics.Interact_4
.Interact_5     EQU MemBank_03 + Menu.Graphics.Interact_5
.Interact_6     EQU MemBank_03 + Menu.Graphics.Interact_6
.Interact_7     EQU MemBank_03 + Menu.Graphics.Interact_7
.Interact_8     EQU MemBank_03 + Menu.Graphics.Interact_8
.Interact_9     EQU MemBank_03 + Menu.Graphics.Interact_9
.Interact_10    EQU MemBank_03 + Menu.Graphics.Interact_10

; анимация 1 фрейма (левая)
.Cooler_1_0     EQU MemBank_03 + Menu.Graphics.Cooler_1_0
.Cooler_1_1     EQU MemBank_03 + Menu.Graphics.Cooler_1_1
.Cooler_1_2     EQU MemBank_03 + Menu.Graphics.Cooler_1_2
.Cooler_2_0     EQU MemBank_03 + Menu.Graphics.Cooler_2_0
.Cooler_2_1     EQU MemBank_03 + Menu.Graphics.Cooler_2_1
.Cooler_2_2     EQU MemBank_03 + Menu.Graphics.Cooler_2_2
.Monitor_0      EQU MemBank_03 + Menu.Graphics.Monitor_0
.Monitor_1      EQU MemBank_03 + Menu.Graphics.Monitor_1
.Monitor_2      EQU MemBank_03 + Menu.Graphics.Monitor_2
.Storage_0      EQU MemBank_03 + Menu.Graphics.Storage_0
.Storage_1      EQU MemBank_03 + Menu.Graphics.Storage_1
.Storage_2      EQU MemBank_03 + Menu.Graphics.Storage_2

                endmodule
                endmodule

                endif ; ~_CONST_MAIN_MENU_
