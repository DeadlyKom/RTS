
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_DRAW_FRAME_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_DRAW_FRAME_
; -----------------------------------------
; отображение кадра
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawFrame:      ; расчёт адреса фрейма
                LD A, (Frame)
                LD C, A
                ADD A, A
                ADD A, C
                LD C, A
                LD B, #00
                LD HL, FrameTable
                ADD HL, BC

                ; отобразим теневой экран (скрыть декомпрессию в основной экран)
                HALT
                SHOW_SHADOW_SCREEN

                ; инициалиация декомпрессии фрейма
                LD A, (HL)
                CALL SetPage
                INC HL
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

                ; декомпрессия фрейма
                LD DE, MemBank_01_SCR
                CALL Decompressor.Forward

                ; копирование фрейма в теневой экран
                HALT
                SHOW_BASE_SCREEN
                CALL SetPage7
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03
                LD BC, ScreenSize
                JP FastLDIR

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_DRAW_FRAME_
