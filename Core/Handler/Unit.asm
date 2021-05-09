  
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
                        JP .New
.Loop                   LD HL, MemoryPage_5.TileMapOffset.X
                        LD A, (IY + FUnit.Location.X)               ; A = Lx
                        SUB (HL)                                    ; A = Lx - Vx
                        ; A <<= 4
                        ADD A, A
                        ADD A, A
                        ADD A, A
                        ADD A, A
                        LD B, A                                     ; сохраним для вертикали
                        ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                        ADD A, (IY + FUnit.PixelOffset.X)           ; A += Ox
                        ADD A, #08                                  ; A += 8
                        EX AF, AF'
                        LD A, B
                        ADD A, (IY + FUnit.PixelOffset.Y)           ; A += Oy
                        ADD A, #08                                  ; A += 8
                        LD B, A
                        ; расчёт адреса данных о спрайте
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
                        ; получим смещение (AnimationIndex * FSprite) - если выравнить FSprite таблица не нужна
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
                        ; корректируем положение спрайта из информации о спрайте (горизонталь)
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

                        ; корректируем положение спрайта из информации о спрайте (вертикаль)
                        LD A, B
                        INC HL ; height
                        LD C, (HL)                                  ; C - высота спрайта (в пикселах)
                        INC HL ; offset_y
                        ADD A, C
                        SUB (HL)                                    ; (HL) - смещение в спрайте (в пикселах)
                        JP M, .NextUnit                             ; если отрицательный, значит спрайт не видим
                        LD B, A
                        LD A, C
                        SUB B
                        LD B, A

                        INC HL ; page

                        ; set page sprite
                        LD A, (HL)
                        SeMemoryPage_A
                        ;
                        LD A, D
                        AND %00000111
                        ;
                        INC HL  ; pointer sprite
                        LD E, (HL)
                        INC HL
                        LD D, (HL)

                        EX DE, HL
                        LD SP, HL

                        LD BC, #0000                            ; буфер

                        EXX
                        LD BC, #4000                            ; экран
                        EXX

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

.New                    ; инициализация
                        XOR A
                        LD (.OffsetSprite), A                       ; отсутствует пропуск байт в спрайте

                        ; расчёт адреса данных о спрайте
                        LD HL, MemoryPage_5.TableSprites
                        LD D, #00
                        LD E, (IY + FUnit.Type)
                        ADD HL, DE
                        ; начальный адрес данных о текущем типе юнита
                        LD SP, HL
                        POP HL
                        ; получим смещение (AnimationIndex * FSprite) - выравнить FSprite по 8 байт
                        LD E, (IY + FUnit.AnimationIndex)           ; номер анимации (индекс спрайта)
                        EX DE, HL                                   ; HL = #00-AnimationIndex
                        ADD HL, HL                                  ; HL = AnimationIndex * 2
                        ADD HL, HL                                  ; HL = AnimationIndex * 4
                        ADD HL, HL                                  ; HL = AnimationIndex * 8
                        ADD HL, DE                                  ; HL - адрес информации о текущем спрайте
                        LD SP, HL                                   ; SP - указывает на информацию о текущем спрайте
                        ; FSprite Height (8), Offset_Y (8), Width (8), Offset_X (8), Dummy (8), Page Sprite (8), Address Sprite (16)
                        POP DE                                      ; D - вертикальное смещение (SOy), E - высота спрайта (Sy)
                        ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                        ; (Oy + 8)
                        LD A, (IY + FUnit.PixelOffset.Y)            ; A = Oy
                        ADD A, #08                                  ; A += 8
                        ; (Sy - SOy)
                        ADD A, E                                    ; A += Sy
                        SUB D                                       ; A -= SOy
                        ; преобразуем резульат (Oy + 8 + Sy - SOy) в 16-битное число
                        LD C, A                                     ; C = Oy + 8 + Sy - SOy
                        SBC A, A                                    ; если было переполнение (отрицательное число), корректируем
                        LD B, A
                        ; (Ly - Vy)
                        LD HL, MemoryPage_5.TileMapOffset.Y
                        LD A, (IY + FUnit.Location.Y)               ; A = Ly
                        SUB (HL)                                    ; A = Ly - Vy
                        ; ToDo значение для вертикали должно лежать в пределах от -1 до 12 (12 тайлов + 2 выше и ниже)
                        ADD A, A                                    ; A = (Ly - Vy) * 2
                        ADD A, A                                    ; A = (Ly - Vy) * 4
                        ADD A, A                                    ; A = (Ly - Vy) * 8
                        ADD A, A                                    ; A = (Ly - Vy) * 16
                        ; преобразуем результат ((Ly - Vy) * 16) в 16-битное число
                        LD L, A
                        SBC A, A
                        LD H, A
                        ; offset_y = (Ly - Vy) * 16 + (Sy - SOy + Oy + 8)
                        ADC HL, BC                                  ; необходим для определения знака (16-битного числа)
                        ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                        ; - если больше или равно 192, спрайт ниже экрана (не видим)
                        JP M, .NextUnit                             ; offset_y - значение отрицательное
                        JP Z, .NextUnit                             ; offset_x - значение нулевое
                        ; расчитаем верхнюю часть спрайта
                        ; offset_y -= SOy
                        LD A, L                                     ; L - хранит номер нижней линии спрайта
                        SUB E
                        JP C, .CroppedAtTop                         ; урезан верхней частью экрана
                        ADD A, #40
                        JP C, .NextUnit                             ; если переполнение, то верхняя линия спрайта больше или равно 192
                                                                    ; спрайт ниже экрана
                        NEG                                         ; А - хранит количество рисуемых строк
                        SUB E
                        JP C, .CroppedAtBottom                      ; урезан нижней частью экрана
                        ; рисуется полностью ёё
                        LD A, E
                        LD (.OffsetRow), A
                        JP .Row

