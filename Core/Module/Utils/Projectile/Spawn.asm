
                ifndef _UTILS_PROJECTILE_SPAWN_
                define _UTILS_PROJECTILE_SPAWN_
; -----------------------------------------
; спавн проджектайла 
; In:
;   HL  - начальная позиция проджектайла по оси х
;   DE  - начальная позиция проджектайла по оси y
;   HL' - конечная позиция проджектайла по оси x
;   DE' - конечная позиция проджектайла по оси y
;   B'  - скорость проджектайла
;   С'  - тип проджектайла (если необходимо)
; Out:
;   A   - количество проджектайлов в буфере
;   если флаг переполнения C установлен, заспавнить проджектайл не удалось
; Corrupt:
; -----------------------------------------
Spawn:          ; инициализация
                LD IX, PROJECTILES                                              ; адрес буфера

                ; проверка на возможность добавить проджектайл
                LD A, (Number)
                OR A
                JR Z, .BufferIsEmpty

                ; проверка на превышение максимального количества проджектайлов
                CP MAX_PROJECTILES
                JP Z, .BufferIsFull                                             ; буфер переполнен

.FindAddress    ; поиск свободного места в буфере
                LD BC, FProjectile

.Loop           ; если скорость равна 0, проджектайл неинициализированная/уничтожена
                EX AF, AF'                                                      ; сохраним количество проджектайлов в буфере
                LD A, (IX + FProjectile.Speed)
                OR A
                JR Z, .Spawn
                EX AF, AF'                                                      ; востановим количество проджектайлов в буфере
                DEC A
                ADD IX, BC
                JR NZ, .Loop

.Spawn          ; инициализировать проджектайл
                EX AF, AF'                                                      ; востановим количество проджектайлов в буфере

.BufferIsEmpty  ; буфер пуст
                LD (IX + FProjectile.Location.X), HL                            ; начальная позиция по оси x
                LD (IX + FProjectile.Location.Y), DE                            ; начальная позиция по оси y
                PUSH DE                                                         ; сохраним позицию по оси y
                PUSH HL                                                         ; сохраним позицию по оси x
                EXX                                                             ; переключение на значения конечной позиции проджектайла
                LD (IX + FProjectile.Type), C                                   ; тип проджектайла
                LD (IX + FProjectile.Speed), B                                  ; скорость проджектайла
                LD (IX + FProjectile.Counter), B                                ; установка счётчика скорость проджектайла

                ; расчёт дельты значений по оси x
                POP BC                                                          ; востановим позицию по оси x
                OR A
                SBC HL, BC
                LD A, #01
                JR NC, .PositiveX

                ; изменить знак HL
                LD A, H
                CPL
                LD H, A
                LD A, L
                CPL
                LD L, A
                INC HL

                LD A, #FF                                                       ; смещение по оси X -1

.PositiveX      ; конверсия dX в 16-ричный вид
                LD C, A
                RLA
                SBC A, A
                LD B, A
                LD (IX + FProjectile.Direction.X), BC

                ; расчёт дельты значений по оси y
                POP BC                                                          ; востановим позицию по оси x
                EX DE, HL
                OR A
                SBC HL, BC
                LD A, #01
                JR NC, .PositiveY

                ; изменить знак HL
                LD A, H
                CPL
                LD H, A
                LD A, L
                CPL
                LD L, A
                INC HL

                LD A, #FF                                                       ; смещение по оси Y -1

.PositiveY      ; конверсия dY в 16-ричный вид
                LD C, A
                RLA
                SBC A, A
                LD B, A
                LD (IX + FProjectile.Direction.Y), BC

                ; сравнение dX и dY
                RES SWAP_XY_BIT, (IX + FProjectile.Speed)                       ; сброс значение свапа в дефолтный
                OR A
                SBC HL, DE
                ADD HL, DE                                                      ; востановление dY
                JR C, .dX_More_dY                                               ; переход, если dX больше dY

                EX DE, HL                                                       ; меняем местави dX и dY
                SET SWAP_XY_BIT, (IX + FProjectile.Speed)                       ; установка необходимости свапа осей

.dX_More_dY     ; инициализация значений
                INC HL
                LD (IX + FProjectile.Delta), HL
                LD (IX + FProjectile.Error), DE
                INC DE
                LD (IX + FProjectile.DeltaError), DE

                ; увеличим счётчик пуль в буфере
                LD A, (Number)
                INC A
                LD (Number), A

                ; нормальный выход
                OR A
                RET

.BufferIsFull   ; ошибка спавна проджектайла
                SCF
                RET

                endif ; ~_UTILS_PROJECTILE_SPAWN_