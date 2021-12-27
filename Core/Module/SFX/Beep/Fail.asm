
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

                POP AF

                RET

                endif ; ~ _CORE_MODULE_SFX_BEEP_FAIL_