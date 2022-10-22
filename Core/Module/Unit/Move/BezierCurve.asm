
                ifndef _CORE_MODULE_UNIT_MOVE_BEZIER_CURVE_
                define _CORE_MODULE_UNIT_MOVE_BEZIER_CURVE_
; -----------------------------------------
; перемещение юнитов по кривой Безье
; In:
;    HL - указывает на переменную GameVar.FlyCountdown
; Out:
; Corrupt:
; Note:
; -----------------------------------------
BezierCurve:    ; установка обратного счётчика
                LD (HL), DURATION_FLY_ANIM

                LD B, 16
                LD IX, #C040
.L1             LD A, (IX + FUnit.Animation)
                SUB UNIT_ANIM_DOWN_DECREMENT
                LD (IX + FUnit.Animation), A
                LD DE, UNIT_SIZE
                ADD IX, DE
                DJNZ .L1

.L11            EQU $+1
                LD A, #09
                DEC A
                JR NZ, .L3
                LD B, 16
                LD IX, #C040
.L2             LD A, (IX + FUnit.Direction)
                ADD A, %00001000
                AND DF_DOWN_MASK
                LD (IX + FUnit.Direction), A
                LD DE, UNIT_SIZE
                ADD IX, DE
                DJNZ .L2
                LD A, #09
.L3             LD (.L11), A

.PlayerShuttle  ; -----------------------------------------
                ; шаттл игрока
                ; -----------------------------------------
                LD IX, PLAYER_SHUTTLE
                CALL .MoveShuttle

.EnemyShuttle   ; -----------------------------------------
                ; шаттл противника
                ; -----------------------------------------
                LD IXL, LOW ENEMY_SHUTTLE

.MoveShuttle    ; проверка что шаттл перемещается 
                UNIT_IsMove (IX + FUnit.State)
                RET Z                                                           ; выход, если шаттл не движется

                ; обновить положение шаттла
                CALL Game.Unit.Math.BezierCurve
                INC (IX + FUnit.Animation)
                RET NZ                                                          ; выход, если анимация не достигла завершения
                UNIT_ResMoveTo (IX + FUnit.State)

                ; установить конечную позицию 
                LD A, (IX + FUnit.Target.X)
                LD (IX + FUnit.Position.X.High), A
                LD A, (IX + FUnit.Target.Y)
                LD (IX + FUnit.Position.Y.High), A
                XOR A
                LD (IX + FUnit.Position.X.Low), A
                LD (IX + FUnit.Position.Y.Low), A

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                ;   A' - номер юнита
                
                LD H, (IX + FUnit.Position.Y.High)
                LD L, (IX + FUnit.Position.X.High)
                EXX
                CALL Math.Rand8
                EXX
                AND #07
                ADD A, 4
                LD D, A
                EXX
                CALL Math.Rand8
                EXX
                AND #07
                ADD A, 4
                LD E, A

                JP Functions.FlyToUnit

                display " - Moving units along a bezier curve : \t\t", /A, BezierCurve, " = busy [ ", /D, $ - BezierCurve, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_MOVE_BEZIER_CURVE_
