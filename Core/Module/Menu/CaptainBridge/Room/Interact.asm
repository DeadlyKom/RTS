
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_INTERACT_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_INTERACT_
; -----------------------------------------
; взаимодействие в комнате
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Interact:       ; определение направление
                LD A, (Number)
                CP LEFT
                RET Z
                CP CENTER
                JR Z, $
                CP RIGHT
                RET Z

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_INTERACT_
