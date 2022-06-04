
                ifndef _CORE_MODULE_MENU_MAIN_FADEOUT_
                define _CORE_MODULE_MENU_MAIN_FADEOUT_
PreFadeoutText: RES NEXT_FADEIN_BIT, (HL)
SetFadeoutVFX:  LD HL, VFX.Text.MenuVFX.Table                                   ; таблица эффектов
                LD C, VFX.Text.MenuVFX.FADEOUT_VFX                              ; номер эффекта
                JP VFX.Text.SetTextVFX                                          ; установка эффекта

FadeoutNextText: LD HL, Menu.Flag
                BIT LAST_FADEIN_BIT, (HL)
                JR Z, .ToNextFadeout

                SET ALL_FADEIN_BIT, (HL)
                RET

.ToNextFadeout  DEC HL                                                          ; переход к Menu.Current
                DEC (HL)
                LD A, (HL)
                INC HL                                                          ; переход к Menu.Flag
                JR NZ, .NotAllFadeout

                SET LAST_FADEIN_BIT, (HL)
.NotAllFadeout  SET NEXT_FADEIN_BIT, (HL)
                JP SetMenuText.NotUpdate

                endif ; ~ _CORE_MODULE_MENU_MAIN_FADEOUT_