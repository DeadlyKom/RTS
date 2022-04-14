
                ifndef _UTILS_PRINT_F_
                define _UTILS_PRINT_F_
; -----------------------------------------
; printf
; In:
;   DE - координаты в пикселях (D - y, E - x)
;   A  - номер символа
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PrintChar:      ; адрес экрана
                EX AF, AF'

                CALL CalcAddrByPixel.DE_HL
                PUSH HL
                EXX
                POP DE
                EXX

                LD IY, Metod.SBP_8_0
                JR Z, .NotShift

                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                LD IY, Metod.SBP_8_0_S

.NotShift       EX AF, AF'
                
                LD H, HIGH ASCII_Info
                LD L, A
                LD A, (HL)

                LD H, HIGH ASCII_Data
                OR A
                RL L
                JR NC, $+3
                INC H
                LD C, (HL)
                INC L
                LD H, (HL)
                LD L, C
                PUSH HL

                ; 
                LD HL, TempValue
                LD (HL), A

                ; ширина
                XOR A
                RLD
                ADD A, E
                LD E, A

                ; высота
                XOR A
                RLD
                SUB #0A
                NEG
                LD (.RowOffset), A

                POP HL
                PUSH DE

                ;
                LD (.ContainerSP), SP

                ; protection data corruption during interruption
                RestoreBC
                LD C, (HL)
                INC HL
                LD B, (HL)
                DEC HL
                PUSH BC
                EXX
                POP BC
                EXX
                LD SP, HL

                ; ---------------------------------------------
                ; двухпроходные вызовы
                ; ---------------------------------------------
                LD HL, .JumpsRows
.RowOffset      EQU $+1
                LD DE, #0000

.EvenRows       ADD HL, DE
.JumpsRows      rept 5
                JP (IY)
                endr

.ContainerSP    EQU $+1
                LD SP, #0000
                POP DE

                RET

GetArgument_8:  LD HL, (ArgumentAddress)
                LD A, (HL)
                INC HL
                LD (ArgumentAddress), HL
                RET
GetArgument_16: LD HL, (ArgumentAddress)
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (ArgumentAddress), HL
                RET

; -----------------------------------------
; printf
; In:
;   HL - адрес текста
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
;   %i - int8
;   %I - int16
;   %u - uint8
;   %U - uint16
;   %h - hex8
;   %H - Hex16
;   %s - string
; -----------------------------------------
Printf:         ; поиск аргумента
                PUSH HL
.NextChar       LD A, (HL)
                INC HL
                OR A
                JR NZ, .NextChar
                LD (ArgumentAddress), HL

.Loop           POP HL
.CheckNull      ; проверка на терминальный ноль
                LD A, (HL)
                OR A
                RET Z

                INC HL

                ; проверка на символ кода
                CP '%'
                JR Z, .ParseCode

.DrawChar       ; отображение символа
                PUSH HL
                CALL PrintChar
                JR .Loop

.ParseCode      ; INC HL
                LD A, (HL)
                OR A
                RET Z

                INC HL

                ; int8
                CP 'i'
                JP Z, Int8

                ; int16
                CP 'I'
                JP Z, $

                ; uint8
                CP 'u'
                JP Z, $

                ; uint16
                CP 'U'
                JP Z, $

                ; hex8
                CP 'h'
                JP Z, $

                ; hex16
                CP 'H'
                JP Z, $

                ; string
                CP 's'
                JP Z, String

                DEC HL
                LD A, '%'
                JR .DrawChar

Int8:           PUSH HL
                EXX
                CALL GetArgument_8
                OR A
                PUSH AF
                JP P, .ToString
                NEG
.ToString       CALL B2D8
                POP AF
                JP P, .IsPositive
                DEC HL
                LD (HL), '-'
.IsPositive     PUSH HL
                EXX
                POP HL
                CALL String.Loop
                JP Printf.Loop

String:         PUSH HL

.Loop           ; проверка на терминальный ноль
                LD A, (HL)
                OR A
                RET Z
                INC HL
                PUSH HL
                CALL PrintChar
                POP HL
                JR .Loop

; Combined routine for conversion of different sized binary numbers into
; directly printable ASCII(Z)-string
; Input value in registers, number size and -related to that- registers to fill
; is selected by calling the correct entry:
;
;  entry  inputregister(s)  decimal value 0 to:
;   B2D8             A                    255  (3 digits)
;   B2D16           HL                  65535   5   "
;   B2D24         E:HL               16777215   8   "
;   B2D32        DE:HL             4294967295  10   "
;   B2D48     BC:DE:HL        281474976710655  15   "
;   B2D64  IX:BC:DE:HL   18446744073709551615  20   "
;
; The resulting string is placed into a small buffer attached to this routine,
; this buffer needs no initialization and can be modified as desired.
; The number is aligned to the right, and leading 0's are replaced with spaces.
; On exit HL points to the first digit, (B)C = number of decimals
; This way any re-alignment / postprocessing is made easy.
; Changes: AF,BC,DE,HL,IX
; P.S. some examples below
; by Alwin Henseler

