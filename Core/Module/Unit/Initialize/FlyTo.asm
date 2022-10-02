
                ifndef _CORE_MODULE_UNIT_FLY_TO_
                define _CORE_MODULE_UNIT_FLY_TO_
; -----------------------------------------
; перелёт юнита в назначенную точку
; In:
;   HL - начальная позици (H - y, L - x)
;   DE - конечная позиция (D - y, E - x)
;   A' - номер юнита
; Out:
;   IX - адрес юнита
; Corrupt:
;   IX
; Note:
; -----------------------------------------
FlyTo:          PUSH HL
                ; определение адреса юнита
                EX AF, AF'
                CALL Game.Unit.Utils.GetAddress
                POP HL
                
                UNIT_SetMoveTo (IX + FUnit.State)

                ; установка позиции юнита
                XOR A
                LD (IX + FUnit.Position.X.Low), A
                LD (IX + FUnit.Position.X.High), L
                LD (IX + FUnit.Position.Y.Low), A
                LD (IX + FUnit.Position.Y.High), H

                ; установка точки назначения
                LD (IX + FUnit.Target), DE

                ; установка позиции юнита (начальная)
                LD (IX + FUnit.Start), HL

                ; сброс анимации (номер фрейма полёта)
                LD (IX + FUnit.Animation), A
 
                RET

                display " - Unit Fly To : \t\t\t", /A, FlyTo, " = busy [ ", /D, $ - FlyTo, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_FLY_TO_
