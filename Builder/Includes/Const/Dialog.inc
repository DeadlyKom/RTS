
                ifndef _DIALOG_CONST_
                define _DIALOG_CONST_
DURATION_PRINT  EQU 3                                                           ; продолжительность отображения символа (1/50)
DURATION_ARROW  EQU 8                                                           ; продолжительность смены кадра прыгающей стрелки (1/50)
DURATION_SCROLL EQU 1                                                           ; продолжительность смены кадра скрола (1/50)


PRINTED_MSG     EQU 0x01                                                        ; отображение сообщений
WAITING_INPUT   EQU 0x02                                                        ; ожидания нажатия клавиши (отображение прыгающей стрелки)
SCROLL_MSG      EQU 0x03                                                        ; скролл сообщений вверх

                endif ; ~ _DIALOG_CONST_
