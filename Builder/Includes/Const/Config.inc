
                    ifndef _CONST_CONFIG_
                    define _CONST_CONFIG_
LANGUAGE_NONE       EQU 0x00
LANGUAGE_RU         EQU 0x01
LANGUAGE_SP         EQU 0x02
LANGUAGE_EN         EQU 0x03
LANGUAGE_MASK       EQU %00000011

LANGUAGE_DEFAULT    EQU LANGUAGE_EN

ConfigOptions       EQU GameConfigRef + FConfig.Options                         ; флаги опций
CursorSpeedMinRef   EQU GameConfigRef + FConfig.SpeedCursorMin                  ; минимальная скорость курсора
CursorSpeedMaxRef   EQU GameConfigRef + FConfig.SpeedCursorMax                  ; максимальная скорость курсора

                    endif ; ~_CONST_CONFIG_
