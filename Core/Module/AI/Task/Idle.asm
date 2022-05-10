
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

                ; проведение разведки после остановки
                CALL Utils.Unit.Tilemap.Reconnaissance

                ; вызов счётчика анимации простоя
                CALL Animation.Idle

                ; успешное выполнение
                JP AI.SetBTS_SUCCESS

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
