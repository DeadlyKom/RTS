
                ifndef _CONFIG_ZX_SPECTRUM_
                define _CONFIG_ZX_SPECTRUM_
PORT_7FFD       EQU #7FFD
SCREEN_BIT      EQU 0x03
ROM_BIT         EQU 0x04
LOCK_48K_BIT    EQU 0x05
SCREEN_MASK     EQU 1 << SCREEN_BIT
SCRIIN_MASK_INV EQU (~SCREEN_MASK) & 0xFF
ROM_MASK        EQU 1 << ROM_BIT
PAGE_MASK       EQU %00000111
PAGE_MASK_INV   EQU (~PAGE_MASK) & 0xFF

PAGE_0          EQU 0x00
PAGE_1          EQU 0x01
PAGE_2          EQU 0x02
PAGE_3          EQU 0x03
PAGE_4          EQU 0x04
PAGE_5          EQU 0x05
PAGE_6          EQU 0x06
PAGE_7          EQU 0x07

                module BASIC
ERR_NR          EQU #5C3A                                                       ; рег IY

                endmodule

                endif ; ~_CONFIG_ZX_SPECTRUM_
