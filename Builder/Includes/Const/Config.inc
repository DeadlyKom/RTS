
                    ifndef _CONST_CONFIG_
                    define _CONST_CONFIG_
LANGUAGE_NONE       EQU 0x00
LANGUAGE_EN         EQU 0x01
LANGUAGE_RU         EQU 0x02
LANGUAGE_SP         EQU 0x03
LANGUAGE_MASK       EQU %00000011
LANGUAGE_MASK_INV   EQU (~LANGUAGE_MASK) & 0xFF
LANGUAGE_DEFAULT    EQU LANGUAGE_EN

INPUT_KEYBOARD      EQU 0x00 << 2
INPUT_KEMPSTON      EQU 0x01 << 2
INPUT_KEMPSTON_8    EQU 0x02 << 2
INPUT_MOUSE         EQU 0x03 << 2
INPUT_MASK          EQU %00001100
INPUT_MASK_INV      EQU (~INPUT_MASK) & 0xFF

SOUND_AY            EQU 0x00
SOUND_GS            EQU 0x01


ANIMATED_TILES      EQU 0x08                                                    ; количество анимированных тайлов

GameConfig:
.KeyUp              EQU GameConfigRef + FConfig.KeyUp                           ; клавиша по умолчанию "Вверх"
.KeyDown            EQU GameConfigRef + FConfig.KeyDown                         ; клавиша по умолчанию "Вниз"
.KeyLeft            EQU GameConfigRef + FConfig.KeyLeft                         ; клавиша по умолчанию "Влево"
.KeyRight           EQU GameConfigRef + FConfig.KeyRight                        ; клавиша по умолчанию "Вправо"
.KeySelect          EQU GameConfigRef + FConfig.KeySelect                       ; клавиша по умолчанию "выбор"
.KeyBack            EQU GameConfigRef + FConfig.KeyBack                         ; клавиша по умолчанию "Отмена"
.KeyAcceleration    EQU GameConfigRef + FConfig.KeyAcceleration                 ; клавиша по умолчанию "ускорить"
.KeyMenu            EQU GameConfigRef + FConfig.KeyMenu                         ; клавиша по умолчанию "меню/пауза"
.CursorSpeedMin     EQU GameConfigRef + FConfig.SpeedCursorMin                  ; минимальная скорость курсора
.CursorSpeedMax     EQU GameConfigRef + FConfig.SpeedCursorMax                  ; максимальная скорость курсора
.SpeedTilemapScroll EQU GameConfigRef + FConfig.SpeedScroll                     ; скорость скрола тайловой карты
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | S0 | I1 | I0 | L1 | L0 |
;   +----+----+----+----+----+----+----+----+
;
;   S0      [4]     - звук
;   I1-I0   [3,2]   - инпут
;                       00 - клавиатура
;                       01 - кемпстон
;                       10 - кемпстон 8 кнопок
;                       11 - кемпстон мышь
;   L1,L0   [1,0]   - язык
;                       00 - по умолчанию (английский)
;                       01 - английский
;                       10 - русский
;                       11 - испанский
; -----------------------------------------
.Options            EQU GameConfigRef + FConfig.Options                         ; флаги опций
.LevelSlot          EQU GameConfigRef + FConfig.LevelSlot                       ; номер слота уровня

                    endif ; ~_CONST_CONFIG_
