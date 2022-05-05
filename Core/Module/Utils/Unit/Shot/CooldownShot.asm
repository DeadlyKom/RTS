
                ifndef _CORE_MODULE_UTILS_UNIT_COOLDOWN_SHOT_
                define _CORE_MODULE_UTILS_UNIT_COOLDOWN_SHOT_
; -----------------------------------------
; нанесение урона юниту
; In:
;   C  - значение урона
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Cooldown:       ; проверка перезарядки выстрела
                LD A, (IX + FUnit.CooldownShot)
                OR A
                RET Z
                DEC (IX + FUnit.CooldownShot)                                   ; декремент перезарядки
                SCF
                RET

                endif ; ~ _CORE_MODULE_UTILS_UNIT_COOLDOWN_SHOT_
