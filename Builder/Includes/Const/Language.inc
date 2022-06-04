
                ifndef _CONST_LANGUAGE_
                define _CONST_LANGUAGE_

                define LocalizationFunc SetPage6

                module Page
                module Module
Language        EQU 0x06                                                        ; страница загрузчика

                endmodule
Russian         EQU Module.Language
Spanish         EQU Module.Language
English         EQU Module.Language
                endmodule

                module Adr
Fonts           EQU MemBank_03
FontsMaxSize    EQU 512
Russian         EQU Fonts
Spanish         EQU Fonts
English         EQU Fonts
Table           EQU Fonts + FontsMaxSize
TableSize       EQU 96 * 3

                module Module
Language        EQU Adr.Table + Adr.TableSize                                   ; адрес модуля языка

                endmodule

                endmodule

                endif ; ~_CONST_LANGUAGE_