
                ifndef _CORE_MODULE_AI_TASK_CHECK_ENEMY_
                define _CORE_MODULE_AI_TASK_CHECK_ENEMY_

; -----------------------------------------
; проверка врага в радиусе действия
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
CheckEnemy:     ;OR A
                ;RET
                ; JR$

                ; получим список юдижайших юнитов
                CALL Utils.Visibility.GetListUnits
                RET NC                                                          ; выход нет врагов поблизости

                LD A, 5 * 5                                                     ; радиус видимости
                CALL Utils.Visibility.CheckRadius
                RET NC

                ; DE - позиция ближайшего юнита из массива
                LD (IX + FUnit.Target), DE
                
                ; установка флагов валидности значения Target
                LD A, (IX + FUnit.Data)
                OR FUTF_INSERT | FUTF_ENEMY                                     ; произведена временная вставка значения в Target и хранят позицию цели для атаки
                LD (IX + FUnit.Data), A

                SCF
                RET

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 