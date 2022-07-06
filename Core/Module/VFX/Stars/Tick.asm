
                ifndef _CORE_MODULE_VFX_STARS_TICK_
                define _CORE_MODULE_VFX_STARS_TICK_
; -----------------------------------------
; тик звёзд
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Tick:           CALL Update

                LD A, (TickCounterRef)
                AND #0F
                RET NZ

                ; увеличение здёзд на экране
                LD A, (StarCounter)
                CP StarsMax
                CALL C, Add

                RET

                endif ; ~ _CORE_MODULE_VFX_STARS_TICK_
