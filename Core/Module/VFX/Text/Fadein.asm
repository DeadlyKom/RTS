
                ifndef _CORE_MODULE_VFX_TEXT_FADEIN_
                define _CORE_MODULE_VFX_TEXT_FADEIN_

                module Text
; -----------------------------------------
; скролл текста
; In:
;   SharedBuffer - изображение
;   DE - координаты в знакоместах (D - y, E - x)
;   C  - длина строки в пикселах
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Fadein:         CALL PixelAddress
                LD HL, SharedBuffer

                ; округление 
                LD B, #00
                LD A, C
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                AND %00011111

                EXX
.Count          EQU $+1
                LD HL, Fadein_Tick.TableDefault

                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (.ProcedureA), DE
                
                EXX
                ;
                LD C, A
                LD B, A
                LD A, #08
                
.ColumLoop      EX AF, AF'
                
                PUSH DE
                OR A    ; сброс флага переполнения
.RowLoop        LD A, (HL)
                EXX

.ProcedureA     EQU $+0
.ProcedureB     EQU $+1
                NOP
                NOP

                EXX
                LD (DE), A
                INC L
                INC E
                DEC C
                JR NZ, .RowLoop

                POP DE
                
                INC D
                LD C, B

                EXX
                
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (.ProcedureA), DE

                EXX

                ; следующая строка буфера
                LD A, L
                SUB C
                ADD A, #20
                LD L, A

                EX AF, AF'
                DEC A
                JR NZ, .ColumLoop

                RET
NextVFX:        CALL Math.Rand8
                CP #2F                                                          ; чем меньше тем реже происходит поворот
                JR C, .GenerateVFX
                RRA
                ADC A, #00
                RRA
                ADC A, #00
                RRA
                ADC A, #00
                RRA
                ADC A, #00
                LD HL, Fadein_Tick.TableDefault
                LD (Fadein.Count), HL
                LD (Fadein_Tick.TicksCount), A
                RET

.GenerateVFX    AND #03
                ADD A, A
                ADD A, A
                
                LD L, A
                LD H, #00
                LD DE, .Table
                ADD HL, DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (Fadein_Tick.Table), DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                LD (Fadein_Tick.Timeline), DE
                LD A, (DE)
                LD (Fadein_Tick.CurTimeline), A
                LD (Fadein_Tick.TicksCount), A
                RET

.Table          DW Roll_A, Roll_A.Timeline
                DW Glitch, Glitch.Timeline
                DW Roll_A, Roll_A.Timeline
                DW Roll_B, Roll_A.Timeline

Fadein_Tick:    ; 

                ; уменьшение счётчика прерываний
                LD HL, .TicksCount
                DEC (HL)
                RET NZ

                ; расчёт адреса текущего таймлайна
                LD D, (HL)                                                      ; обнуление D
                LD A, (.CurTimeline)
                DEC A
                JP Z, NextVFX
                
.Timeline       EQU $+1
                LD HL, #0000
.SkipInit       LD E, A
                ADD HL, DE
                LD (.CurTimeline), A

                ; установка нового счётчика
                LD A, (HL)
                LD (.TicksCount), A

                ; расчёт адреса таблицы процедур
                EX DE, HL
                DEC L
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
.Table          EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (Fadein.Count), HL
                
                RET

.TicksCount     DB #01
.CurTimeline    DB #01

                ; XOR #00 ; #EE, #00
                ; AND #00 ; #E6, #00
                ; OR #00  ; #F6, #00
                ; RRA     ; #1F
                ; RLA     ; #17
                ; RRCA    ; #0F
                ; RLCA    ; #07
.TableDefault   DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

Glitch:         ; 2.5 (glitch)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

                ; 2.4 (glitch)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #00, #00
                DB #1F, #00
                DB #00, #00

                ; 2.3 (glitch)
                DB #00, #00
                DB #E6, #00
                DB #E6, #00
                DB #00, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #00, #00

                ; 2.2 (glitch)
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                
                ; 2.1 (glitch)
                DB #00, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #00, #00
                DB #E6, #00
                DB #00, #00
                DB #00, #00

                ; 2.0 (glitch)
                DB #00, #00
                DB #00, #00
                DB #1F, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

.Timeline       ; 2.0 (glitch)
                DB #06
                DB #0F, #04, #04, #04, #04, #05
Roll_A:         ; 1.2 (roll)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

                ; 1.1 (roll)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #17, #00     ; #17, #17
                DB #1F, #00
                DB #00, #00
                DB #00, #00

                ; 1.0 (roll)
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #1F, #00
                DB #00, #00
                DB #17, #00
                DB #00, #00
                DB #00, #00

.Timeline       ; 1.0 (roll)
                DB #03
                DB #0F, #04, #05

Roll_B:         ; 1.1 (roll)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

                ; 1.0 (roll)
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #00, #00
                DB #1F, #00
                DB #1F, #00
                DB #00, #00

.Timeline       ; 1.0 (roll)
                DB #02
                DB #0F, #05
 
                display " - VFX Fadein Text : \t\t", /A, Fadein, " = busy [ ", /D, $ - Fadein, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_VFX_TEXT_SCROLL_