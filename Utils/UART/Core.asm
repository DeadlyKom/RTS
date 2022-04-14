
                ifndef _UTILS_UART_INIT_
                define _UTILS_UART_INIT_
; -----------------------------------------
; In:
;	A  - конфигурация
;	HL - скорости передачи данных (115200/SpeedInBaud)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetBaudRate:    LD BC, REG_LINE_CTRL
				EX AF, AF'
				
				; установка DLAB = 1
				LD A, DLAB
				OUT (C), A

				; установка скорости передачи данных
				LD B, HIGH REG_DIV_L
				OUT (C), L
				INC B
				OUT (C), H

				; установка
				LD B, HIGH REG_LINE_CTRL
				EX AF, AF'
				AND ~DLAB
				OUT (C), A

                RET
; -----------------------------------------
; In:
; Out:
;	флаг переполнения Carry установлен в случае успеха
; Corrupt:
; Note:
; -----------------------------------------
CheckReceiver:	LD BC, REG_LINE_STATUS
				IN F, (C)														; FIFOE_BIT
				JP P, .Success
				OR A
				RET

.Success		SCF
				RET

; -----------------------------------------
; In:
;	E - счётчик попыток/времени ожидания
; Out:
;	флаг переполнения Carry установлен в случае успеха
; Corrupt:
;	E, BC, AF
; Note:
; -----------------------------------------
WaitTrasmitter:	LD BC, REG_LINE_STATUS

.Loop			; ожидание готовности передатчика
				IN A, (C)
				BIT THRE_BIT, A
				JR NZ, .Success

				; счётчик
				DEC E
				JR NZ, .Loop

.Fail			OR A
				RET

.Success		SCF
				RET

                endif ; ~_UTILS_UART_INIT_
