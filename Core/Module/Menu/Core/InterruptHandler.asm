
                ifndef _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
                define _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
; -----------------------------------------
; In:
;   IY - указывает на структуру FTVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
@INT_Handler:   SWAP_SCREEN
                CALL RenderTickVFX

                ; проверка флага VFX_COMPLITED
                BIT VFX_COMPLITED_BIT, (IY + FTVFX.Flags)
                JR Z, .NotComplited
                LD HL, (IY +FTVFX.VFX_Complited)
                JP (HL)

.NotComplited   ; проверка флага FRAME_COMPLITED
                BIT VFX_FRAME_COMPLITED_BIT, (IY + FTVFX.Flags)
                RET Z

                ; необходимо сбросить флаг FRAME_COMPLITED (возможен повтор)
                RES VFX_FRAME_COMPLITED_BIT, (IY + FTVFX.Flags)
                LD HL, (IY + FTVFX.FrameComplited)
                JP (HL)

                display " - Main Interrupt : \t\t", /A, INT_Handler, " = busy [ ", /D, $ - INT_Handler, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
