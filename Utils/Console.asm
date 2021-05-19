; // Copyright 2021 Sergei Smirnov. All Rights Reserved.

 	ifndef	_UTILS_CONSOLE_
	define	_UTILS_CONSOLE_
	
	module Console
	
	
font_addr: 
	dw 15616
	
	
// Sets cursor position to A
// Arguments:
//	A - position of cursor
// Affects: none
At:
	push af
	ld (cursorPos), a
	xor a
	ld (cursorPosH), a
	pop af
	ret


// Sets cursor position to A
// Arguments:
//	BC - position of cursor (#0000-02ff)
// Affects: none
At2:
	ld (cursorPos), bc
	ret

	
// Halts CPU for N frames
// Arguments:
//	B - frames count (50 frames = 1 second)
// Affects:
//	Enables interrupts
sleep:
	ei
	halt
	djnz sleep
	ret
	
	
// Prints a string to console
// Arguments:
//	BC - address of string
log:
	// get next char from string
	ld a, (bc)
	and a
	ret z
	
	inc bc
	
	cp 10
	jr z, log_crlf
	cp 13
	jr z, log_crlf
	
	// calc source font address
	ld hl, (font_addr)
	dec h
	ld d, 0
	sla a
	rl d
	sla a
	rl d
	sla a
	rl d
	ld e, a
	add hl, de

	// set destination screen address
	ld a, (cursorPosH)
	rlca
	rlca
	rlca
	add #40
NoflicConsoleScreenAddr: equ $+1
	or 0
	ld d, a
	ld a, (cursorPos)
	ld e, a
	
	inc a
	ld (cursorPos), a
	jr nz, log_1
	
	ld hl, cursorPosH
	inc (hl)
log_1:
	// output
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a : inc hl : inc d
	ld a, (hl) : ld (de), a
	
	call address_to_attrs
	ld a, (color)
	ld (de), a
	
	jr log
	
log_crlf:
	ld a, (cursorPos)
	add 32
	and %11100000
	ld (cursorPos), a
	jr log
	
	
// Converts screen address to address in attributes
// Arguments:
//	DE - screen address
// Returns:
//	DE - address in attributes
address_to_attrs:
	ld a, d
	and a
	ret z
	and #18
	rrca 
	rrca
	rrca
	or #58	
	ld d, a
	ld a, (NoflicConsoleScreenAddr)
	or d
	ld d, a
	ret
	
	
// Prints a 16-bit value to console
// Arguments:
//	BC - value to print
logw:
	push hl
	push de
	push bc
	push af
	
	ld hl, buffer4
	ld d, 7
	ld e, 48
	
	ld a, b
	and %11110000
	rrca : rrca : rrca : rrca
	cp 10
	jr c, logw_1
	add d
logw_1:	add e
	ld (hl), a
	inc hl
	
	ld a, b
	and %00001111
	cp 10
	jr c, logw_2
	add d
logw_2:	add e
	ld (hl), a
	inc hl
	
	ld a, c
	and %11110000
	rrca : rrca : rrca : rrca
	cp 10
	jr c, logw_3
	add d
logw_3:	add e
	ld (hl), a
	inc hl
	
	ld a, c
	and %00001111
	cp 10
	jr c, logw_4
	add d
logw_4:	add e
	ld (hl), a
	inc hl
	ld (hl), 0
	
	ld bc, buffer4
	call log
	
	pop af
	pop bc
	pop de
	pop hl
	ret
	
	
// Prints a 8-bit value to console
// Arguments:
//	B - value to print
Logb:
	push hl
	push de
	push bc
	push af
	ld hl, buffer4
	ld d, 7
	ld e, 48
	
	ld a, b
	and %11110000
	rrca : rrca : rrca : rrca
	cp 10
	jr c, logb_1
	add d
logb_1:	add e
	ld (hl), a
	inc hl
	
	ld a, b
	and %00001111
	cp 10
	jr c, logb_2
	add d
logb_2:	add e
	ld (hl), a
	inc hl
	ld (hl), 0
	
	ld bc, buffer4
	call log
	pop af
	pop bc
	pop de
	pop hl
	ret
	
	
buffer4: ds 5, 0
	
cursorPos: db 0
cursorPosH: db 0
	
color:	db #47
	
	
	endmodule
	
	endif	; ~_UTILS_CONSOLE_
	