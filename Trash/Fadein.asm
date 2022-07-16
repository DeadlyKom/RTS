
                ifndef _CORE_MODULE_VFX_TEXT_FADEIN_
                define _CORE_MODULE_VFX_TEXT_FADEIN_

                module Text
; -----------------------------------------
; скролл текста
; In:
;   SharedBuffer - изображение
;   DE - координаты в знакоместах (D - y, E - x)
;   C  - длина строки в пикселях
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Fade:           CALL PixelAddressC
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
                LD (DE), A
                EXX

.ProcedureA     EQU $+0
.ProcedureB     EQU $+1
                NOP
                NOP
                EXX

                ; отображение копии на первом экране
                RES 7, D
                LD (DE), A
                SET 7, D

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

NextVFX:        
.Func           EQU $+1
                CALL Fadein_Tick.RET

                CALL Math.Rand8
                CP #2F                                                          ; чем меньше тем реже происходит смена эффекта
                JR C, .GenerateVFX
                LD C, #00
                RRA
                ADC A, C
                RRA
                ADC A, C
                RRA
                ADC A, C
                RRA
                ADC A, C
                LD HL, Fadein_Tick.TableDefault
                LD (Fade.Count), HL
                LD (Fadein_Tick.TicksCount), A
                RET

.GenerateVFX    AND #03
SetVFX:         ADD A, A
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
                DEC A
                LD (Fadein_Tick.CurTimeline), A
                LD (Fadein_Tick.TicksCount), A
                RET

.Table          DW Roll_A, Roll_A.Timeline
                DW Glitch_A, Glitch_A.Timeline
                DW Glitch_B, Glitch_B.Timeline
                DW Roll_B, Roll_A.Timeline
                DW Fadeout, Fadeout.Timeline
                DW Fadein, Fadein.Timeline
SetDefault:     ; отключение функторов
                LD HL, Fadein_Tick.RET
                LD (Fadein_Tick.FuncUpdate), HL
                LD (NextVFX.Func), HL
                
                ; отключение эффектов
                LD HL, Fadein_Tick.TableDefault
                LD (Fade.Count), HL
                LD A, #01
                LD (Fadein_Tick.TicksCount), A
                LD (Fadein_Tick.CurTimeline), A
                RET

Fadein_Tick:    ; 
                ;
.FuncUpdate     EQU $+1
                CALL .RET

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
                LD (Fade.Count), HL
                
.RET            RET

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
Fadein:         
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #F6, #FF

                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00
                DB #1F, #00
                DB #F6, #FF
                DB #E6, #00

                DB #00, #00
                DB #00, #00
                DB #1F, #00
                DB #17, #17
                DB #17, #00
                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00

                DB #00, #00
                DB #17, #00
                DB #17, #17
                DB #1F, #00
                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #1F, #00
                DB #1F, #1F
                DB #17, #00
                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #17, #17
                DB #1F, #00
                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #1F, #1F
                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #F6, #FF
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

.Timeline       ; (Fadeout)
                DB #0A
                DB #04, #03, #03, #03, #03, #03, #03, #03, #03, #03
Fadeout:        DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #E6, #00
                DB #17, #17
                DB #E6, #00
                DB #E6, #00
                DB #1F, #1F
                DB #E6, #00
                DB #E6, #00
                DB #E6, #00

                DB #00, #00
                DB #1F, #00
                DB #E6, #00
                DB #E6, #00
                DB #F6, #33
                DB #E6, #00
                DB #00, #00
                DB #E6, #00

                DB #00, #00
                DB #00, #00
                DB #E6, #00
                DB #E6, #00
                DB #17, #00
                DB #E6, #00
                DB #F6, #22
                DB #E6, #00

                DB #00, #00
                DB #00, #00
                DB #E6, #55
                DB #1F, #00
                DB #EE, #88
                DB #E6, #AA
                DB #00, #00
                DB #00, #00

.Timeline       ; (Fadeout)
                DB #06
                DB #03, #03, #03, #03, #03
Glitch_A:       ; 2.5 (glitch)
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
                DB #00, #00     ; #10
                DB #E6, #00     ; #60, #00
                DB #E6, #00     ; #00
                DB #00, #00     ; #10
                DB #E6, #00     ; #60, #00
                DB #E6, #00     ; #00
                DB #E6, #00     ; #00
                DB #00, #00     ; #10

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
                DB #00, #00     ; #10
                DB #E6, #00     ; #60, #00
                DB #E6, #00     ; #00
                DB #E6, #00     ; #00
                DB #00, #00     ; #10
                DB #E6, #00     ; #60, #00
                DB #00, #00     ; #10
                DB #00, #00     ; #00

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
                DB #07
                DB #0F, #04, #04, #04, #04, #05
Glitch_B:       ; 2.5 (glitch)
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
                DB #1F, #00
                DB #17, #17
                DB #17, #00
                DB #00, #00
                DB #1F, #00
                DB #00, #00

                ; 2.3 (glitch)
                DB #00, #00
                DB #E6, #00
                DB #E6, #06
                DB #1F, #1F
                DB #E6, #2A
                DB #EE, #18
                DB #E6, #00
                DB #00, #00

                ; 2.2 (glitch)
                DB #00, #00
                DB #00, #00
                DB #17, #00
                DB #EE, #2A
                DB #00, #00
                DB #17, #17
                DB #00, #00
                DB #00, #00
                
                ; 2.1 (glitch)
                DB #00, #00
                DB #E6, #54
                DB #F6, #33
                DB #E6, #55
                DB #EE, #2A
                DB #E6, #54
                DB #E6, #2A
                DB #00, #00

                ; 2.0 (glitch)
                DB #00, #00
                DB #00, #00
                DB #1F, #00
                DB #00, #00
                DB #1F, #00
                DB #00, #00
                DB #00, #00
                DB #00, #00

.Timeline       ; 2.0 (glitch)
                DB #07
                DB #0F, #04, #03, #04, #03, #04
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
                DB #04
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
                DB #03
                DB #0F, #05
 
                display " - Text Fadein VFX : \t\t", /A, Fade, " = busy [ ", /D, $ - Fade, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_VFX_TEXT_SCROLL_