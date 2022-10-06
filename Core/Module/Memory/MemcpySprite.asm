
                    ifndef _MEMORY_COPY_SPRITE_
                    define _MEMORY_COPY_SPRITE_

                    module Memcpy
; -----------------------------------------
; копирование спрайта в общий буфер
; In:
;   DE - адрес спрайта
;   BС - размер спрайта (B - ширина, C - высота) в пикселях
;   ВС' - количество пропускаемых байт, для спрайтов с общей маской
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
Sprite:         ; -----------------------------------------
                ; расчёт количества копируемых данных
                ; -----------------------------------------

                ; расчёт адреса в таблицы умножения
                LD A, B
                SUB #08                                                         ; начинается с 1
                ADD A, A
                ADD A, A
                DEC C                                                           ; начинается с 1
                XOR C
                AND %01100000
                XOR C

                ; результат:
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 0  | W1 | W0 | R4 | R3 | R2 | R1 | R0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   W1,W0   [6,5]   - ширина спрайта в знакоместах
                ;   R4-R0   [4..0]  - количество строк
                
                LD L, A
                LD H, HIGH Table.MultiplySprite
                LD A, (HL)

                ; проверка флага общей маски
                LD HL, GameFlags.SpriteFlagRef
                BIT CSIF_MASK_BIT, (HL)
                JP NZ, SharedMask                                               ; переход, если установлен флаг общей маски
                
                ; корректировка размера спрайта, учитывая флаги:
                ; - отсутствие/наличие маски у спрайта
                BIT CSIF_OR_XOR_BIT, (HL)
                JR Z, $+3
                ADD A, A
                NEG
                LD (.SpriteAdr), A

                ; ---------------------------------------------
                ; расчёт адреса перехода
                ; ---------------------------------------------
                LD H, #00
                LD L, A
                ADD HL, HL
                LD BC, .Memcpy
                ADD HL, BC
                LD (.MemcpyJump), HL

                ; подготовка для работы с включенным прерыванием
                RestoreHL
                LD (.ContainerSP), SP

                ; чтение данных спрайта
                EX DE, HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL

                ; подготовка использования стека
                LD (.Source), HL
                EX DE, HL
.Source         EQU $+1
                LD SP, #0000

                ; копирование данных
.MemcpyJump     EQU $+1
                JP #0000
; ---------------------------------------------
; копирование данных из массива
; In:
;   SP - адрес спрайта
;   HL - первая пара данных спрайта
; Out:
;   HL - адрес начала спрайта
; Corrupt:
;   HL
; Note:
; ---------------------------------------------
.Memcpy
.Count          defl SharedBuffer
                dup 127
                LD (.Count), HL
.Count          = .Count + 2
                POP HL
                edup
                LD (.Count), HL
.ContainerSP    EQU $+1
                LD SP, #0000
.SpriteAdr      EQU $+1
                LD HL, SharedBuffer
                RET
; ---------------------------------------------
; копирование спрайта в общий буфер
; In:
;   HL  - указывает на GameFlags.SpriteFlagRef
;   DE  - адрес спрайта
;   A   - количества копируемых данных
;   ВС' - количество пропускаемых байт, для спрайтов с общей маской
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; Note:
;   ограничения использования:
;       - максимальный спрайт 24х24 пикселей
;       - количество спрайтов не более 3х
;   если спрайты меньше, то количество мб иным
;
;   форма хранения данных:
;       - общая маска   (OR)
;       - спрайт 1      (XOR)
;       - спрайт 2      (XOR)
;       - спрайт 3      (XOR)
; ---------------------------------------------
SharedMask:     ; получение значения смещения FSprite.Offset
                DEC HL
                LD A, (HL)                                                      ; A = GameFlags.SpriteOffsetRef
                EX AF, AF'

                ; ---------------------------------------------
                ; расчёт адреса перехода
                ; ---------------------------------------------

                ; A = (-A) + 72
                NEG
                ADD A, 72
                
                ; HL = BC = размер спрайта
                LD L, A
                LD H, #00
                LD C, A

                ; HL = размер спрайта * 5
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC
                LD BC, ._72x2
                ADD HL, BC
                LD (.MemCopyJump), HL

                ; ---------------------------------------------
                ; расчёт адресов копирования блока
                ; ---------------------------------------------
                EXX
                PUSH BC
                EXX
                POP HL
                EX DE, HL
                SBC HL, DE                                                      ; приминить смещение в спрайте
                LD B, H
                LD C, L
                EX AF, AF'
                LD E, A
                ADD HL, DE
                LD DE, SharedBuffer + (3 * 24 * 2) - 1                          ; максимум 3 знакоместа ширина, 24 строки высота, 2 байта = 144 

                ;   HL - адрес спрайта  (XOR)
                ;   DE - адрес буфера   (конец)
                ;   BС - адрес маски    (OR)

.MemCopyJump    EQU $+1
                JP #0000
; ---------------------------------------------
; копирование данных из двух массивов, чередуя данные
; In:
;   HL - адрес спрайта  (XOR)
;   DE - адрес буфера   (конец)
;   BС - адрес маски    (OR)
; Out:
;   HL - адрес начала спрайта
; Corrupt:
;   HL, DE, BC, AF
; Note:
; ---------------------------------------------
._72x2          rept 71
                LD A, (BC)  ; чтение маски OR
                LDD         ; копирование в буфер спрайта XOR
                LD (DE), A  ; запись в буфер маску OR
                DEC DE
                endr

                ; 72 копирование
                LD A, (BC)  ; чтение маски OR
                LDD         ; копирование в буфер спрайта XOR
                LD (DE), A  ; запись в буфер маску OR
                EX DE, HL   ; HL хранит адрес спрайта

                RET

                display " - Memcpy Sprite : \t\t\t\t\t", /A, Sprite, " = busy [ ", /D, $ - Sprite, " bytes  ]"

                endmodule

                endif ; ~_MEMORY_COPY_SPRITE_
