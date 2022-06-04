
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_TICK_
                define _CORE_MODULE_VFX_TEXT_RENDER_TICK_
; -----------------------------------------
; In:
;   IY - указывает на структуру FTextVFX
; Out:
;   выставляется флаги:
;       - FRAME_COMPLITED, переход к следующему фрейму
; Corrupt:
; Note:
; -----------------------------------------
RenderTick:     ; уменьшение счётчика прерываний
                DEC (IY + FTextVFX.TickCounter)
                RET NZ

                ; установка флагов (VFX_COMPLITED устанавливается преждевременно)
                LD (IY + FTextVFX.Flags), VFX_COMPLITED

                ; уменьшить счётчик фреймов
                DEC (IY + FTextVFX.FrameCounter)
                RET Z

                ; установка флага FRAME_COMPLITED
                LD (IY + FTextVFX.Flags), FRAME_COMPLITED | PLAYING_VFX

                ; установка нового счётчика прерываний
                LD HL, (IY + FTextVFX.FrameTiming)
                LD D, #00
                LD E, (IY + FTextVFX.FrameCounter)
                ADD HL, DE
                LD A, (HL)
                LD (IY + FTextVFX.TickCounter), A

                RET

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_TICK_