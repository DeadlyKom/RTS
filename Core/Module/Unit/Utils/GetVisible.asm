
                ifndef _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
                define _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
; -----------------------------------------
; получить массив отсортированных юнитов по вертикали
; In:
;   DE - адрес буфера
; Out:
;   D  - размер массива
; Corrupt:
; Note:
; -----------------------------------------
GetVisible:     EXX
                
                ; инициализация
                LD HL, GameVar.TilemapOffset
                LD BC, #0202                                                    ; минимальный захватываемое окно в чанках
                LD E, (HL)                                                      ; X
                INC HL
                LD D, (HL)                                                      ; Y
                LD L, #00                                                       ; обнуление счётчика отсортированных элементов

                ; корректировка ширины захвата чанков, если не выровнено
                LD A, E
                AND ChunkArray.CHUNK_SIZE_MASK
                JR Z, $+3
                INC C

                ; корректировка высоты захвата чанков, если не выровнено
                LD A, D
                AND ChunkArray.CHUNK_SIZE_MASK
                JR Z, $+3
                INC B

                ; расчёт индекса чанка
                CALL ChunkArray.GetChunkIdx
                LD D, C                                                         ; сохранение ширины захвата чанкоми

.ColumnLoop     LD E, A                                                         ; сохранение номера чанка

                ; D   - ширина захвата чанков
                ; E   - номер чанка
                ; A   - номер чанка
                ; DE' - адрес буфера

                EXX                                                             ; скрытие
                LD HL, Adr.Unit.UnitChank | 0x80
                CALL ChunkArray.GetAdrUnits
                LD B, A

                ; HL - начальный адрес счётчиков юнитов в указанном чанке
                ; DE - адрес буфера
                ; B  - количествой пройденых элементов/начальный адрес расположения элементов
                ; A  - количествой пройденых элементов/начальный адрес расположения элементов

                EXX                                                             ; видимость
.RowLoop        EXX                                                             ; скрытие

                ;
                PUSH HL
                PUSH BC

                ; подготовка
                EXX
                LD A, L
                EXX
                LD C, A                                                         ; сохранение, общий размер элементов в массиве (ранее добавленных)
                LD A, (HL)                                                      ; количество добавляемых элементов
                LD L, B                                                         ; HL - начальный адрес расположения элементов в указанном чанке
                OR A
                CALL NZ, Sort                                                   ; сортировка

                ;
                POP BC
                POP HL

                ; приращение общего счётчика элементов в буфере сортировки
                LD A, (HL)                                                      ; количество элементов
                EXX
                ADD A, L
                LD L, A
                EXX

                ; следущий чанк
                LD A, (HL)
                INC L
                ADD A, B
                LD B, A
                
                EXX                                                             ; видимость 
                ;
                DEC C
                JR NZ, .RowLoop

                ; следующая строка
                LD A, E
                ADD A, 8

                ;
                LD C, D
                DJNZ .ColumnLoop

                LD D, L

                RET
Sort:           ; HL - начальный адрес расположения элементов в указанном чанке
                ; DE - адрес буфера
                ; B  - количествой пройденых элементов/начальный адрес расположения элементов
                ; С  - общий размер элементов в массиве (ранее добавленных)
                ; A  - количествой элементов

                ; инициализация конверсии
                PUSH DE
                EX DE, HL
                LD B, A                                                         ; сохранение, количество добавляемых элементов 
                PUSH BC

                ; копирование адресов в буфер (не отсортированные)
.ConvertLoop    EX AF, AF'
                LD A, (DE)
                UNIT_Address B, C, FUnit.Position.Y << 3                        ; конверсия индекса юнита в адрес юнита (BC - с учётом смещения на FUnit.Position.Y)
                LD (HL), C
                INC L
                LD (HL), B
                INC L
                INC E
                EX AF, AF'
                DEC A
                JR NZ, .ConvertLoop

                ; 
                POP BC
                POP DE

                ; прверка что массив увеличился и больше 1
                LD A, B
                ADD A, C
                DEC A
                EX DE, HL
                RET Z                                                           ; выход, если 1 элемент (B - количество элементов)
                EX DE, HL
                INC A
                LD B, A

                ; инициализация
                LD (.ContainerSP), SP
                EX DE, HL
                LD SP, HL
                LD C, #01
                LD A, #02
                EX AF, AF'

                ; s     = B  - размер массива
                ; i     = C  - текущий элемент
                ; j     = A' - следующий элемент
                ; a[]   = SP - указатель на массив
                ;
                ; while (i < s)
                ; {
                ;     if (a[i-1] <= a[i])
                ;     {
                ;         i=j;
                ;         j++;
                ;     }
                ;     else
                ;     {
                ;         ex a[i], a[i-1];
                ;         if (--i == 0)
                ;         {
                ;             i=j;
                ;             j++;
                ;         }
                ;     }
                ; }

.Loop           ; SP - [i-1]

                ; элемент [i-1]
                POP HL
                LD E, (HL)
                INC L
                LD D, (HL)

                ; элемент [i]
                POP HL
                PUSH HL
                LD A, (HL)
                INC L
                LD H, (HL)
                LD L, A

                ; проверка [i] >= [i-1]
                SBC HL, DE
                JR NC, .Next    ; i = j; j++

                ; меняем местами адреса
                DEC SP
                DEC SP
                POP HL
                EX (SP), HL
                PUSH HL

                ; i--; if (i == 0)
                DEC C
                JR NZ, .Loop

.Next           ; i = j, j++
                EX AF, AF'
                LD C, A
                INC A
                EX AF, AF'

                ; 
                INC SP
                INC SP

                ; i < size
                LD A, C
                CP B
                JR C, .Loop

                ; -1
                LD HL, -2
                ADD HL, SP
                EX DE, HL

.ContainerSP    EQU $+1
                LD SP, #0000

                RET

                display " - Get Visible Units is Sorted : \t\t\t", /A, GetVisible, " = busy [ ", /D, $ - GetVisible, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
