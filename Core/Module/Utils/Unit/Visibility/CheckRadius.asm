
                ifndef _CORE_MODULE_UTILS_CHECK_RADIUS_
                define _CORE_MODULE_UTILS_CHECK_RADIUS_

                module Visibility

CheckRadiusA:   LD HL, CheckRadius.TableSquares
                ADD A, L
                LD L, A
                LD A, (HL)
; -----------------------------------------
; проверка видимости юнитов из списка
; In:
;   A         - радиус видимости в квадрате
;   IX        - указывает на структуру FUnit относительно кого проверяется массив
;   .SizeList - размер списка проверяемых позиций
; Out:
;   DE - позиция ближайшего юнита из массива
;   если флаг переполнения C установлен, DE хранит позицию ближайщего юнита,
;   иначе, такого не нашлось
; Corrupt:
; Note:
; -----------------------------------------
CheckRadius:    ; инициализация
                LD (.DistSquared), A                                            ; сохранение максимальной дистанции
                LD A, #FF
                LD (.BestDistance), A                                           ; установка максимальной дистанции
                LD A, #B7
                LD (.Flag), A                                                   ; установка OR A, как неудача поиска
                LD HL, .TableSquares                                            ; H  - старший байт таблицы квадратов
                LD DE, SharedBuffer                                             ; DE - указывает на список проверяемых юнитов (X, Y)
                LD C, (IX + FUnit.Position.X)
                LD B, (IX + FUnit.Position.Y)

.NextElement    LD L, LOW .TableSquares                                         ; L - младший байт таблицы квадратов

                ; DeltaX
                LD A, (DE)
                SUB C
                JP P, $+5
                NEG

                CP #10                                                          ; в таблице нет значения 16 и более
                JR NC, .More                                                    ; переход, если дистанция очень большая (результат больше байта)

                ; SquaredX = DeltaX * DeltaX
                ADD A, L
                LD L, A
                LD A, (HL)
                EX AF, AF'                                                      ; сохраним результат SquaredX

                INC E                                                           ; переход к значению Y

                ; DeltaY
                LD A, (DE)
                SUB B
                JP P, $+5
                NEG

                LD L, LOW .TableSquares                                         ; L - младший байт таблицы квадратов

                ; SquaredY = DeltaX * DeltaX
                ADD A, L
                LD L, A
                LD L, (HL)
                EX AF, AF'                                                      ; востановим результат SquaredX
                ADD A, L
                JR C, .More                                                     ; переход, если дистанция очень большая (результат больше байта)
                LD L, A                                                         ; L - хранит значение SquaredX + SquaredY

                ; проверим если результат меньше или равно квадрат дистанции,
                ; найдена позиция (не обязательно это ближний)
.DistSquared    EQU $+1
                LD A, #00
                CP L
                JR C, .More                                                     ; переход, если дистанция больше требуемому

                ; проверим что это ближе предыдущих
                LD A, L
.BestDistance   EQU $+1
                CP #00
                JR NC, .More                                                    ; переход, если предыдущая дистанция больше или равен

                ; сохраним лучшую дистанцию
                LD (.BestDistance), A

                ; сохраним текущую позицию цели
                LD A, (DE)
                LD (.BestPosition+1), A
                DEC E
                LD A, (DE)
                LD (.BestPosition), A
                INC E

                ; установка SCF, как успешность поиска
                LD A, #37
                LD (.Flag), A

.More           INC E                                                           ; переход к следующему значению X, следующего юнита
.SizeList       EQU $+1
                LD A, #01                                                       ; размер списка юнитов
                DEC A
                LD (.SizeList), A
                JR NZ, .NextElement

.BestPosition   EQU $+1
                LD DE, #0000

                ; выход
.Flag           OR A
                RET

.TableSquares   ; таблицы квадратов
                DB 0 * 0                                                        ; 0
                DB 1 * 1                                                        ; 1
                DB 2 * 2                                                        ; 4
                DB 3 * 3                                                        ; 9
                DB 4 * 4                                                        ; 16
                DB 5 * 5                                                        ; 25
                DB 6 * 6                                                        ; 36
                DB 7 * 7                                                        ; 49
                DB 8 * 8                                                        ; 64
                DB 9 * 9                                                        ; 81
                DB 10 * 10                                                      ; 100
                DB 11 * 11                                                      ; 121
                DB 12 * 12                                                      ; 144
                DB 13 * 13                                                      ; 169
                DB 14 * 14                                                      ; 196
                DB 15 * 15                                                      ; 225

                if (CheckRadius.TableSquares >> 8) - ((CheckRadius.TableSquares + 16) >> 8)
                error "whole table must be within single 256 byte block"
                endif

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_CHECK_RADIUS_