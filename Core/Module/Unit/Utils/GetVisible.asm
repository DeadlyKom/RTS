
                ifndef _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
                define _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
; -----------------------------------------
; получить массив отсортированных юнитов по вертикали
; In:
;   DE - адрес буфера
; Out:
;   HL - адрес буфера
;   D  - размер массива
; Corrupt:
; Note:
; -----------------------------------------
GetVisible:     ; запрос на получение всех элементов в указанном чанке
                ;   A  - порядковый номер чанка [0..127]
                ;   HL - адрес массива чанков
                ;   DE - адрес буфера

                XOR A
                LD HL, Adr.Unit.UnitChank
                CALL ChunkArray.Request
                JR Z, $                                                         ; пустой массив

                ; инициализация конверсии
                PUSH DE
                EX DE, HL
                LD A, C
                LD B, C
                PUSH BC

.ConvertLoop    EX AF, AF'
                LD A, (DE)
                UNIT_Address B, C, FUnit.Position.Y << 3                        ; конверсия индекса юнита в адрес юнита (DE - с учётом смещения на FUnit.Position.Y)
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
                POP HL
                DEC C
                RET Z                                                           ; выход, если 1 элемент (B - количество элементов)

                ; инициализация
                PUSH HL
                LD (.ContainerSP), SP
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

.ContainerSP    EQU $+1
                LD SP, #0000
                POP HL
                LD D, B

                RET

                display " - Get Visible Units is Sorted : \t\t\t", /A, GetVisible, " = busy [ ", /D, $ - GetVisible, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
