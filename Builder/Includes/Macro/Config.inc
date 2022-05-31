
                ifndef _MACRO_CONFIG_
                define _MACRO_CONFIG_

; работа со структурой FConfig
SET_LANGUAGE    macro Language?
                LD A, (ConfigOptions)
                AND LANGUAGE_MASK
                OR (Language? & 0x03)
                LD (ConfigOptions), A
                endm

                endif ; ~_MACRO_CONFIG_
