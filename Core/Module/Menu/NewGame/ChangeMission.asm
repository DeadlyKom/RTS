
                ifndef _CORE_MODULE_MENU_START_GAME_
                define _CORE_MODULE_MENU_START_GAME_

@NewGame:       ; подготовка
                CALL CLS                                                        ; очистка экранов
                CALL ResetOptions                                               ; сброс опций

                CALL SetPage0
                SHOW_SHADOW_SCREEN
.L1
                HALT
                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_1
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_2
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_3
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_4
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_5
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_6
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_7
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_8
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_9
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_10
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_9
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_8
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_7
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_6
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_5
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_4
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_3
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_2
                LD DE, Screen
                CALL Decompressor.Forward

                CALL .Copy

                ; отрисовка
                LD HL, Adr.Module.MenuGraphics.Interact_1
                LD DE, Screen
                CALL Decompressor.Forward


                
                JP .L1

.Copy           HALT
                HALT
                HALT
                HALT
                SHOW_BASE_SCREEN
                CALL SetPage7
                LD HL, #4000
                LD DE, #C000
                LD BC, #1B00
                LDIR
                SHOW_SHADOW_SCREEN
                JP SetPage0


                endif ; ~ _CORE_MODULE_MENU_START_GAME_