.CroppedAtTop           ; урезан верхней частью экрана
                        NEG                                         ; А - хранит количество пропускаемых строк
                        SRL E
                        SRL E
                        SRL E
                        DEC E
                        LD D, A
.Multiply_Sy__Skip_y    ADD A, D
                        DEC E
                        JR NZ, .Multiply_Sy__Skip_y
                        ADD A, A                                    ; x2 т.к. OR & XOR
                        LD (.OffsetSprite), A                       ; сохраним количество пропускаемых строк
                        LD A, L                                     ; L - хранит номер нижней линии спрайта == количество рисуемых строк
                        ; DEC A       ; ? т.к. первый JP (HL) выполняется!
                        LD (.OffsetRow), A                          ; сохраним количество рисуемых строк
                        JP .Row

.CroppedAtBottom        ; урезан нижней частью экрана
                        ADD A, E                                    ; А - хранит количество пропускаемых строк
                        LD (.OffsetRow), A

.Row                    ; ------------------------ горизонталь ------------------------
                        POP DE                                      ; D - горизонтальное смещение (SOx), E - ширина спрайта (Sx)
                        ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                        ; (Ox + 8)
                        LD A, (IY + FUnit.PixelOffset.X)            ; A = Ox
                        ADD A, #08                                  ; A += 8
                        ; (Sx - SOx)
                        ADD A, E                                    ; A += Sx
                        SUB D                                       ; A -= SOx
                        ; преобразуем резульат (Ox + 8 + Sx - SOx) в 16-битное число
                        LD C, A                                     ; C = Ox + 8 + Sx - SOx
                        SBC A, A                                    ; если было переполнение (отрицательное число), корректируем
                        LD B, A
                        ; (Lx - Vx)
                        LD HL, MemoryPage_5.TileMapOffset.X
                        LD A, (IY + FUnit.Location.X)               ; A = Lx
                        SUB (HL)                                    ; A = Lx - Vx
                        ; ToDo значение для вертикали должно лежать в пределах от -1 до 16 (16 тайлов + 2 левее и правее)
                        ADD A, A                                    ; A = (Lx - Vx) * 2
                        ADD A, A                                    ; A = (Lx - Vx) * 4
                        ADD A, A                                    ; A = (Lx - Vx) * 8
                        ; ADD A, A                                    ; A = (Lx - Vx) * 16
                        ; преобразуем результат ((Lx - Vx) * 16) в 16-битное число
                        LD L, A
                        SBC A, A
                        LD H, A
                        ADD HL, HL                                  ; HL = (Lx - Vx) * 16
                        ; offset_x = (Lx - Vx) * 16 + (Sx - SOx + Ox + 8)
                        OR A
                        ADC HL, BC                                  ; необходим для определения знака (16-битного числа)
                        ; - если отрицательное или равно нулю, спрайт левее экрана (не видим)
                        ; - если больше или равно 256, спрайт правее экрана (не видим)
                        JP M, .NextUnit                             ; offset_x - значение отрицательное
                        JP Z, .NextUnit                             ; offset_x - значение нулевое
                        ; offset_x -= SOx
                        XOR A
                        LD B, A
                        LD C, E
                        SBC HL, BC
                        JP C, .CroppedAtLeft                        ; урезан левой частью экрана
                        OR H
                        JP NZ, .NextUnit                            ; левая часть спрайта за правой частью экрана
                        LD A, L
                        NEG
                        SUB E
                        JP C, .CroppedAtRight                       ; урезан правой частью экрана
                        ; рисуется полностью ёё
                        
                        JP .Draw                       
                        ; ; offset_x -= SOx
                        ; LD A, L                                     ; L - хранит смещение от правого края спрайта
                        ; SUB E
                        ; JP C, .CroppedAtLeft                        ; урезан левой частью экрана
                        ; ; ADD A, #40
                        ; ; JP C, .NextUnit                             ; если переполнение, то верхняя линия спрайта больше или равно 192
                        ;                                             ; спрайт ниже экрана
                        ; NEG
                        ; SUB E
                        ; JP C, .CroppedAtRight                       ; урезан правой частью экрана
                        ; ; рисуется полностью ёё
                        
                        ; JP .Draw

