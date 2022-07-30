
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
                JR Z, GameLaunch
                CP RIGHT
                RET Z

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

; -----------------------------------------
; запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GameLaunch:     POP AF                                                          ; удаление адреса возврата
                OffUserHendler                                                  ; отключение обработчика прерываний
                JP Menu.CaptainBridge.CapBridge.Game.LoadAndLaunch

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_INTERACT_
