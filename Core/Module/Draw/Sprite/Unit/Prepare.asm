
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_

; -----------------------------------------
; подготовка спрайта перед выводм на экран
; In:
;   HL - адрес текущего спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        EX DE, HL
                
                ; инициализация
                LD HL, GameVar.TilemapOffset
                LD C, (HL)                                                      ; X
                INC HL
                LD B, (HL)                                                      ; Y
                
                EXX

.Clip           ; ---------------------------------------------
                ; вертикальный клипинг
                ; ---------------------------------------------
                ; DE' - изначальный/изменённый адрес спрайта
                ; ВС' - положение видимой области (B - y, C - x) в тайлах
                ; ---------------------------------------------

                ; размер спрайта (B - ширина, C - высота) в пикселях
.SpriteSize     EQU $+1
                LD BC, #0000

                ; -----------------------------------------
                ; расчёт положения спрайта по вертикали,
                ; относительно верхней границы видимой области
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                ; SOy = FCompositeSpriteInfo.Info.OffsetY << 4
.SOy            EQU $+1
                LD L, #00
                LD A, L
                ADD A, A
                SBC A, A
                LD H, A
                LD A, L
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; HL = SOy + FUnit.Position.Y
.PositionY      EQU $+1
                LD DE, #0000
                ADD HL, DE

                ; преобразование высоты спрайта в 16-битное число
                LD D, #00
                LD A, C
                ADD A, A
                ADD A, A
                ADD A, A
                RL D
                ADD A, A
                RL D
                LD E, A

                ; HL = SOy + FUnit.Position.Y - GameVar.TilemapOffset.Y
                LD A, H
                EXX
                SUB B                                                           ; GameVar.TilemapOffset.Y
                EXX
                LD H, A                                                         ; HL - хранит положение спрайта, относительно верхней границы видимой области
                JP P, .BelowTop                                                 ; переход, если спрайт находится ниже верхней границы видимой области

.AboveTop       ; ---------------------------------------------
                ; спрайт выше границы видимой области
                ; ---------------------------------------------

                ; добавить к относительному расположению спрайта по вертикали,
                ; относительно верхней границы видимой области размер спрайта
                OR A
                ADC HL, DE
                RET NC                                                          ; выход, если при добавлении размера спрайта по вертикали,
                                                                                ; не произошло переполнене. значение осталось отрицательным
                                                                                ; и спрайт полностью находится выше видимой области
                ; сброс флага переполнения (запрет отрисовки) и выход,
                ; если спрайт распологается на границе видимой области
                CCF
                RET Z

.ClipTop        ; ---------------------------------------------
                ; спрайт урезан верхней частью видимой области
                ; ---------------------------------------------
                ; HL  - хранит положение спрайта, относительно верхней границы видимой области
                ; DE  - 16-битное значение высоты спрайта
                ; BC  - изначальный размер спрайта (B - ширина, C - высота) в пикселях
                ; DE' - изначальный/изменённый адрес спрайта
                ; ВС' - положение видимой области (B - y, C - x) в тайлах
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL

                ; проверка нахождения спрайта выше верхней границы области видимости
                LD A, H
                OR A
                RET Z                                                           ; выход, если после отброски остатка,
                                                                                ; положение спрайта осталось выше верхней границы области видимости
                
                ; расчёт количество пропускаемых строк
                LD A, C
                SUB H
                LD C, H                                                         ; сохранение новой высоты спрайта
                LD H, A
                
                ; расчёт адреса в таблицы умножения
                LD A, B
                SUB #08                                                         ; начинается с 1
                ADD A, A
                ADD A, A
                DEC H                                                           ; начинается с 1
                XOR H
                AND %01100000
                XOR H

                ; результат:
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 0  | W1 | W0 | R4 | R3 | R2 | R1 | R0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   W1,W0   [6,5]   - ширина спрайта в знакоместах
                ;   R4-R0   [4..0]  - количество пропускаемых строк
                
                LD L, A
                LD H, HIGH Table.MultiplySprite
                LD A, (HL)

                ; корректировка размера пропускаемых данных спрайта,
                ; в зависимости от наличия маски у спрайта
                LD HL, GameFlags.SpriteFlagRef
                BIT CSIF_OR_XOR_BIT, (HL)
                JR Z, $+3
                ADD A, A

                EXX
                ; корректировка начального адреса спрайта
                ADD A, E
                LD E, A
                ADC A, D
                SUB E
                LD D, A

                ; адрес экранной области
                LD HL, Adr.Screens
                EXX

                JR .ClipRow

