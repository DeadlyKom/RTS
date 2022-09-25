
                ifndef _CONST_GRAPHICS_
                define _CONST_GRAPHICS_

                module Page
                module Graphics
Pack1           EQU PAGE_3                                                      ; страница пакета спрайтов "Пакет 1"
                endmodule
                endmodule

                module Adr
                module Graphics
Pack1:          EQU MemBank_03                                                  ; адрес пакета спрайтов "Пакет 1"

                endmodule
                endmodule

                endif ; ~_CONST_GRAPHICS_
