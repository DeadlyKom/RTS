
                ifndef _CONST_MAIN_MENU_
                define _CONST_MAIN_MENU_

                module Page
                module Module
Menu            EQU 0x05                                                        ; страница загрузчика

                endmodule
Core            EQU Module.Menu
Main            EQU Module.Menu
Options         EQU Module.Menu
                endmodule


                module Adr
Menu:           EQU MemBank_01_DOS

                module Module
Core            EQU Adr.Menu
Options:        EQU Adr.Module.Core + Menu.Core.Size
Text:           EQU Adr.Module.Options + Menu.Options.Size
Main:           EQU Adr.Module.Text + Language.Text.Menu.Size

                endmodule
                endmodule

                endif ; ~_CONST_MAIN_MENU_