.ClipBottom     ; ---------------------------------------------
                ; спрайт урезан нижней частью видимой области
                ; ---------------------------------------------
                ; HL  - хранит положение спрайта, относительно нижней границы видимой области
                ; BC  - изначальный размер спрайта (B - ширина, C - высота) в пикселях
                ; DE' - изначальный/изменённый адрес спрайта
                ; ВС' - положение видимой области (B - y, C - x) в тайлах
                ; A   - положение спрайта, относительно верхней границы видимой области
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                POP AF                                                          ; сброс значения в стеке
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                
                ; корректировка высоты спрайта
                LD A, C
                SUB H
                LD C, A                                                         ; сохранение новой высоты спрайта

                ; положения верхней границы спрайта
                NEG
                ADD A, SCREEN_PIXEL_Y
                EX AF, AF'                                                      ; сохранение положение спрайта, относительно верхней границы видимой области

                ; проверка наличия маски у спрайта
                EXX
                ; проверяется только один флаг,
                ; флаг CSIF_OR_XOR_BIT обязателен при наличии CSIF_MASK_BIT
                LD HL, GameFlags.SpriteFlagRef
                BIT CSIF_MASK_BIT, (HL)
                EXX
                JR Z, .NotMask                                                  ; переход, если у спрайта отсутствует маска

                ; расчёт адреса в таблицы умножения
                LD A, B
                SUB #08                                                         ; начинается с 1
                ADD A, A
                ADD A, A
                DEC H                                                           ; начинается с 1
                XOR H
                AND %01100000
                XOR H

                ; результат:
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 0  | W1 | W0 | R4 | R3 | R2 | R1 | R0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   W1,W0   [6,5]   - ширина спрайта в знакоместах
                ;   R4-R0   [4..0]  - количество пропускаемых строк
                
                LD L, A
                LD H, HIGH Table.MultiplySprite
                LD A, (HL)
                EXX
                LD B, A                                                         ; сохранение результата, для копирования спрайта с общей маской
                EXX

.NotMask        EX AF, AF'                                                      ; восстановление положение спрайта, относительно верхней границы видимой области
                JR .ScrAdrRow

.BelowTop       ; ---------------------------------------------
                ; спрайт находится ниже верхней границы видимой области
                ; ---------------------------------------------
                ; HL  - хранит положение спрайта, относительно верхней границы видимой области
                ; DE  - 16-битное значение высоты спрайта
                ; BC  - размер спрайта (B - ширина, C - высота) в пикселях
                ; DE' - изначальный/изменённый адрес спрайта
                ; ВС' - положение видимой области (B - y, C - x) в тайлах
                ; ---------------------------------------------

                ; проверка нахождения спрайта ниже нижней границы видивой области
                ; LD A, H
                SUB SCREEN_TILE_Y
                RET NC                                                          ; выход, если результат положительный, т.к. спрайт находится
                                                                                ; ниже нижней границы видимой области

                ; проверка урезания спрайта нижней частью видимой областью
                PUSH HL                                                         ; сохранение положение спрайта, относительно верхней границы видимой области (в пикселях)
                LD H, A
                ADD HL, DE
                JR C, .ClipBottom                                               ; переход, если при добавлении размера спрайта по вертикали,
                                                                                ; произошло переполнене. значение положительное
                                                                                ; спрайт урезан нижней границей видивой области

                ; ---------------------------------------------
                ; спрайт полностью виден
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                POP HL                                                          ; восстановление положение спрайта, относительно верхней границы видимой области (в пикселях)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H

.ScrAdrRow      ; расчёт адреса строки в экранной области
                EXX
                LD H, HIGH Table.ScreenAddress
                LD L, A
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A
                EXX

