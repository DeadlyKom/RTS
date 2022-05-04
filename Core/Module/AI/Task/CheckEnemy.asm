
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
CheckEnemy:     ; получим список ближайших юнитов
                CALL Utils.Visibility.GetListUnits
                JR NC, .None                                                    ; выход нет врагов поблизости

                LD A, 5 * 5                                                     ; радиус видимости
                CALL Utils.Visibility.CheckRadius
                JR NC, .None

                ; DE - позиция ближайшего юнита из массива
                LD (IX + FUnit.Target), DE
                
                ; установка флагов валидности значения Target
                LD A, (IX + FUnit.Data)
                OR FUTF_INSERT | FUTF_ENEMY                                     ; произведена временная вставка значения в Target и хранят позицию цели для атаки
                LD (IX + FUnit.Data), A

                JP AI.SetBTS_SUCCESS

.None           CALL Utils.Unit.State.SetIDLE 
                JP AI.SetBTS_FAILURE

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 