.CroppedAtLeft          ; урезан левой частью экрана
                        LD A, L
                        ;
                        NEG
                        RRA
                        RRA
                        RRA
                        AND %00011111
                        ADD A, A    ; x2
                        ADD A, A    ; x4
                        ; смещение в таблице, если байт выравнен
                        LD C, A
                        LD A, L
                        AND %00000111
                        LD B, A
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
                        LD A, (HL)
                        LD IXL, A
                        INC HL
                        LD A, (HL)
                        LD IXH, A
                        EXX

                        LD A, B
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

                        JR .Draw
                        
.CroppedAtRight         ; урезан правой частью экрана


                        ; ------------------------ горизонталь ------------------------ 

.Draw                   ; установим страницу спрайта
                        POP AF                                      ; A - номер странички спрайта (F - dummy)
                        SeMemoryPage_A

                        ; модификация адреса спрайта
                        POP HL                                      ; HL - адрес спрайта
.OffsetSprite           EQU $+1
                        LD DE, #0000
                        ADD HL, DE
                        LD SP, HL

                        LD BC, #0000  ; буфер

                        EXX
                        LD BC, #4000 ; экран
                        EXX

                        ; двухпроходные вызовы
                        LD HL, .JumpsRows
                        LD A, #18
.OffsetRow              EQU $+1
                        SUB #00
                        LD E, A
                        RRA
                        JP NC, .EvenRows                            ; чётное количество строк
                        DEC E
                        ADD HL, DE
                        LD E, (IX - 2)
                        LD D, (IX - 1)
                        EX DE, HL
                        JP (HL)

.EvenRows               ADD HL, DE
.JumpsRows              rept 12
                        JP (IX)
                        endr

                        ; ToDo проверка прерывания
                        JP .NextUnit
                        


.ProcessedUnits         DB #02
                        ; горизонталь - длина спрайта
                        ; вертикаль - количество пропускаемых байт
                        ;                ---- shift ----
                        ;        8          16         24         --
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |    0     |    1     |    2     |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |    5     |    6     |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |    10    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;                ---- not shift ----
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |    12    |    13    |    14    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |    17    |    18    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |    22    |    --    |
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
