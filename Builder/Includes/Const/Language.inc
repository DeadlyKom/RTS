
                ifndef _CONST_LANGUAGE_
                define _CONST_LANGUAGE_

                define LocalizationFunc SetPage6

                module Page
                module Module
Language        EQU PAGE_6                                                      ; страница

                endmodule
Russian         EQU Module.Language
Spanish         EQU Module.Language
English         EQU Module.Language
                endmodule

                module Adr
Fonts           EQU MemBank_03
FontsMaxSize    EQU 638
Russian         EQU Fonts
Spanish         EQU Fonts
English         EQU Fonts
Table           EQU Fonts + FontsMaxSize
TableSize       EQU 118 * 3

                module Module
Language        EQU Adr.Table + Adr.TableSize                                   ; адрес модуля языка

                endmodule

                endmodule

                endif ; ~_CONST_LANGUAGE_
