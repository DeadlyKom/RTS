
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_CORE_
                define _CORE_MODULE_VFX_TEXT_RENDER_CORE_
; -----------------------------------------
; установка VFX текста
; In:
;   HL - адрес таблицы VFX
;   C  - номер VFX из таблицы
;   IY - указывает на структуру FTVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
@SetVFX_Text:   ; установка длительности первого фрейма
                LD A, #01
@SetVFX_Custom: LD (IY + FTVFX.TickCounter), A

                ; расчёт адреса VFX
                LD HL, VFX.Table                                                ; таблица эффектов
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
                LD (IY + FTVFX.Shader), DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                LD (IY + FTVFX.FrameTiming), DE
                LD A, (DE)
                LD (IY + FTVFX.FrameCounter), A
                LD (IY + FTVFX.Flags), #00
                RET

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_CORE_