
                    ifndef _CONST_CONFIG_
                    define _CONST_CONFIG_
LANGUAGE_NONE       EQU 0x00
LANGUAGE_EN         EQU 0x01
LANGUAGE_RU         EQU 0x02
LANGUAGE_SP         EQU 0x03
LANGUAGE_MASK       EQU %00000011
LANGUAGE_MASK_INV   EQU (~LANGUAGE_MASK) & 0xFF
LANGUAGE_DEFAULT    EQU LANGUAGE_EN

ConfigOptions       EQU GameConfigRef + FConfig.Options                         ; флаги опций
CursorSpeedMinRef   EQU GameConfigRef + FConfig.SpeedCursorMin                  ; минимальная скорость курсора
CursorSpeedMaxRef   EQU GameConfigRef + FConfig.SpeedCursorMax                  ; максимальная скорость курсора
DefaultKeyUpRef     EQU GameConfigRef + FConfig.KeyUp                           ; клавиша по умолчанию "Вверх"
DefaultKeyDownRef   EQU GameConfigRef + FConfig.KeyDown                         ; клавиша по умолчанию "Вниз"
DefaultKeyLeftRef   EQU GameConfigRef + FConfig.KeyLeft                         ; клавиша по умолчанию "Влево"
DefaultKeyRightRef  EQU GameConfigRef + FConfig.KeyRight                        ; клавиша по умолчанию "Вправо"
DefaultKeySelectRef EQU GameConfigRef + FConfig.KeySelect                       ; клавиша по умолчанию "Выбор"
DefaultKeyDeselectRef EQU GameConfigRef + FConfig.KeyDeselect                   ; клавиша по умолчанию "Отмена"

                    endif ; ~_CONST_CONFIG_
