
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
CheckEnemy:     OR A
                RET

                ; получим список юдижайших юнитов
                CALL Utils.Visibility.GetListUnits
                RET NC                                                          ; выход нет врагов поблизости

                LD A, 5 * 5                                                     ; радиус видимости
                CALL Utils.Visibility.CheckRadius
                RET NC

                ; DE - позиция ближайшего юнита из массива
                LD (IX + FUnit.Target), DE
                ; указан новый WayPoint
                SET FUTF_INSERT_BIT, (IX + FUnit.Data)                          ; бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
                SET FUTF_ENEMY_WP_BIT, (IX + FUnit.Data)                        ; бит отвечающий что значения Way Point хранят позицию цели для атаки

                SCF
                RET

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 