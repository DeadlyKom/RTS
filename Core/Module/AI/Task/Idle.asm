
                ifndef _CORE_MODULE_AI_TASK_IDLE_
                define _CORE_MODULE_AI_TASK_IDLE_

; -----------------------------------------
; поведение - бездействие юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Idle:           CALL Utils.Unit.State.IsIDLE
                JP NZ, AI.SetBTS_FAILURE                                        ; сброс флага, выход если юнит не в состоянии idle

                ; проверка бита об проведённой разведки после остановки
                BIT FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)
                JR Z, .SkipRecon                                                ; пропустить разведку

                ; ---------------------------------------------
                ; HL - данные разведки (радиус)
                ; IX - указывает на FUnit
                ; ---------------------------------------------
                LD HL, Utils.Unit.Tilemap.Radius_5
                CALL Utils.Unit.Tilemap.Reconnaissance

                RES FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)                 ; сброс флага разведки

.SkipRecon      ; вызов счётчика анимации простоя
                CALL Animation.Idle

                ; успешное выполнение
                JP AI.SetBTS_SUCCESS

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
