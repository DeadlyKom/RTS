
                ifndef _CORE_MODULE_MENU_MAIN_SELECT_
                define _CORE_MODULE_MENU_MAIN_SELECT_
Begin:          EQU $
Changed:        RET
Selected:       CALL WaitEvent

                CP MENU_OPTIONS
                JP Z, MenuOptions

                CP MENU_NEW_GAME
                JP Z, .CapBridge

                JR $

; переход к меню "капитанский мостик"
.CapBridge      ; инициализация
                CALL CLS                                                        ; очистка экранов
                CALL ResetOptions                                               ; сброс опций

                LD A, Page.CaptainBridge
                CALL SetPage
                LD HL, #C000
                LD DE, Adr.Module.CaptainBridge
                LD BC, Menu.CaptainBridge.Size + Language.Text.Message.Size
                PUSH DE
                JP FastLDIR

                display " - Select : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_SELECT_