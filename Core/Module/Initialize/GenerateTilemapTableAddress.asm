
                ifndef _CORE_DISPLAY_TILEMAP_GENERATE_TABLE_ADDRESS_
                define _CORE_DISPLAY_TILEMAP_GENERATE_TABLE_ADDRESS_
; -----------------------------------------
; генерация таблицы адресов по позиции тайла (не использовать умножение)
; In:
;   HL - адрес начала (смещение 0,0) тайловой карты
;   DE - адрес таблицы тайловой карты 
;   BC - размера карты (B - y, C - x)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Generate:       ;
                PUSH HL
                PUSH DE
                PUSH BC
                PUSH AF

                LD A, B
                LD B, #00

.Loop           EX DE, HL
                LD (HL), E
                INC H
                LD (HL), D
                DEC H
                INC L
                EX DE, HL
                
                ADD HL, BC
                
                DEC A
                JR NZ, .Loop

                POP AF
                POP BC
                POP DE
                POP HL

                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_GENERATE_TABLE_ADDRESS_
