                ifndef _MACRO_FLAGS_
                define _MACRO_FLAGS_
; -----------------------------------------
; проверка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
CHECK_FLAG      macro FlagBit?
                BIT FlagBit?, (HL)
                endm
; -----------------------------------------
; установка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
SET_FLAG        macro FlagBit?
                SET FlagBit?, (HL)
                endm
; -----------------------------------------
; сброс флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
RES_FLAG        macro FlagBit?
                RES FlagBit?, (HL)
                endm
; -----------------------------------------
; изъятие флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
POP_FLAG        macro FlagBit?
                CHECK_FLAG FlagBit?
                JR Z, .Next
                RES_FLAG FlagBit?
.Next           ;
                endm

; -----------------------------------------
; установка HL на Render флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
RENDER_FLAGS    macro
                LD HL, GameFlags.RenderRef
                endm

; -----------------------------------------
; проверка Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_RENDER_FLAG macro FlagBit?
                RENDER_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; установка Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_RENDER_FLAG macro FlagBit?
                RENDER_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_RENDER_FLAG macro FlagBit?
                RENDER_FLAGS
                RES_FLAG FlagBit?
                endm
; -----------------------------------------
; изъятие Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
POP_RENDER_FLAG macro FlagBit?
                RENDER_FLAGS
                POP_FLAG FlagBit?
                endm
; -----------------------------------------
; определение стартовой локации игрока
; In:
; Out:
;   DE - позиция старта игрока (D - y, E - x)
; Corrupt:
;   DE, F
; -----------------------------------------
START_PLAYER    macro
                PUSH HL
                LD HL, GameFlags.Gameplay
                BIT GAMEPLAY_BIT, (HL)                                          ; флаг базового старта миссии
                                                                                ; 0 - нормальный старт со слота StartSlotA
                                                                                ; 1 - режим защиты старт со слота StartSlotB
                LD HL, GameVar.StartSlotA
                JR Z, .Base
                LD HL, GameVar.StartSlotB
.Base           LD E, (HL)
                INC HL
                LD D, (HL)
                POP HL
                endm

                endif ; ~_MACRO_FLAGS_
