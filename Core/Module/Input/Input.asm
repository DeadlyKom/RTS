    
                ifndef _MODULE_INPUT_
                define _MODULE_INPUT_
; -----------------------------------------
; проверка нажатия/отпускания виртуальной клавиши
; In :
;   A  - виртуальная клавиша
;   HL - адрес массива состояний виртуальных клавиш
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отпущена то вызовется обрабочик
;   флаг Z сброшен, если виртуальная клавиша отжата
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKey:     CALL Input.CheckKeyState
                    LD A, (HL)
                    JR NZ, .IsReleased
                    OR A
                    JR NZ, .NotProcessed
                    INC (HL)
                    EX DE, HL
                    JP (HL)                             ; pressed
.IsReleased         OR A
                    JR Z, .NotProcessed
                    DEC (HL)
                    EX DE, HL
                    JP (HL)                             ; released
.NotProcessed       SCF
                    RET
; -----------------------------------------
; обработчик нажатия клавиш
; In :
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отпущена то вызовется обрабочик
;   флаг Z сброшен, если виртуальная клавиша отжата
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpKeys:       LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
; -----------------------------------------
; вызов обработчика клавишь при нажатии/отпускания виртуальной клавиши (JumpHandlerKeys)
; In :
;   HL  - адрес массива состояний виртуальных клавиш
;   DE' - адрес массива виртуальных клавиш
;   B'  - количество виртуальных клавиш в массиве
; Out :
;   если указанная виртуальная клавиша нажата/отпущена то вызовется обрабочик
;   флаг Z сброшен, если виртуальная клавиша отжата
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
.Loop           LD A, (DE)
                INC DE
                EX AF, AF'
                LD A, (DE)
                INC DE
                EXX
                LD C, A
                EX AF, AF'
                PUSH HL
                PUSH DE
; -----------------------------------------
; проверка нажатия/отпускания виртуальной клавиши (JumpHandlerKey)
; In :
;   A  - виртуальная клавиша
;   HL - адрес массива состояний виртуальных клавиш
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отпущена то вызовется обрабочик
;   флаг Z сброшен, если виртуальная клавиша отжата
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
                CALL Input.CheckKeyState
                LD A, (HL)
                JR NZ, .IsReleased
                OR A
                JR NZ, .NotProcessed
                INC (HL)
                EX DE, HL
                JP (HL)                             ; pressed
.IsReleased     OR A
                JR Z, .NotProcessed
                DEC (HL)
                EX DE, HL
                JP (HL)                             ; released
.NotProcessed   SCF
; -----------------------------------------
;  ~(JumpHandlerKey)
; -----------------------------------------

                POP DE
                POP HL
                RET NC
                INC HL
                EXX
                DJNZ .Loop
                RET
.KeyLastState   DS NUMBER_KEYS_ID, 0
.ArrayVKNum     DB VK_ENTER,        KEY_ID_MENU                                 ; клавиша "меню/пауза"
                DB VK_CAPS_SHIFT,   KEY_ID_ACCELERATION                         ; клавиша "ускорить"
                DB VK_SYMBOL_SHIFT, KEY_ID_BACK                                 ; клавиша "отмена/назад"
                DB VK_SPACE,        KEY_ID_SELECT                               ; клавиша "выбор"
                DB VK_D,            KEY_ID_RIGHT                                ; клавиша "вправо"
                DB VK_A,            KEY_ID_LEFT                                 ; клавиша "влево"
                DB VK_S,            KEY_ID_DOWN                                 ; клавиша "вниз"
.LastKey        DB VK_W,            KEY_ID_UP                                   ; клавиша "вверх"
.Num            EQU ($-.ArrayVKNum) / 2

                endif ; ~_MODULE_INPUT_
