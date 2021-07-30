
                    ifndef _CORE_MODULE_AI_TASK_IDLE_
                    define _CORE_MODULE_AI_TASK_IDLE_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Idle:               LD A, (IX + FUnitState.State)
                    LD C, A
                    AND FUSF_IS_IDLE
                    RET NZ                                                          ; сброс флага, выход если юнит не в состоянии idle

                    ; проверка бита об проведённой разведки после остановки
                    BIT FUSE_RECONNAISSANCE_BIT, C
                    JR Z, .SkipReconnaissance

                    INC IXH                                                         ; FUnitLocation     (2)
                    
                    LD HL, Utils.Tilemap.Radius_5
                    CALL Utils.Tilemap.Reconnaissance

                    DEC IXH                                                         ; FUnitState        (1)

                    RES FUSE_RECONNAISSANCE_BIT, (IX + FUnitState.State)            ; сброс флага разведки

.SkipReconnaissance ;
                    CALL Animation.Idle

                    OR A
                    RET

                    endif ; ~_CORE_MODULE_AI_TASK_IDLE_
