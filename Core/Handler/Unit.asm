  
                        ifndef _CORE_HANDLER_UNIT_
                        define _CORE_HANDLER_UNIT_

; -----------------------------------------
; visibility computation handler of units
; In:
;   IY - an array of FUnit structures
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
HandlerUnits:           ; initialize
                        DI
                        LD (.ContainerSP), SP
                        LD A, (MemoryPage_5.GameEntry.CountUnits)
                        LD (.ProcessedUnits), A
                        ; Lx - позиция юнита (в тайлах)
                        ; Vx - позиция видимой области карты (в тайлах)
                        ; Ox - смещение относительно тайла в которых расположен юнет (в пикселах, знаковое)
                        ; Sx - ширина спрайта (в пикселах)
                        ; SOx - смещение спрайта (в пикселах)
.Loop                   LD HL, MemoryPage_5.TileMapOffset.X
                        LD A, (IY + FUnit.Location.X)               ; A = Lx
                        SUB (HL)                                    ; A = Lx - Vx
                        ; A <<= 4
                        ADD A, A
                        ADD A, A
                        ADD A, A
                        ADD A, A
                        ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                        ADD A, (IY + FUnit.PixelOffset.X)           ; A += Ox
                        ADD A, #08                                  ; A += 8
                        ; расчёт адреса данных о спрайте
                        EX AF, AF'
                        LD HL, MemoryPage_5.TableSprites
                        LD A, (IY + FUnit.Type)
                        ADD A, L
                        LD L, A
                        JR NC, $+3
                        INC H
                        ; начальный адрес данных о текущем типе юнита
                        LD E, (HL)
                        INC HL
                        LD D, (HL)
                        ; получим смещение (AnimationIndex * FSprite)
                        LD H, HIGH MemoryPage_5.OffsetTableByAnimIndex
                        LD A, (IY + FUnit.AnimationIndex)           ; номер анимации (индекс спрайта)
                        ADD A, A                                    ; A *= 2 (т.к. адрес)
                        LD L, A
                        LD A, (HL)
                        INC L
                        LD H, (HL)
                        LD L, A
                        ADD HL, DE                                  ; HL - адрес информации о текущем спрайте
                        EX AF, AF'
                        ; корректируем положение спрайта из информации о спрайте
                        LD E, (HL)                                  ; E - ширина спрайта (в пикселах)
                        INC HL
                        ADD A, E
                        SUB (HL)                                    ; (HL) - смещение в спрайте (в пикселах)
                        JP M, .NextUnit                             ; если отрицательный, значит спрайт не видим
                        ; 
                        LD D, A                                     ; сохрание рисуемых пикселей (оставшихся)

                        LD A, E
                        SUB D
                        RRA
                        RRA
                        RRA
                        AND %00011111
                        ;LD B, A                                     ; сохраним количество пропускаемых байт
                        ADD A, A    ; x2
                        ;ADD A, B    ; x3
                        ADD A, A    ; x4

                        ; смещение в таблице, если байт выравнен
                        LD C, A
                        LD A, D
                        AND %00000111
                        LD A, C
                        JR NZ, $+4
                        ADD A, 12

                        SRL E
                        SRL E
                        SRL E
                        DEC E
                        ADD A, E    ; + смещение (байтовое)
                        ADD A, A    ; x2 (адрес)
                        ; расчёт адреса обработчика
                        EXX
                        LD HL, .TableLSJumpDraw
                        ADD A, L
                        LD L, A
                        JR NC, $+3
                        INC H
                        LD SP, HL
                        POP IX
                        EXX
                        ;
                        INC HL ; height
                        INC HL ; offset_y
                        INC HL ; page
                        ; set page sprite
                        LD A, (HL)
                        SeMemoryPage_A
                        ;
                        LD A, D
                        AND %00000111
                        ;
                        INC HL ; pointer sprite
                        LD E, (HL)
                        INC HL
                        LD D, (HL)
                        EX DE, HL
                        LD SP, HL
                        LD BC, #4000

                        ; - лишний если байт выравнен
                        EXX
                        ; calculate address of shift table
                        DEC A
                        ADD A, A
                        ADD A, HIGH MemoryPage_5.ShiftTable
                        LD H, A
                        INC H       ; временно (т.к. для текущей функции 24_2)
                        EXX
                        ; ~ лишний если байт выравнен

                        LD HL, $+3
                        rept 12
                        JP (IX)
                        endr

                        JR .Exit

.Exit
.ContainerSP            EQU $+1
                        LD SP, #0000
                        EI
                        RET

.NextUnit               LD HL, MemoryPage_5.GameEntry.CountUnits
                        LD HL, .ProcessedUnits
                        DEC (HL)
                        RET Z
                        LD BC, FUnit
                        ADD IY, BC
                        JP .Loop

.ProcessedUnits         DB #02
                        ; горизонталь - длина спрайта
                        ; вертикаль - количество пропускаемых байт
                        ;                ---- shift ----
                        ;        8          16         24         --
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |          |          |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |          |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;                ---- not shift ----
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |          |          |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |          |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |          |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        
                        ; left shift
.TableLSJumpDraw        DW #0000, #0000, SBP_24_0_LS, #0000
                        DW #0000, #0000, SBP_24_1_LS, #0000
                        DW #0000, #0000, SBP_24_2_LS, #0000
                        ; left, not shift
                        DW #0000, #0000, SBP_24_0,    #0000
                        DW #0000, #0000, SBP_24_1_L,  #0000
                        DW #0000, #0000, SBP_24_2_L,  #0000

                        endif ; ~_CORE_HANDLER_UNIT_
