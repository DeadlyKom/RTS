
                ifndef _UTILS_PROJECTILE_MOVE_
                define _UTILS_PROJECTILE_MOVE_
; -----------------------------------------
; перемещение проджектайла
; In:
;   IX - адрес обрабатываемого проджектайла
; Out:
; Corrupt:
; -----------------------------------------
Move:           DEC (IX + FProjectile.Counter)
                RET NZ

                LD A, (IX + FProjectile.Speed)
                ADD A, A                                                        ; проверка необходимости свапа осей
                JR NC, .SwapAxis

                SLA A
                LD (IX + FProjectile.Counter), A

.LoopX          ; получение позиции и смещения оси X
                LD HL, (IX + FProjectile.Location.X)
                LD DE, (IX + FProjectile.Direction.X)

                ; итерация к следующей позиции проджектайла по оси X
                ADD HL, DE
                LD (IX + FProjectile.Location.X), HL

                ; расчёт необходимости смещения по оси Y
                LD HL, (IX + FProjectile.Error)
                LD DE, (IX + FProjectile.Delta)
                OR A
                SBC HL, DE
                LD (IX + FProjectile.Error), HL
                RET NC

                ; необходимо сместить по оси Y
                LD DE, (IX + FProjectile.DeltaError)
                ADD HL, DE
                LD (IX + FProjectile.Error), HL

                ; получение позиции и смещения оси Y
                LD HL, (IX + FProjectile.Location.Y)
                LD DE, (IX + FProjectile.Direction.Y)

                ; итерация к следующей позиции проджектайла по оси Y
                ADD HL, DE
                LD (IX + FProjectile.Location.Y), HL

                RET

.SwapAxis       RRA
                LD (IX + FProjectile.Counter), A

.LoopY          LD HL, (IX + FProjectile.Location.Y)
                LD DE, (IX + FProjectile.Direction.Y)

                ; итерация к следующей позиции проджектайла по оси Y
                ADD HL, DE
                LD (IX + FProjectile.Location.Y), HL

                ; расчёт необходимости смещения по оси X
                LD HL, (IX + FProjectile.Error)
                LD DE, (IX + FProjectile.Delta)
                OR A
                SBC HL, DE
                LD (IX + FProjectile.Error), HL
                RET NC

                ; необходимо сместить по оси X
                LD DE, (IX + FProjectile.DeltaError)
                ADD HL, DE
                LD (IX + FProjectile.Error), HL

                ; получение позиции и смещения оси X
                LD HL, (IX + FProjectile.Location.X)
                LD DE, (IX + FProjectile.Direction.X)

                ; итерация к следующей позиции проджектайла по оси X
                ADD HL, DE
                LD (IX + FProjectile.Location.X), HL

                RET

                endif ; ~_UTILS_PROJECTILE_MOVE_