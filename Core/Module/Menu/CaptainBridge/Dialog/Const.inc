
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CONST_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CONST_

ROW_LENGTH_CHR  EQU 30
ROW_LENGTH      EQU ROW_LENGTH_CHR * 8 - 6                                      ; длина ряда
NUMBER_ROWS     EQU 4                                                           ; количество рядов
ROW_HEGHT       EQU #09                                                         ; высота строки
START_CUR_POS   EQU #0A0A + 3                                                   ; начальное положение курсора

                define ArrowDownX 30 * 8                                        ; в пикселях
                define ArrowDownY 41                                            ; в пикселях
START_ARROW_DOWN EQU /*Y*/(ArrowDownY << 8)| /*X*/ArrowDownX                    ; координаты стрелки перехода к следующим сообщениям

                define ArrowRightX 13                                           ; в пикселях
                define ArrowRightY 11                                           ; в пикселях
START_ARROW_RIGHT EQU /*Y*/(ArrowRightY << 8)| /*X*/ArrowRightX                 ; координаты стрелки выбора

                define ScrollX 1                                                ; в знакоместах
                define ScrollY 11                                               ; в пикселях
START_SCROLL    EQU MemBank_01_SCR + /*Y*/ (((ScrollY >> 3) & 0x18) << 8) + ((ScrollY & 0x07) << 8) + ((ScrollY & 0x38) << 2) + /*X*/ScrollX

SCROLLABLE_LINES EQU 18                                                         ; количество скролируемых линий

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CONST_