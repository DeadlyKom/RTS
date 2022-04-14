
                ifndef _UTILS_UART_LIBRARY_
                define _UTILS_UART_LIBRARY_

; -----------------------------------------
; In:
;   HL - скорости передачи данных (115200/SpeedInBaud)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Init:           CALL CheckReceiver
                LD A, WLSB0 | WLSB1
                CALL C, SetBaudRate

                RET
; -----------------------------------------
; In:
;   A - передоваемый байт
; Out:
;   флаг переполнения Carry установлен в случае успеха
; Corrupt:
;	E, BC, AF, AF'
; Note:
; -----------------------------------------
SendByte:       EX AF, AF'

                ; ожидание готовности передатчика
                LD E, #00
                CALL WaitTrasmitter
                RET NC

                LD B, HIGH REG_IO
                EX AF, AF'
                OUT (C), A
                SCF
                RET
; -----------------------------------------
; In:
;   DE - передоваемое слово
; Out:
;   флаг переполнения Carry установлен в случае успеха
; Corrupt:
;	E, BC, AF, AF'
; Note:
; -----------------------------------------
SendWord:       LD A, E
                CALL SendByte
                LD A, D
                CALL C, SendByte
                RET
; -----------------------------------------
; In:
;   HL - адрес строки
; Out:
;   флаг переполнения Carry установлен в случае успеха
; Corrupt:
;	HL, E, BC, AF, AF'
; Note:
; -----------------------------------------
SendString:     ; проверка на терминальный ноль
.Loop           LD A, (HL)
                OR A
                JR Z, .Success

                INC HL
                CALL SendByte
                RET NC
                JR .Loop

.Success        SCF
                RET

; -----------------------------------------
; In:
;   HL - адрес данных
;   D  - размер
; Out:
;   флаг переполнения Carry установлен в случае успеха
; Corrupt:
;   HL, DE, BC, AF, AF'
; Note:
; -----------------------------------------
SendPack:       ; 
.Loop           LD A, (HL)
                INC HL
                CALL SendByte
                RET NC
                DEC D
                JR NZ, .Loop

.Success        SCF
                RET

                endif ; ~_UTILS_UART_LIBRARY_
