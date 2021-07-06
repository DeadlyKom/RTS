
                ifndef _CORE_MODULE_AI_BASE_
                define _CORE_MODULE_AI_BASE_
Tick:           LD HL, .AICounter                   ; внутрений счётчик (период между обновлениями кластеров юнитов)
                DEC (HL)
                RET NZ                              ; счётчик не обнулён (ожидаем)
                LD A, (AI_UpdateFrequencyRef)
                LD (HL), A
                
                ResetAIFlag AI_UPDATE_FLAG

                RET

.AICounter      DB AI_MAX_UPDATE_FREQ

                endif ; ~ _CORE_MODULE_AI_BASE_