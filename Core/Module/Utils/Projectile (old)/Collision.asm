
                ifndef _UTILS_PROJECTILE_COLLISION_
                define _UTILS_PROJECTILE_COLLISION_
; -----------------------------------------
; коллисзия проджектайла (пока с границами экрана)
; In:
;   IX - адрес обрабатываемого проджектайла
; Out:
; Corrupt:
; -----------------------------------------
Collision:      ; проверка коллизий с краями экрана по оси Х
                LD HL, (IX + FProjectile.Location.X)
                LD A, H
                OR L
                JP Z, Destroy
                LD DE, SCREEN_RECT_X - 1
                OR A
                SBC HL, DE
                JP NC, Destroy

                ; проверка коллизий с краями экрана по оси Y
                LD HL, (IX + FProjectile.Location.Y)
                LD A, H
                OR L
                JP Z, Destroy
                LD DE, SCREEN_RECT_Y - 1
                OR A
                SBC HL, DE
                JP NC, Destroy

                RET

                endif ; ~_UTILS_PROJECTILE_COLLISION_