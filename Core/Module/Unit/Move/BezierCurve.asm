
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

.PlayerShuttle  ; -----------------------------------------
                ; шаттл игрока
                ; -----------------------------------------
                LD IX, PLAYER_SHUTTLE
                CALL .MoveShuttle

.EnemyShuttle   ; -----------------------------------------
                ; шаттл противника
                ; -----------------------------------------
                LD IXL, LOW ENEMY_SHUTTLE

.MoveShuttle     ; проверка что шаттл перемещается 
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

                RET

                display " - Moving units along a bezier curve : \t", /A, BezierCurve, " = busy [ ", /D, $ - BezierCurve, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_MOVE_BEZIER_CURVE_
