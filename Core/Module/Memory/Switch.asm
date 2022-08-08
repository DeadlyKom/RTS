
                ifndef _MODULE_MEMORY_SWITCH_
                define _MODULE_MEMORY_SWITCH_

                module Memory
Begin:          EQU $
; -----------------------------------------
; установка страницы в 3 банк памяти (#C000-#FFFF)
; In:
;   A - номер страницы памяти
; Out:
; Corrupt:
;   BC, AF, AF'
; Note:
; -----------------------------------------
SetPage:        EX AF, AF'
                LD BC, PORT_7FFD
                LD A, (BC)
                LD C, A
                EX AF, AF'
                XOR C
                AND PAGE_MASK
                XOR C
                LD C, LOW PORT_7FFD
                LD (BC), A
                OUT (C), A
                RET
SetPage0:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                LD (BC), A
                OUT (C), A
                RET
SetPage1:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                INC A
                LD (BC), A
                OUT (C), A
                RET
SetPage3:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_3
                LD (BC), A
                OUT (C), A
                RET
SetPage4:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_4
                LD (BC), A
                OUT (C), A
                RET
SetPage5:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
.OR             OR PAGE_5
                LD (BC), A
                OUT (C), A
                RET
SetPage6:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_6
                LD (BC), A
                OUT (C), A
                RET
SetPage7:       LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET
; ; -----------------------------------------
; ; чтение байта из указанной страницы
; ; In:
; ;   A  - номер страницы памяти
; ;   HL - адрес чтения
; ; Out:
; ;   E  - прочитанный байт
; ; Corrupt:
; ;   E, BC, AF
; ; Note:
; ; -----------------------------------------
; ReadByteToPage: EX AF, AF'
;                 LD BC, PORT_7FFD
;                 LD A, (BC)
;                 LD C, A
;                 EX AF, AF'
;                 XOR C
;                 AND PAGE_MASK
;                 XOR C
;                 LD C, LOW PORT_7FFD
;                 LD (BC), A
;                 OUT (C), A

;                 LD E, (HL)

;                 LD C, A
;                 EX AF, AF'
;                 XOR C
;                 AND PAGE_MASK
;                 XOR C
;                 LD C, LOW PORT_7FFD
;                 LD (BC), A
;                 OUT (C), A

;                 RET
; -----------------------------------------
; установка страницы видимого экрана
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
ScrPageToC000:  LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                BIT SCREEN_BIT, A
                JR Z, SetPage5.OR
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET
; -----------------------------------------
; установка страницы не видимого экрана
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
ScrPageToC000_: LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                BIT SCREEN_BIT, A
                JR NZ, SetPage5.OR
                OR PAGE_7
                LD (BC), A
                OUT (C), A
                RET
; -----------------------------------------
; установка экрана расположенного в #C000
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; проверяется 1 бит, 
; для 5 страницы равен 0
; для 7 страницы равен 1
; если будут другие страницы, ну сам дурак!
; -----------------------------------------
ScrFromPageC000 LD BC, PORT_7FFD
                LD A, (BC)
                BIT 1, A
                RES SCREEN_BIT, A
                JR Z, .Set

                SET SCREEN_BIT, A
.Set            LD (BC), A
                OUT (C), A
                RET
; -----------------------------------------
; переключение экранов
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
SwapScreens:    LD BC, PORT_7FFD
                LD A, (BC)
                XOR SCREEN_MASK
                LD (BC), A
                OUT (C), A
                RET
; -----------------------------------------
; отображение первого экрана
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
ShowBaseScreen: LD BC, PORT_7FFD
                LD A, (BC)
                AND SCREEN_MASK_INV
                LD (BC), A
                OUT (C), A
                RET
; -----------------------------------------
; отображение первого экрана
; In:
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
ShowShadowScreen: LD BC, PORT_7FFD
                LD A, (BC)
                OR SCREEN_MASK
                LD (BC), A
                OUT (C), A
                RET

                display " - Memory Switch : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_MEMORY_SWITCH_
