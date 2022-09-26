
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_DRAW_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_DRAW_
; -----------------------------------------
; отображение кадра анимации
; In:
;   IX - адрес FStaticAnimation
; Out:
; Corrupt:
; Note:
; -----------------------------------------
@Animation.Core.Draw:
                ; расчёт адреса кадра
                LD HL, (IX + FStaticAnimation.Table)
                LD A, (IX + FStaticAnimation.FrameNumber)
                LD E, A
                ADD A, A
                ADD A, E
                LD E, A
                LD D, #00
                ADD HL, DE

                ; включение страницы кадра
                LD A, (HL)
                CALL SetPage
                INC HL
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

                ; копирование спрайта в буфер
                LD B, D
                LD C, (IX + FStaticAnimation.SpriteSize)
                LD DE, SharedBuffer
                CALL Memcpy.FastLDIR

                SET_SCREEN_SHADOW

                ; отображение кадра
                LD HL, SharedBuffer
                LD DE, (IX + FStaticAnimation.Location)
                LD BC, (IX + FStaticAnimation.Size)
                JP DrawSpriteTwo

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_DRAW_
