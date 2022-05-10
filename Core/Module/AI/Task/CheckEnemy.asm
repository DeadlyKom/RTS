
                ifndef _CORE_MODULE_AI_TASK_CHECK_ENEMY_
                define _CORE_MODULE_AI_TASK_CHECK_ENEMY_

; -----------------------------------------
; проверка врага в радиусе действия
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
CheckEnemy:     ; получим список ближайших юнитов
                CALL Utils.Visibility.GetListUnits
                JR NC, .None                                                    ; выход нет врагов поблизости

                ; радиус видимости

                ; получение адреса характеристик юнита
                LD HL, (UnitsCharRef)
                CALL Utils.Unit.GetAdrInTable
                PUSH HL
                POP IY
                LD A, (IY + FUnitCharacteristics.Distance)
                DEC A
                CALL Utils.Visibility.CheckRadiusA
                JR NC, .None

                ; DE - позиция ближайшего юнита из массива
                LD (IX + FUnit.Target), DE

                ; проведение разведки после остановки
                SET FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)                 ; необходимо произвести разведку
                CALL Utils.Unit.Tilemap.Reconnaissance

                ; установка флагов валидности значения Target
                LD A, (IX + FUnit.Data)
                OR FUTF_INSERT | FUTF_ENEMY                                     ; произведена временная вставка значения в Target и хранят позицию цели для атаки
                LD (IX + FUnit.Data), A

                JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

.None           CALL Utils.Unit.State.SetIDLE 
                JP AI.SetBTS_FAILURE                                            ; неудачное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 