
                ifndef _MACRO_CONFIG_
                define _MACRO_CONFIG_

; работа со структурой FConfig
SET_LANGUAGE    macro Language?
                LD A, (ConfigOptions)
                LD C, Language?
                XOR C
                AND LANGUAGE_MASK_INV
                XOR C
                LD (ConfigOptions), A
                endm
SET_LANGUAGE_A  macro
                LD A, (ConfigOptions)
                XOR C
                AND LANGUAGE_MASK_INV
                XOR C
                LD (ConfigOptions), A
                endm

                endif ; ~_MACRO_CONFIG_
