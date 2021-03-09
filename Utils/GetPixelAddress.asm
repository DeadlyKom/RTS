
                    ifndef _UTILS_GET_PIXEL_ADDRESS_
                    define _UTILS_GET_PIXEL_ADDRESS_

; -----------------------------------------
; In :
;   BC - координаты в пикселах (C - x, B - y)
; Out :
;   HL - адрес экрана
;   A  - номер бита
; Corrupt :
;   HL, AF
; -----------------------------------------
CalcPixelAddress:   LD A, B                 ; Calculate Y2,Y1,Y0
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

                    endif ; ~_UTILS_GET_PIXEL_ADDRESS_
