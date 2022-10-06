
                ifndef _CORE_MODULE_MENU_MAIN_FADEOUT_
                define _CORE_MODULE_MENU_MAIN_FADEOUT_
PreFadeoutText: RES NEXT_FADE_BIT, (HL)
SetFadeoutVFX:  LD C, VFX_FADEOUT                                               ; номер эффекта
                JP SetVFX_Text                                                  ; установка эффекта

FadeoutNextText: LD HL, MenuVariables.Flags
                BIT LAST_FADE_BIT, (HL)
                JR Z, .ToNextFadeout

                SET ALL_FADE_BIT, (HL)
                RET

.ToNextFadeout  DEC HL                                                          ; переход к Menu.Current
                DEC (HL)
                LD A, (HL)
                INC HL                                                          ; переход к Menu.Flag
                JR NZ, .NotAllFadeout

                SET LAST_FADE_BIT, (HL)
.NotAllFadeout  SET NEXT_FADE_BIT, (HL)
                JP SetOption.NotUpdate

                display " - Fadeout Text : \t\t\t\t\t", /A, PreFadeoutText, " = busy [ ", /D, $ - PreFadeoutText, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_FADEOUT_