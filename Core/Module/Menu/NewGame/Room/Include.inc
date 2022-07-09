
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INCLUDE_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INCLUDE_

                module Room
DELAY_FRAME     EQU 0x05                                                        ; продолжительность одного кадра

@Room.ROTATE    EQU 0x00                                                        ; не обновлять анимации комнат
@Room.LEFT      EQU 0x01                                                        ; отбражается левая комната
@Room.CENTER    EQU 0x02                                                      ; отбражается центральная комната
@Room.RIGHT     EQU 0x03                                                       ; отбражается правая комната

COUNTDOWN_BIT   EQU 0x07                                                        ; начало отсчёта времени
COMPLETED_BIT   EQU 0x06                                                        ; отсчёт времени завершён
ROTATE_BIT      EQU 0x05                                                        ; вращение 0 - влево, 1 - вправо
REQ_ROTATE_BIT  EQU 0x04                                                        ; запрос на вращение

                include "Initialize.asm"
                include "FrameTable.inc"
                include "TickFrame.asm"
                include "DrawFrame.asm"
                include "Rotate.asm"
Flags:          DB #00                                                          ; флаги работы с фреймами
Frame:          DB #00                                                          ; текущий фрейм
FrameCounter:   DB DELAY_FRAME                                                  ; счётчик продолжительности одного фрейма
@Room.Number:   DB Room.LEFT                                                    ; номер активной комнаты

                endmodule

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INCLUDE_
