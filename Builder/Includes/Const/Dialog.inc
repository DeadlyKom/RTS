
                ifndef _DIALOG_CONST_
                define _DIALOG_CONST_
DURATION_PRINT  EQU 3                                                           ; продолжительность отображения символа (1/50)
DURATION_ARROW  EQU 10                                                          ; продолжительность смены кадра прыгающей стрелки (1/50)
DURATION_SCROLL EQU 1                                                           ; продолжительность смены кадра скролла (1/50)
DURATION_FADE   EQU 1

; состояния работы с диалогом
OPEN_DLG        EQU 0x00                                                        ; анимация появления диалога
PRINTED_MSG     EQU 0x01                                                        ; отображение сообщений
WAITING_DOWN    EQU 0x02                                                        ; ожидания нажатия клавиши (отображение прыгающей стрелки вниз)
WAITING_SELECT  EQU 0x03                                                        ; ожидания нажатия клавиши, выбор (отображение прыгающей стрелки вправо)
SCROLL_MSG      EQU 0x04                                                        ; скроллл сообщений вверх
CLOSE_DLG       EQU 0x05                                                        ; анимация закрытия диалога

                endif ; ~ _DIALOG_CONST_
