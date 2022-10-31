
                ifndef _UTILS_PROJECTILE_DRAW_
                define _UTILS_PROJECTILE_DRAW_
; -----------------------------------------
; отрисовка проджектайла
; In:
; Out:
; Corrupt:
; -----------------------------------------
Draw:           LD D, (IX + FProjectile.Location.Y)
                LD E, (IX + FProjectile.Location.X)

                LD L, D
                LD H, HIGH SCR_ADR_TABLE
                LD A, (HL)
                INC H
                LD D, (HL)
                INC H
                LD L, E
                OR (HL)
                LD E, A
                INC H
                LD A, D
                XOR #80
                LD D, A
                LD A, (DE)
                OR (HL)
                LD (DE), A

                RET

                endif ; ~_UTILS_PROJECTILE_DRAW_