.ClipRow        ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; HL' - адрес экрана вывода
                ; DE' - изначальный/изменённый адрес спрайта
                ; B'  - количество пропускаемых байт, для спрайтов с общей маской
                ; С'  - положение видимой области по горизонтали в тайлах
                ; ---------------------------------------------

                ; -----------------------------------------
                ; расчёт положения спрайта по горизонтали,
                ; относительно левой границы видимой области
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                ; SOx = FCompositeSpriteInfo.Info.OffsetX << 4
.SOx            EQU $+1
                LD L, #00
                LD A, L
                ADD A, A
                SBC A, A
                LD H, A
                LD A, L
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; HL = SOx + FUnit.Position.X
.PositionX      EQU $+1
                LD DE, #0000
                ADD HL, DE

                ; преобразование ширины спрайта в 16-битное число
                LD D, #00
                LD A, B
                ADD A, A
                ADD A, A
                ADD A, A
                RL D
                ADD A, A
                RL D
                LD E, A

                ; HL = SOx + FUnit.Position.X - GameVar.TilemapOffset.X
                LD A, H
                EXX
                SUB C                                                           ; GameVar.TilemapOffset.X
                LD C, B                                                         ; копирование значение, для спрайтов с общей маской
                EXX
                LD H, A                                                         ; HL - положение правой границы спрайта относительно левой границы видимой области
                JP P, .ToRightOfEdge                                            ; переход, если спрайт находится правее левой границы видимой области

.ToLeftOfEdge   ; ---------------------------------------------
                ; спрайт левее границы видимой области
                ; ---------------------------------------------
                ; HL  - положение правой границы спрайта относительно левой границы видимой области
                ; DE  - 16-битное значение ширины спрайта
                ; ---------------------------------------------

                ; добавить к относительному расположению спрайта по горизонтали,
                ; относительно левой границы видимой области размер спрайта
                OR A
                ADC HL, DE
                RET NC                                                          ; выход, если при добавлении размера спрайта по горизонтали,
                                                                                ; не произошло переполнене. значение осталось отрицательным
                                                                                ; и спрайт полностью находится левее видимой области
                ; сброс флага переполнения (запрет отрисовки) и выход,
                ; если спрайт распологается на границе видимой области
                CCF
                RET Z
.ClipLeft       ; ---------------------------------------------
                ; спрайт урезан левой частью видимой области
                ; ---------------------------------------------
                ; HL  - положение правой границы спрайта относительно левой границы видимой области
                ; DE  - 16-битное значение ширины спрайта
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; HL' - адрес экрана вывода
                ; DE' - изначальный/изменённый адрес спрайта
                ; B'  - количество пропускаемых байт, для спрайтов с общей маской
                ; С'  - количество пропускаемых байт, для спрайтов с общей маской
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ; H - позиция спрайта по горизонтали в пикселях

                ; проверка нахождения спрайта выше верхней границы области видимости
                LD A, H
                OR A
                RET Z                                                           ; выход, если после отброски остатка,
                                                                                ; положение спрайта осталось левее левой границы области видимости

                ; расчёт ширины невидимой части спрайта в пикселях
                LD A, B
                SUB H

                ; округление до знакоместа
                NEG
                SRA A
                SRA A
                SRA A
                LD L, A

                ; откинуть смещение знакомест
                LD A, H
                AND #07
                LD H, A

                JR .AdjustScrAdr

.ToRightOfEdge  ; ---------------------------------------------
                ; спрайт находится правее левой границы видимой области
                ; ---------------------------------------------
                ; HL  - хранит положение спрайта, относительно левой границы видимой области
                ; DE  - 16-битное значение ширины спрайта
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; HL' - адрес экрана вывода
                ; DE' - изначальный/изменённый адрес спрайта
                ; B'  - количество пропускаемых байт, для спрайтов с общей маской
                ; С'  - количество пропускаемых байт, для спрайтов с общей маской
                ; ---------------------------------------------

                ; проверка нахождения спрайта правее правой границы видивой области
                ; LD A, H
                SUB SCREEN_TILE_X
                RET NC                                                          ; выход, если результат положительный, т.к. спрайт находится
                                                                                ; правее правой границы видимой области

                ; проверка урезания спрайта правой частью видимой областью
                PUSH HL                                                         ; сохранение положение спрайта, относительно левой границы видимой области (в пикселях)
                LD H, A
                OR A
                ADC HL, DE
                POP HL                                                          ; восстановление положение спрайта, относительно левой границы видимой области (в пикселях)
                JR Z, .NoClip
                JR NC, .NoClip                                                  ; переход, если при добавлении размера спрайта по горизонтали,
                                                                                ; произошло переполнене. значение положительное
                                                                                ; спрайт урезан правой границей видивой области