B2D8:           LD H, #00
                LD L, A
B2D16:          LD E, #00
B2D24:          LD D, #00
B2D32:          LD BC, #0000
B2D48:          LD IX, #0000                                                    ; zero all non-used bits
B2D64:          LD (B2DINV), HL
                LD (B2DINV+2), DE
                LD (B2DINV+4), BC
                LD (B2DINV+6), IX                                               ; place full 64-bit input value in buffer
                LD HL,B2DBUF
                LD DE,B2DBUF+1
                LD (HL)," "
B2DFILC:        EQU $-1                                                         ; address of fill-character
                LD BC, #12
                LDIR                                                            ; fill 1st 19 bytes of buffer with spaces
                LD (B2DEND-1),BC                                                ; set BCD value to "0" & place terminating 0
                LD E, #01                                                       ; no. of bytes in BCD value
                LD HL,B2DINV+8                                                  ; (address MSB input)+1
                LD BC, #0909
                XOR A
B2DSKP0:        DEC B
                JR Z, B2DSIZ                                                    ; all 0: continue with postprocessing
                DEC HL
                OR (HL)                                                         ; find first byte <>0
                JR Z, B2DSKP0
B2DFND1:        DEC C
                RLA
                JR NC, B2DFND1                                                  ; determine no. of most significant 1-bit
                RRA
                LD D, A                                                         ; byte from binary input value
B2DLUS2:        PUSH HL
                PUSH BC
B2DLUS1:        LD HL, B2DEND-1                                                 ; address LSB of BCD value
                LD B, E                                                         ; current length of BCD value in bytes
                RL D                                                            ; highest bit from input value -> carry
B2DLUS0:        LD A, (HL)
                ADC A, A
                DAA
                LD (HL), A                                                      ; double 1 BCD byte from intermediate result
                DEC HL
                DJNZ B2DLUS0                                                    ; and go on to double entire BCD value (+carry!)
                JR NC, B2DNXT
                INC E                                                           ; carry at MSB -> BCD value grew 1 byte larger
                LD (HL), #01                                                    ; initialize new MSB of BCD value
B2DNXT:         DEC C
                JR NZ, B2DLUS1                                                  ; repeat for remaining bits from 1 input byte
                POP BC                                                          ; no. of remaining bytes in input value
                LD C, #08                                                       ; reset bit-counter
                POP HL                                                          ; pointer to byte from input value
                DEC HL
                LD D, (HL)                                                      ; get next group of 8 bits
                DJNZ B2DLUS2                                                    ; and repeat until last byte from input value
B2DSIZ:         LD HL, B2DEND                                                   ; address of terminating 0
                LD C, E                                                         ; size of BCD value in bytes
                OR A
                SBC HL, BC                                                      ; calculate address of MSB BCD
                LD D, H
                LD E, L
                SBC HL, BC
                EX DE, HL                                                       ; HL=address BCD value, DE=start of decimal value
                LD B, C                                                         ; no. of bytes BCD
                SLA C                                                           ; no. of bytes decimal (possibly 1 too high)
                LD A, '0'
                RLD                                                             ; shift bits 4-7 of (HL) into bit 0-3 of A
                CP '0'                                                          ; (HL) was > 9h?
                JR NZ, B2DEXPH                                                  ; if yes, start with recording high digit
                DEC C                                                           ; correct number of decimals
                INC DE                                                          ; correct start address
                JR B2DEXPL                                                      ; continue with converting low digit
B2DEXP:         RLD                                                             ; shift high digit (HL) into low digit of A
B2DEXPH:        LD (DE), A                                                      ; record resulting ASCII-code
                INC DE
B2DEXPL:        RLD
                LD (DE), A
                INC DE
                INC HL                                                          ; next BCD-byte
                DJNZ B2DEXP                                                     ; and go on to convert each BCD-byte into 2 ASCII
                SBC HL, BC                                                      ; return with HL pointing to 1st decimal
                RET

B2DINV:         DS 8                                                            ; space for 64-bit input value (LSB first)
B2DBUF:         DS 21                                                           ; space for 20 decimal digits
B2DEND:         DS 1                                                            ; space for terminating 0
FIXBUF:         DS 8                                                            ;

TempValue       DB #00
ArgumentAddress DW #0000

                endif ; ~_UTILS_PRINT_F_
