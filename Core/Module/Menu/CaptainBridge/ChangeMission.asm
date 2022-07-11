
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_
@CapBridge:     ;
                SetUserHendler .TickFrame

                ; инициализация комнаты
                CALL Room.Initialize

; -----------------------------------------

                ; инициализация таблицы текста
                LD HL, Adr.Module.MsgText
                LD (LocalizationRef), HL

                LD HL, #4021
                LD BC, #031C
                CALL Message.DrawCallout

                ; ; In:
                ; ;   A  - ID сообщения
                ; ;   A' - если флаг переполнения Carry установлен, первичное отображение
                ; ;   иначе в A' хранится смещение
                ; ; Out:
                ; ;   E - длина строки в пикселах
                ; ; Corrupt:
                ; ; Note:
                ; SCF
                ; EX AF, AF'
                ; XOR A
                ; CALL Functions.TextToBuffer

                LD DE, #0A0A
                CALL Message.Text.DrawText

; -----------------------------------------


.Loop           HALT

                LD HL, Room.Flags
                BIT Room.REQ_ROTATE_BIT, (HL)
                CALL NZ, Room.NextFrame

                ; обработка ввода
                LD DE, InputCapBridge
                CALL Input.JumpDefaulKeys
                JR .Loop

.TickFrame      ; обработка вывода сообщений
                LD A, (Flags)
                BIT MSG_ENABLE_BIT, A
                CALL NZ, Message.Text.RenderTick

                CALL Room.TickFrame
                JP Animation.Core.TickFrame

                display " - Captain Bridge : \t\t", /A, CapBridge, " = busy [ ", /D, $ - CapBridge, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_
