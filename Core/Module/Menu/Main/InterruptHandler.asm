
                ifndef _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
                define _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
INT_Handler:    ; инициализация
                SWAP_SCREEN
                JP VFX.Text.Fadein_Tick

                display " - Main Interrupt : \t\t", /A, INT_Handler, " = busy [ ", /D, $ - INT_Handler, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_INTERRUPT_HANDLER_
