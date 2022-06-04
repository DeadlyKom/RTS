
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_CORE_
                define _CORE_MODULE_VFX_TEXT_RENDER_CORE_
; -----------------------------------------
; установка VFX текста
; In:
;   HL - адрес таблицы VFX
;   C  - номер VFX из таблицы
;   IY - указывает на структуру FTextVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetTextVFX:     ; установка длительности первого фрейма
                LD A, #01
.CustomFrame    LD (IY + FTextVFX.TickCounter), A

                ; расчёт адреса VFX
                LD B, #00
                LD A, C
                ADD A, A
                ADD A, A
                LD C, A
                ADD HL, BC
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (IY + FTextVFX.Shader), DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                LD (IY + FTextVFX.FrameTiming), DE
                LD A, (DE)
                LD (IY + FTextVFX.FrameCounter), A
                LD (IY + FTextVFX.Flags), #00
                RET

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_CORE_