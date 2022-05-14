
                ifndef _CORE_MODULE_SFX_BEEP_FAIL_
                define _CORE_MODULE_SFX_BEEP_FAIL_

DEF_FE          EQU #00
BEEP            EQU 1 << 4
Fail:           PUSH AF

                LD HL, %1001100111000111
                LD C, A
                LD B, 16

.Loop           LD A, 8
.Wait_          EX AF, AF'

                LD A, #40
.Wait           DEC A
                JR NZ, .Wait
                EX AF, AF'
                DEC A
                JR NZ, .Wait_

                LD A, DEF_FE
                ADD HL, HL
                JR NC, $+4
                OR BEEP
                OUT (#FE), A
                DJNZ .Loop

;                   лазер
;                 LD BC, 64004
;                 LD HL, 512
;                 LD DE, 2
; .LA             PUSH HL
;                 PUSH DE
;                 PUSH BC
;                 CALL 949
;                 POP BC
;                 POP DE
;                 POP HL
;                 LD A, L
;                 SUB C
;                 LD L, A
;                 DJNZ .LA

;                   выстрел
;                 LD A, (23624)
;                 SRL A
;                 SRL A
;                 LD L, A
;                 LD E, 0
;                 LD D, 128
; .LC             PUSH DE
; .LB             LD B, E
; .LA             DJNZ .LA
;                 LD A, (BC)
;                 AND 248
;                 OR L
;                 OUT (254), A
;                 INC C
;                 DEC D
;                 JR NZ, .LB
;                 POP DE
;                 INC E
;                 DEC D
;                 JR NZ, .LC

;               писк
;                 LD A, (21320)
;                 RRCA
;                 RRCA
;                 RRCA
;                 LD E, 200
; .LB             OUT (254), A
;                 XOR 17
;                 LD B, E
; .LA             DJNZ .LA
;                 DEC E
;                 JR NZ, .LB

;               писк
;                 LD E, 50
;                 LD C, 254
; .LC             LD D, A
;                 RES 4, D
;                 RES 3, D
;                 LD B, E
; .LB             CP B
;                 JR NZ, .LA
;                 LD D, 24
; .LA             OUT (C), D
;                 DJNZ .LB
;                 DEC A
;                 JR NZ, .LC

                POP AF

                RET

                endif ; ~ _CORE_MODULE_SFX_BEEP_FAIL_