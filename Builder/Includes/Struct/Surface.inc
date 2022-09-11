
				ifndef _STRUCT_SURFACE_PROPERTY_
				define _STRUCT_SURFACE_PROPERTY_
; флаги коллизии
;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_NONE        EQU 0x00

;                   +----+----+
;                   |  X |  X |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_UP          EQU 0x01

;                   +----+----+
;                   |    |  X |
;                   +----+----+
;                   |    |  X |
;                   +----+----+
SCF_RIGHT       EQU 0x02

;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |  X |  X |
;                   +----+----+
SCF_DOWN        EQU 0x04

;                   +----+----+
;                   |  X |    |
;                   +----+----+
;                   |  X |    |
;                   +----+----+
SCF_LEFT        EQU 0x08

SCF_MASK        EQU SCF_UP | SCF_RIGHT | SCF_DOWN | SCF_LEFT
SCF_BLOCK       EQU SCF_UP | SCF_RIGHT | SCF_DOWN | SCF_LEFT
SCF_NOT_ANIM    EQU 1 << SP_ANIM_BIT

SCF_ANIM_None   EQU SCF_ANIM_0x07
SCF_ANIM_0x02   EQU 0x00
SCF_ANIM_0x04   EQU 0x01
SCF_ANIM_0x05   EQU 0x02
SCF_ANIM_0x07   EQU 0x03

; коэффициент замедления
SDR_0_PERCENT   EQU 0x00 << 4
SDR_25_PERCENT  EQU 0x01 << 4
SDR_50_PERCENT  EQU 0x02 << 4
SDR_75_PERCENT  EQU 0x03 << 4

; флаги
SP_ANIM_BIT     EQU 0x07                                                        ; бит тайла с анимацией
SP_DESTRUCT_BIT EQU 0x06                                                        ; бит разрушаемости тайла

SP_ANIM         EQU 1 << SP_ANIM_BIT
SP_DESTRUCT     EQU 1 << SP_DESTRUCT_BIT

; структуры FSurface (Base/Extra) одна структура,
; её особенногсть в расположении в памяти
; блок данных свойств FSurfaceBase  расположен 0xxxxxxx (младний байт)
; блок данных свойств FSurfaceExtra расположен 1xxxxxxx (младший байт)
; т.е. сменой старшего бита в младшем регистре, регистроваой паре производится смена

                struct FSurfaceBase                                             ; блок данных свойств FSurfaceBase  расположен 0xxxxxxx (младний байт)
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | !A | D  | D1 | D0 | C3 | C2 | C1 | C0 |
;   +----+----+----+----+----+----+----+----+
;
;   A       [7]     - 0 - анимируемый тайл, 1 - тайл не анимируется (инвертный)
;   D       [6]     - разрушаемый
;   D1, D0  [0..1]  - коэффициент замедления
;   C3 - C0 [0..3]  - флаги коллизии
;
Property        DB #00

                ends

                struct FSurfaceExtra                                            ; блок данных свойств FSurfaceExtra расположен 1xxxxxxx (младший байт)
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | .. | .. | A1 | A0 |
;   +----+----+----+----+----+----+----+----+
;
;   A1 - A0 [0..3]  - количество анимаций
;           00      - 2 анимации
;           01      - 4 анимации
;           10      - 5 анимаций
;           11      - 7 анимаций
;
Property        DB #00

                ends
; флаги
SPE_ANIM_MASK   EQU %00000011                                                   ; маска количества кадров в анимации (не фактическое)

; ключ-значение количества анимации (0-7)
SPE_ANIM_KEY_0  EQU 0x00                                                        ; 0 ключ
SPE_ANIM_VAL_0  EQU 0x02                                                        ; 0 значение    (2 анимации)
SPE_ANIM_KEY_1  EQU 0x01                                                        ; 1 ключ
SPE_ANIM_VAL_1  EQU 0x04                                                        ; 1 значение    (4 анимации)
SPE_ANIM_KEY_2  EQU 0x02                                                        ; 2 ключ
SPE_ANIM_VAL_2  EQU 0x05                                                        ; 2 значение    (5 анимаций)
SPE_ANIM_KEY_3  EQU 0x03                                                        ; 3 ключ
SPE_ANIM_VAL_3  EQU 0x07                                                        ; 3 значение    (7 анимаций)

                endif ; ~_STRUCT_SURFACE_PROPERTY_
