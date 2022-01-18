
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
Idle:           ; LD A, (IX + FUnit.State)
                ; LD C, A
                ; AND FUSF_IS_IDLE
                CALL Utils.Unit.State.IsIDLE
                RET NZ                                                          ; сброс флага, выход если юнит не в состоянии idle

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
                OR A
                RET

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
