
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_AUDIO_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_AUDIO_
AudiolHelp:    LD A, (TextAudioHelp.Current)
                LD HL, TextAudioHelp
                JP Suboption

ReqChangeAudio: LD DE, TextAudioHelp.Current
                LD B, TextAudioHelp.Num
                JP ReqChange

TextAudioHelp   ; текст в "General Sound"
                DB 0x16 * 8
                DB Language.Text.Menu.Audio_GS
                ; текст в "AY"
                DB 0x16 * 8
                DB Language.Text.Menu.Audio_AY
.Num            EQU (($-TextAudioHelp) / 2)-1
.Current        DB #01

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_AUDIO_
