
                ifndef _CORE_MODULE_MENU_MAIN_FADEIN_
                define _CORE_MODULE_MENU_MAIN_FADEIN_
PreFadeinText:  RES NEXT_FADEIN_BIT, (HL)
SetFadeinVFX:   LD HL, VFX.Text.MenuVFX.Table                                   ; таблица эффектов
                LD C, VFX.Text.MenuVFX.FADEIN_VFX                               ; номер эффекта
                JP VFX.Text.SetTextVFX                                          ; установка эффекта

FadeinNextText: LD HL, Menu.Flag
                BIT LAST_FADEIN_BIT, (HL)
                JR Z, .ToNextFadein

                SET ALL_FADEIN_BIT, (HL)
                RET

.ToNextFadein   DEC HL                                                          ; переход к Menu.Current
                DEC (HL)
                LD A, (HL)
                INC HL                                                          ; переход к Menu.Flag
                JR NZ, .NotAllFadein

                SET LAST_FADEIN_BIT, (HL)
.NotAllFadein   SET NEXT_FADEIN_BIT, (HL)
                JP SetMenuText.NotUpdate

                endif ; ~ _CORE_MODULE_MENU_MAIN_FADEIN_