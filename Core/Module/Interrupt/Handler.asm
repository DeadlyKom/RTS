
                ifndef _CORE_MODULE_INTERRUPT_HANDLER_
                define _CORE_MODULE_INTERRUPT_HANDLER_
; -----------------------------------------
; обработчик прерывания
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Handler:        ; ********** HANDLER IM 2 *********
                EX (SP), HL
                LD (.ReturnAddress), HL
                POP HL                                                          ; восстановить значение HL
                LD (.Container_SP), SP                                          ; сохранить исходный указатель стека
.RestoreRegister EQU $
                NOP                                                             ; восстановить поврежденные байты ниже SP (PUSH HL/DE/BC)
                LD SP, Int.StackTop                                             ; использовать стек прерывания

.SaveRegs       ; ********* SAVE REGISTERS ********
                PUSH HL
                PUSH DE
                PUSH BC
                PUSH IX
                PUSH IY
                PUSH AF
                EX AF, AF'
                PUSH AF
                EXX
                PUSH HL
                PUSH DE
                PUSH BC
                ; ~ SAVE REGISTERS

.SaveMemPage    ; ******** SAVE MEMORY PAGE *******
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage+1), A
                ; ~ SAVE MEMORY PAGE

.TickCounter    ; ********** TICK COUNTER *********
.TickCounterPtr EQU $+1
                LD HL, #0000
                INC HL
                LD (.TickCounterPtr), HL

                ; ********* USER INTERRUPT ********

.UserInterrupt  EQU $+1
                CALL .RET
                ; ~ USER INTERRUPT

; .Music          ; *********** PLAY MUSIC **********
;                 ; play music
;                 ifdef ENABLE_MUSIC
;                 CALL Game.PlayMusic
;                 endif
;                 ; ~ PLAY MUSIC

.RestoreMemPage ; ****** RESTORE MEMORY PAGE ******
                LD A, #00
                CALL SetPage
                ; ~ RESTORE MEMORY PAGE

.RestoreReg     ; ******** RESTORE REGISTERS ******
                POP BC
                POP DE
                POP HL
                EXX
                POP AF
                EX AF, AF'
                POP AF
                POP IY
                POP IX
                POP BC
                POP DE
                POP HL
                ; ~ RESTORE REGISTERS

.Container_SP   EQU $+1
                LD SP, #0000
                EI
.ReturnAddress  EQU $+1
                JP #0000
                ; ~ HANDLER IM 2
.RET            RET

                endif ; ~ _CORE_MODULE_INTERRUPT_HANDLER_
