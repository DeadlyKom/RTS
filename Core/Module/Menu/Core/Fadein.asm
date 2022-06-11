
                ifndef _CORE_MODULE_MENU_MAIN_FADEIN_
                define _CORE_MODULE_MENU_MAIN_FADEIN_
@PreFadeinText: RES NEXT_FADE_BIT, (HL)
@SetFadeinVFX:  LD C, VFX_FADEIN                                                ; номер эффекта
                JP SetVFX_Text                                                  ; установка эффекта

@FadeinNextText: LD HL, MenuVariables.Flags
                BIT LAST_FADE_BIT, (HL)
                JR Z, .ToNextFadein

                SET ALL_FADE_BIT, (HL)
                RET

.ToNextFadein   DEC HL                                                          ; переход к Menu.Current
                DEC (HL)
                LD A, (HL)
                INC HL                                                          ; переход к Menu.Flag
                JR NZ, .NotAllFadein

                SET LAST_FADE_BIT, (HL)
.NotAllFadein   SET NEXT_FADE_BIT, (HL)
                JP SetOption.NotUpdate

                display " - Fadein Text : \t\t", /A, PreFadeinText, " = busy [ ", /D, $ - PreFadeinText, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_FADEIN_