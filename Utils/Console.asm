; Copyright 2021 Sergei Smirnov. All Rights Reserved.

 				ifndef	_UTILS_CONSOLE_
				define	_UTILS_CONSOLE_
	
				module Console	
FontAdr:		DW #3D00

; sets cursor position to A
; Arguments:
;	A - position of cursor
; Affects: none
At:				PUSH AF
				LD (CursorPos), A
				XOR A
				LD (CursorPosH), A
				POP AF
				RET

; sets cursor position to A
; Arguments:
;	BC - position of cursor (#0000-02ff)
; Affects: none
At2:			LD (CursorPos), BC
				RET

	
; halts CPU for N frames
; Arguments:
;	B - frames count (50 frames = 1 second)
; Affects:
;	Enables interrupts
Sleep:			EI
				HALT
				DJNZ Sleep
				RET

; draw char
; A - char
DrawChar:		; calculate source font address
				LD HL, (FontAdr)
				DEC H
				LD D, #00

				dup 3
				SLA A
				RL D
				edup

				LD E, A
				ADD HL, DE

				; set destination screen address
				LD A, (CursorPosH)
				RLCA
				RLCA
				RLCA
				ADD A, #40
.ConsoleScreen 	EQU $+1
				OR #00
				LD D, A
				LD A, (CursorPos)
				LD E, A
	
				INC A
				LD (CursorPos), A
				JR NZ, .Output
	
				LD HL, CursorPosH
				INC (HL)

.Output			; output
				dup 7
				LD A, (HL)
				LD (DE), A
				INC HL
				INC D
				edup
				LD A, (HL)
				LD (DE), A

				CALL AddressToAttrs
				LD A, (Color)
				LD (DE), A
				
				RET

SwitchScreen:	; switch screen log
				GetCurrentScreen
				LD A, #40
				JR Z, $+4
				LD A, #C0
				LD (DrawChar.ConsoleScreen), A
				RET

ShadowScreen:	; switch to shadow screen log
				GetShadowScreen
				LD A, #40
				JR Z, $+4
				LD A, #C0
				LD (DrawChar.ConsoleScreen), A
				RET
	
; Prints a string to console
; Arguments:
;	BC - address of string
Log:			; get next char from string
				LD A, (BC)
				AND A
				RET Z
	
				INC BC
	
				CP 10
				JR Z, LogCrlf
				CP 13
				JR Z, LogCrlf
	
				CALL DrawChar
	
				JR Log
	
LogCrlf:		LD A, (CursorPos)
				ADD A, 32
				AND %11100000
				LD (CursorPos), A
				JR Log

; Converts screen address to address in attributes
; Arguments:
;	DE - screen address
; Returns:
;	DE - address in attributes
AddressToAttrs:	LD A, D
				AND A
				RET Z
				AND #18
				RRCA
				RRCA
				RRCA
				OR #58	
				LD D, A
				LD A, (DrawChar.ConsoleScreen)
				OR D
				LD D, A
				RET

; Prints a 16-bit value to console
; Arguments:
;	BC - value to print
Logw:			PUSH HL
				PUSH DE
				PUSH BC
				PUSH AF
	
				LD HL, Buffer4
				LD D, 7
				LD E, 48

				LD A, B
				AND %11110000
				RRCA
				RRCA
				RRCA
				RRCA
				CP 10
				JR C, .LogW_1
				ADD A, D
.LogW_1:		ADD A, E
				LD (HL), A
				INC HL
	
				LD A, B
				AND %00001111
				CP 10
				JR C, .LogW_2
				ADD A, D
.LogW_2:		ADD A, E
				LD (HL), A
				INC HL
	
				LD A, B
				AND %00001111
				CP 10
				JR C, .LogW_3
				ADD A, D	
.LogW_3:		ADD A, E
				LD (HL), A
				INC HL
	
				LD A, B
				AND %00001111
				CP 10
				JR C, .LogW_4
.LogW_4			ADD A, D
				LD (HL), A
				INC HL
				LD (HL), #00

				LD BC, Buffer4
				CALL Log
	
				POP AF
				POP BC
				POP DE
				POP HL
				RET
	
	
// Prints a 8-bit value to console
// Arguments:
//	B - value to print
Logb:			PUSH HL
				PUSH DE
				PUSH BC
				PUSH AF
				LD HL, Buffer4
				LD D, 7
				LD E, 48
	
				LD A, B
				AND %11110000
				RRCA
				RRCA
				RRCA
				RRCA
				CP 10
				JR C, .Logb_1
				ADD A, D
.Logb_1:		ADD A, E
				LD (HL), A
				INC HL
	
				LD A, B
				AND %00001111
				CP 10
				JR C, .Logb_2
				ADD A, D
.Logb_2			ADD A, E
				LD (HL), A
				INC HL
				LD (HL), #00
	
				LD BC, Buffer4
				CALL Log
				POP AF
				POP BC
				POP DE
				POP HL
				RET

LogChar:		PUSH HL
				PUSH DE
				PUSH BC
				PUSH AF
				CALL DrawChar
				POP AF
				POP BC
				POP DE
				POP HL
				RET

Buffer4: 		DS 5, 0
CursorPos: 		DB 0
CursorPosH: 	DB 0
Color:			DB #47

				endmodule
	
				endif	; ~_UTILS_CONSOLE_
