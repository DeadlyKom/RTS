
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
                define _MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
; -----------------------------------------
; обработчик клавиш игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InputHandler:   JR Z, .NotProcessing                                            ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши

                ; CP KEY_ID_UP                                                    ; клавиша "вверх"
                ; JP Z, $
                ; CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                ; JP Z, $
                ; CP KEY_ID_LEFT                                                  ; клавиша "влево"
                ; JP Z, $
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, $
                ; CP KEY_ID_SELECT                                                ; клавиша "выбор"
                ; JP Z, $
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                ; CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                ; JP Z, $

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
