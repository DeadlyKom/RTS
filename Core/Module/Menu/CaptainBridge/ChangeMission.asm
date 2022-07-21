
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_
@CapBridge:     ;
                SetUserHendler .TickFrame

                ; инициализация комнаты
                CALL Room.Initialize

                ; инициализация ввода
                CALL DisableInput

; -----------------------------------------

                ; инициализация эффекта печатья текста
                LD HL, Dialog.Dialog_0
                LD DE, Adr.Module.MsgText
                CALL Dialog.Initialize

                ; отображение выноски
                LD HL, #4021
                LD BC, #031C
                CALL Dialog.DrawCallout

                ; включение диалогов
                CALL SetDialog

.Loop           HALT

                LD HL, Room.Flags
                BIT Room.REQ_ROTATE_BIT, (HL)
                CALL NZ, Room.NextFrame

                ; обработка ввода
                LD A, (Flags)
                BIT ENABLE_INPUT_BIT, A
                JR Z, .Loop                                                     ; опрос ввода запрещён

                LD DE, InputCapBridge
                CALL Input.JumpDefaulKeys
                JR .Loop

.TickFrame      ; обработка вывода сообщений
                LD A, (Flags)
                BIT DLG_ENABLE_BIT, A
                CALL NZ, Dialog.Tick

                CALL Room.TickFrame
                JP Animation.Core.TickFrame

EnableInput:    LD HL, Flags
                SET ENABLE_INPUT_BIT, (HL)
                RET

DisableInput:   LD HL, Flags
                RES ENABLE_INPUT_BIT, (HL)
                RET
GetDialog:      LD HL, Flags
                BIT DLG_ENABLE_BIT, (HL)
                RET
SetDialog:      LD HL, Flags
                SET DLG_ENABLE_BIT, (HL)
                RET
ResetDialog:    LD HL, Flags
                RES DLG_ENABLE_BIT, (HL)
                RET

                display " - Captain Bridge : \t\t", /A, CapBridge, " = busy [ ", /D, $ - CapBridge, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_