
                ifndef _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
                define _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
; -----------------------------------------
; нанесение урона юниту
; In:
;   C  - значение урона
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Apply:          ;
                LD A, (IX + FUnit.Armor)
                SUB C
                JR NC, .SaveArmor

                ; NEG
                ; LD C, A
                LD A, (IX + FUnit.Health)
                SUB C
                JR C, .Died                                                     ; уничтожение юнита
                LD (IX + FUnit.Health), A

                LD A, #08

.SaveArmor      ; сохранение значение брони
                LD (IX + FUnit.Armor), A
                RET

.Died           ; юнит умер, выставляем флаг смерти
                JP Utils.Unit.State.SetDEAD

                endif ; ~ _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_