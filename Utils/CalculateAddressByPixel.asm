
                    ifndef _UTILS_CALCULATE_ADDRESS_BY_PIXELS_
                    define _UTILS_CALCULATE_ADDRESS_BY_PIXELS_

                    module CalcAddrByPixel
; -----------------------------------------
; In :
;   BC - координаты в пикселах (C - x, B - y)
; Out :
;   HL - адрес экрана
;   A  - номер бита
; Corrupt :
;   HL, AF
; -----------------------------------------
BC_HL:              LD A, B                 ; Calculate Y2,Y1,Y0
                    AND %00000111           ; Mask out unwanted bits
                    OR %01000000            ; Set base address of screen
                    LD H, A                 ; Store in H
                    LD A, B                 ; Calculate Y7,Y6
                    RRA                     ; Shift to position
                    RRA
                    RRA
                    AND %00011000           ; Mask out unwanted bits
                    OR H                    ; OR with Y2,Y1,Y0
                    LD H, A                 ; Store in H
                    LD A, B                 ; Calculate Y5,Y4,Y3
                    RLA                     ; Shift to position
                    RLA
                    AND %11100000           ; Mask out unwanted bits
                    LD L, A                 ; Store in L
                    LD A, C                 ; Calculate X4,X3,X2,X1,X0
                    RRA                     ; Shift into position
                    RRA
                    RRA
                    AND %00011111           ; Mask out unwanted bits
                    OR L                    ; OR with Y5,Y4,Y3
                    LD L, A
                    LD A, C
                    AND %00000111
                    RET
; -----------------------------------------
; In :
;   DE - координаты в пикселах (C - x, B - y)
; Out :
;   HL - адрес экрана
;   A  - номер бита
; Corrupt :
;   HL, AF
; -----------------------------------------
DE_HL:              LD A, D                 ; Calculate Y2,Y1,Y0
                    AND %00000111           ; Mask out unwanted bits
                    OR %01000000            ; Set base address of screen
                    LD H, A                 ; Store in H
                    LD A, D                 ; Calculate Y7,Y6
                    RRA                     ; Shift to position
                    RRA
                    RRA
                    AND %00011000           ; Mask out unwanted bits
                    OR H                    ; OR with Y2,Y1,Y0
                    LD H, A                 ; Store in H
                    LD A, D                 ; Calculate Y5,Y4,Y3
                    RLA                     ; Shift to position
                    RLA
                    AND %11100000           ; Mask out unwanted bits
                    LD L, A                 ; Store in L
                    LD A, E                 ; Calculate X4,X3,X2,X1,X0
                    RRA                     ; Shift into position
                    RRA
                    RRA
                    AND %00011111           ; Mask out unwanted bits
                    OR L                    ; OR with Y5,Y4,Y3
                    LD L, A
                    LD A, E
                    AND %00000111
                    RET

; -----------------------------------------
; In :
;   DE - координаты в пикселах (E - x, D - y)
; Out :
;   BC - адрес экрана
;   A  - номер бита
; Corrupt :
;   BC, AF
; Time :
;   128cc
; -----------------------------------------
DE_BC:              LD A, D                 ; Calculate Y2,Y1,Y0
                    AND %00000111           ; Mask out unwanted bits
                    OR %01000000            ; Set base address of screen
                    LD B, A                 ; Store in B
                    LD A, D                 ; Calculate Y7,Y6
                    RRA                     ; Shift to position
                    RRA
                    RRA
                    AND %00011000           ; Mask out unwanted bits
                    OR B                    ; OR with Y2,Y1,Y0
                    LD B, A                 ; Store in B
                    LD A, D                 ; Calculate Y5,Y4,Y3
                    RLA                     ; Shift to position
                    RLA
                    AND %11100000           ; Mask out unwanted bits
                    LD C, A                 ; Store in C
                    LD A, E                 ; Calculate X4,X3,X2,X1,X0
                    RRA                     ; Shift into position
                    RRA
                    RRA
                    AND %00011111           ; Mask out unwanted bits
                    OR C                    ; OR with Y5,Y4,Y3
                    LD C, A
                    LD A, E
                    AND %00000111
                    RET

                    endmodule
                    
                    endif ; ~_UTILS_CALCULATE_ADDRESS_BY_PIXELS_
