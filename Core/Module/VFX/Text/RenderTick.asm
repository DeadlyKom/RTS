
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_TICK_
                define _CORE_MODULE_VFX_TEXT_RENDER_TICK_
; -----------------------------------------
; In:
;   IY - указывает на структуру FTextVFX
; Out:
;   выставляется флаги:
;       - VFX_FRAME_COMPLITED, переход к следующему фрейму
;       - VFX_COMPLITED, эффект проигрался полностью
;       - VFX_PLAYING, эффект проигрывается
; Corrupt:
; Note:
; -----------------------------------------
@RenderTickVFX: ; уменьшение счётчика прерываний
                DEC (IY + FTVFX.TickCounter)
                RET NZ

                ; установка флагов (VFX_COMPLITED устанавливается преждевременно)
                LD (IY + FTVFX.Flags), VFX_COMPLITED

                ; уменьшить счётчик фреймов
                DEC (IY + FTVFX.FrameCounter)
                RET Z

                ; установка флага VFX_FRAME_COMPLITED и VFX_PLAYING
                LD (IY + FTVFX.Flags), VFX_FRAME_COMPLITED | VFX_PLAYING

                ; установка нового счётчика прерываний
                LD HL, (IY + FTVFX.FrameTiming)
                LD D, #00
                LD E, (IY + FTVFX.FrameCounter)
                ADD HL, DE
                LD A, (HL)
                LD (IY + FTVFX.TickCounter), A

                RET

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_TICK_