
                ifndef _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
                define _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
; -----------------------------------------
; In:
;   IY - указывает на структуру FTextVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
INT_Handler:    SWAP_SCREEN
                CALL VFX.Text.RenderTick

                ; проверка флага VFX_COMPLITED
                BIT VFX.Text.VFX_COMPLITED_BIT, (IY + VFX.Text.FTextVFX.Flags)
                JR Z, .NotComplited
                LD HL, (IY + VFX.Text.FTextVFX.VFX_Complited)
                JP (HL)

.NotComplited   ; проверка флага FRAME_COMPLITED
                BIT VFX.Text.FRAME_COMPLITED_BIT, (IY + VFX.Text.FTextVFX.Flags)
                RET Z

                ; необходимо сбросить флаг FRAME_COMPLITED (возможен повтор)
                RES VFX.Text.FRAME_COMPLITED_BIT, (IY + VFX.Text.FTextVFX.Flags)
                LD HL, (IY + VFX.Text.FTextVFX.FrameComplited)
                JP (HL)

                display " - Main Interrupt : \t\t", /A, INT_Handler, " = busy [ ", /D, $ - INT_Handler, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