.ClipRight      ; ---------------------------------------------
                ; спрайт урезан правой частью видимой области
                ; ---------------------------------------------
                ; HL  - хранит положение спрайта, относительно левой границы видимой области
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; HL' - адрес экрана вывода
                ; DE' - изначальный/изменённый адрес спрайта
                ; B'  - количество пропускаемых байт, для спрайтов с общей маской
                ; С'  - количество пропускаемых байт, для спрайтов с общей маской
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ; H -  позиции спрайта по горизонтали в пикселях

                ; расчёт ширины невидимой части спрайта в пикселях
                LD A, H
                DEC A
                CPL
                LD L, A
                LD A, B
                SUB L
                ; округление до знакоместа
                LD L, #00
                RRA
                ADC A, L
                RRA
                ADC A, L
                RRA
                ADC A, L
                LD L, A

                JR .AdjustScrAdr

.NoClip         ; ---------------------------------------------
                ; спрайт полностью виден
                ; ---------------------------------------------

                ; приведение позиции спрайта 12.4 к 8-битному (экранное значение)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD L, #00                                                       ; спрайт виден полностью
                
.AdjustScrAdr   ; ---------------------------------------------
                ; H   - позиция спрайта по горизонтали в пикселях
                ; L   - ширина невидимой части спрайта в знакоместах (-/+)
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; ---------------------------------------------

                ; корректировка адреса колонки в экранной области
                LD A, H
                RRA
                RRA
                RRA
                AND %00011111
                EXX
                OR L
                LD L, A
                EXX

                ; адрес таблицы спрайта без маски и без сдвига
                LD DE, Table.NoShift_LD-2
                
                ; расчёт адреса таблицы смещения
                LD A, H
                AND %00000111
                JR Z, .NotShift                                                 ; переход, если сдвиг отсутствует

                ; адрес таблицы спрайта без маски и сдвигом
                LD DE, Table.Shift_LD-2

                ; расчёт адреса таблицы, в зависимости от младших 3 бит
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH Table.Shift
                LD B, A
                EXX

.NotShift       ; ---------------------------------------------
                ; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
                ; L   - ширина невидимой части спрайта в знакоместах (-/+)
                ; HL' - адрес экрана вывода
                ; DE' - изначальный/изменённый адрес спрайта
                ; В'  - старший байт адреса таблицы сдвига
                ; С'  - количество пропускаемых байт, для спрайтов с общей маской
                ; ---------------------------------------------

                LD A, L
                ADD A, A
                ADD A, A

                ; выбор таблицы от типа спрайта
                LD HL, GameFlags.SpriteFlagRef
                BIT CSIF_OR_XOR_BIT, (HL)
                EX DE, HL
                LD D, #00
                JR Z, $+5
                LD E, #08
                ADD HL, DE

                LD E, A                                                         ; сохранение смещение в таблице    

                ; округление
                OR A
                LD A, B
                RRA
                ADC A, D
                RRA
                ADC A, D
                RRA
                ADC A, D
                ADD A, A

                ; приращение
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; чтение адреса таблицы переходов
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

                ; приведение к 16-битному значению
                LD A, E
                ADD A, A
                SBC A, A
                LD D, A
                ADD HL, DE

                ;
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL

                ;
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A
                INC HL

                SCF
                RET

Table:          ; таблица функций (горионталь, ширина спрайта в знакоместах)
.NoShift_LD     DW Table.NoShift.LD_8,  Table.NoShift.LD_16,    Table.NoShift.LD_24,    Table.NoShift.LD_32
.NoShift_OR_XOR DW Table.NoShift.OX_8,  Table.NoShift.OX_16,    Table.NoShift.OX_24,    Table.NoShift.OX_32
.Shift_LD       DW Table.Shift.LD_8,    Table.Shift.LD_16,      Table.Shift.LD_24,      Table.Shift.LD_32
.Shift_OR_XOR   DW Table.Shift.OX_8,    Table.Shift.OX_16,      Table.Shift.OX_24,      Table.Shift.OX_32

                display " - Prepare Sprite Unit : \t\t\t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_
