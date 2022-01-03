
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
Idle:           ;JR$
                LD A, (IX + FUnit.State)
                LD C, A
                AND FUSF_IS_IDLE
                RET NZ                                                          ; сброс флага, выход если юнит не в состоянии idle

                ; проверка бита об проведённой разведки после остановки
                BIT FUSE_RECONNAISSANCE_BIT, C
                JR Z, .SkipRecon                                                ; пропустить разведку

                ; ---------------------------------------------
                ; HL - данные разведки (радиус)
                ; IX - указывает на FUnit
                ; ---------------------------------------------
                LD HL, Utils.Tilemap.Radius_5
                CALL Utils.Tilemap.Reconnaissance

                RES FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)                 ; сброс флага разведки

.SkipRecon      ; вызов счётчика анимации простоя
                CALL Animation.Idle

                ; успешное выполнение
                OR A
                RET

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
