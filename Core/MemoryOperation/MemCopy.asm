
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_
; -----------------------------------------
; копирование спрайта в общий буфер
; In:
;   HL - адрес спрайта
;   BС - размер спрайта (B - ширина в знакоместах, C - высота в пикселях)
;   A  - FSprite.Page (7 бит, говорит об использовании маски по смещению)
;   A' - FSprite.Dummy (адрес спрайта + FSprite.Dummy = адрес маски)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Sprite:         ; проверка бита FSSF_MASK_BIT
                ADD A, A
                JP C, SharedMask

                ; модификация адреса спрайта (обрезать спрайт сверху, если необходимо)
.SkipTopRow     EQU $+1
                LD DE, #0000
                ADD HL, DE

                RestoreHL
                EX DE, HL

                ; ---------------------------------------------
                ; B - Sx (ширина спрайта в знакоместах)
                ; C - Sy (высота спрайта в пикселях)
                ; ---------------------------------------------

                ; Sx * Sy
                XOR A
.Mult_SySx      ADD A, C
                DJNZ .Mult_SySx

                ; A = ((-A) << 1) + 144
                NEG
                ADD A, A
                ADD A, 144
                
                LD L, A
                LD (MemCopy.SpriteAdr), A

                LD H, B
                ADD HL, HL
                LD BC, MemCopy._144
                ADD HL, BC
                LD (.MemCopyJump), HL
                LD (MemCopy.MC_ContainerSP), SP

                EX DE, HL

                ; чтение данных спрайта
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (.ContainerSP_), HL
                EX DE, HL

.ContainerSP_   EQU $+1
                LD SP, #0000

.MemCopyJump    EQU $+1
                JP #0000

; ---------------------------------------------
; HL - адрес спрайта
; DE - смещение в спрайте
; B  - Sx (ширина спрайта в знакоместах)
; C  - Sy (высота спрайта в пикселях)
; A' - FSprite.Dummy (адрес спрайта + FSprite.Dummy = адрес маски)
; ---------------------------------------------
SharedMask      PUSH HL                                                         ; сохранение адреса спрайта

                ; ---------------------------------------------
                ; расчёт адреса перехода (копирование видимого размера спрайта)
                ; ---------------------------------------------

                ; Sx * Sy
                XOR A
.Mult_SySx      ADD A, C
                DJNZ .Mult_SySx

                ; A = (-A) + 72
                NEG
                ADD A, 72
                
                ; HL = BC = размер спрайта
                LD L, A
                LD H, B
                LD C, A

                ; HL = размер спрайта * 5
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC
                LD BC, MemCopy._72x2
                ADD HL, BC
                LD (.MemCopyJump), HL

                ; ---------------------------------------------
                ; расчёт адресов копирования блока
                ; ---------------------------------------------

                ; ; востановление адреса спрайта
                ; EX DE, HL                                                       ; востановление адреса спрайта
                ; LD B, H
                ; LD C, L
                ; LD D, #00
                ; EX AF, AF'
                ; LD E, A
                ; ADD HL, DE
                ; LD DE, SharedBuffer
                ; HL - адрес маски
                ; DE - адрес буфера (начало)
                ; BС - адрес спрайта
                ;
                ; LD A, (BC)
                ; LDI
                ; LD (DE), A
                ; INC DE

                POP HL                                                          ; востановление адреса спрайта
.SkipBottomRow  EQU $+1
                LD DE, #0000
                SBC HL, DE                                                      ; приминить смещение в спрайте
                LD B, H
                LD C, L
                LD D, #00
                EX AF, AF'
                LD E, A
                ADD HL, DE
                LD DE, SharedBuffer + (3 * 24 * 2) - 1                          ; максимум 3 знакоместа ширина, 24 строки высота, 2 байта = 144 

                ; HL - адрес спрайта
                ; DE - адрес буфера (конец)
                ; BС - адрес маски

.MemCopyJump    EQU $+1
                JP #0000
MemCopy:
.Count          defl SharedBuffer
._144           dup	72
                LD	(.Count), HL
.Count          = .Count + 2
                POP HL
                edup
                LD	(.Count), HL
.MC_ContainerSP EQU $+1
                LD SP, #0000
.SpriteAdr      EQU $+1
                LD HL, SharedBuffer
                RET
; ---------------------------------------------
; копирование данных из двух массивов, чередуя данные
; In:
;   HL - адрес спрайта
;   DE - адрес буфера (конец)
;   BС - адрес маски
; Out:
;   HL - адрес начала спрайта
; Corrupt:
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

                endif ; ~_MEMORY_COPY_
