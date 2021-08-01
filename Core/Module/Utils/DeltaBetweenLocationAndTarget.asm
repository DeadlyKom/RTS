
                    ifndef _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
                    define _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
; -----------------------------------------
; In:
;   IX - pointer to FUnitTargets (3)
; Out:
;   IX - pointer to FUnitLocation (2)
;   DE - deltas (D - dY, E - dX)
;   flag Carry true, говорит об успешности расчёта дельт
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
; GetDeltaTarget:     BIT FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)
;                     JR Z, .IsNotValid                                                       ; текущий Way Point не валидный

;                     LD A, (IX + FUnitTargets.WayPoint.Y)
;                     EX AF, AF'
;                     LD A, (IX + FUnitTargets.WayPoint.X)

;                     DEC IXH                                                                 ; FUnitLocation (2)

;                     LD C, #00                                                               ; С = 0 (нет необходимости выравнивать), 
;                                                                                             ; С = 1 (нужно привести к одной точности)
;                     ; delta x = FUnitTargets.WayPoint.X - FUnitLocation.TilePosition.X
;                     SUB (IX + FUnitLocation.TilePosition.X)
;                     JP NZ, .SetX
;                     ; увеличение точности X
;                     ADD A, (IX + FUnitLocation.OffsetByPixel.X)
;                     CPL
;                     INC C                                                                   ; X = более точный, Y нужно будет увеличить точность (Y << 3)
; .SetX               LD E, A

;                     ; delta y = FUnitTargets.WayPoint.Y - FUnitLocation.TilePosition.Y
;                     EX AF, AF'
;                     SUB (IX + FUnitLocation.TilePosition.Y)
;                     JP NZ, .IsImprovedAccuracy                                              ; Y имеет грубую точность, нужно проверить на необходимость увеличения точности
;                     ; увеличение точности Y
;                     ADD A, (IX + FUnitLocation.OffsetByPixel.Y)
;                     CPL
;                     LD D, A

;                     ; проверка на необходимость увеличения точности X,
;                     ; т.к. Y имеет более высокую точность
;                     DEC C                                                                   ; если С = 1, значит X имеет высокую точность, и не требуется его улучшение
;                     JR Z, .Successfully                                                     ; X и Y одинаковой точности (точная)
                    
;                     ; увеличение точности X
;                     LD A, E
;                     ADD A, A
;                     ADD A, A
;                     ADD A, A
;                     LD E, A
;                     JR .Successfully
                
; .IsImprovedAccuracy ; проверка на необходимость увеличения точности Y,
;                     ; т.к. X имеет более высокую точность
;                     DEC C                                                                   ; если С = 1, значит X имеет высокую точность, и Y необходимо увеличить точность
;                     JR NZ, .SetY                                                            ; X и Y одинаковой точности (грубая)

;                     ; увеличение точности Y
;                     ADD A, A
;                     ADD A, A
;                     ADD A, A
; .SetY               LD D, A

; .Successfully       SCF                                                                     ; успешность операции
;                     RET

; .IsNotValid         XOR A                                                                   ; неудача операции
;                     LD D, A
;                     LD E, A
;                     DEC IXH                                                                 ; FUnitLocation (2)
;                     RET

; -----------------------------------------
; In:
;   IX - pointer to FUnitTargets    (3)
;   DE - позиция точки назначения (D - y, E - x)
; Out:
;   IX - pointer to FUnitTargets    (3)
;   DE - deltas (D - dY, E - dX)
; Corrupt:`
;   DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetFastDeltaTarget:     DEC IXH                                     ; FUnitLocation (2)

                        ; delta x = X - FUnitLocation.TilePosition.X
                        LD A, E
                        SUB (IX + FUnitLocation.TilePosition.X)
                        JP NZ, .SetX
                        ADD A, (IX + FUnitLocation.OffsetByPixel.X)
                        CPL
                        SRA A
                        SRA A
                        SRA A
                        SRA A
.SetX                   LD E, A

                        ; delta y = Y - FUnitLocation.TilePosition.Y
                        LD A, D
                        SUB (IX + FUnitLocation.TilePosition.Y)
                        JP NZ, .SetY
                        ADD A, (IX + FUnitLocation.OffsetByPixel.Y)
                        CPL
                        SRA A
                        SRA A
                        SRA A
                        SRA A
.SetY                   LD D, A

                        INC IXH                                     ; FUnitTargets  (3)

                        RET

; -----------------------------------------
; get the perfect delta to target
; In:
;   IX - pointer to FUnitTargets (3)
;   DE - позиция точки назначения (D - y, E - x)
; Out:
;   IX - pointer to FUnitLocation (2)
;   DE - deltas (D - dY, E - dX)
;   flag Carry true, говорит об успешности расчёта дельт
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetPerfectTargetDelta:  DEC IXH                                                                 ; FUnitLocation (2)

                        ; delta x = (X - FUnitLocation.TilePosition.X) * 16 + 8 + FUnitLocation.OffsetByPixel.X
                        LD A, E
                        SUB (IX + FUnitLocation.TilePosition.X)
                        LD L, A
                        SBC A, A
                        LD H, A
                        ADD HL, HL
                        ; INC HL
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        LD A, (IX + FUnitLocation.OffsetByPixel.X)
                        CPL
                        LD C, A
                        RLA
                        SBC A, A
                        LD B, A
                        ADD HL, BC

                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL


                        LD A, D
                        EX DE, HL

                        ; delta y = (Y - FUnitLocation.TilePosition.Y) * 16 + 8 + FUnitLocation.OffsetByPixel.Y
                        SUB (IX + FUnitLocation.TilePosition.Y)
                        LD L, A
                        SBC A, A
                        LD H, A
                        ADD HL, HL
                        ; INC HL
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        LD A, (IX + FUnitLocation.OffsetByPixel.Y)
                        CPL
                        LD C, A
                        RLA
                        SBC A, A
                        LD B, A
                        ADD HL, BC

                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL

                        PUSH HL
                        PUSH DE

                        EXX
                        
                        POP HL
                        BIT 7, H
                        JR Z, $+9
                        EX DE, HL
                        LD HL, #0000
                        OR A
                        SBC HL, DE

                        EX DE, HL
                        POP BC

                        BIT 7, B
                        JR Z, $+10
                        LD HL, #0000
                        OR A
                        SBC HL, BC
                        LD B, H
                        LD C, L

                        LD A, B
                        OR D
                        EX AF, AF'
                        LD A, C
                        OR E
                        EXX

                        LD C, A
                        EX AF, AF'
                        RL C
                        ADC A, A

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY

                        RL C
                        ADC A, A
                        JR C, .L1
                        ADD HL, HL              ; HL = dY
                        EX DE, HL
                        ADD HL, HL              ; HL = dX

                        RL C
                        ADC A, A
                        JR C, .L2
                        ADD HL, HL              ; HL = dX
                        EX DE, HL
                        ADD HL, HL              ; HL = dY


.L1                     ; HL = dY
                        ; DE = dX
                        LD E, D
                        LD D, H

                        SCF                                                                     ; успешность операции
                        RET

.L2                     ; HL = dX
                        ; DE = dY
                        LD E, H
                        ; LD D, D

                        SCF                                                                     ; успешность операции
                        RET                   


; .Successfully       SCF                                                                     ; успешность операции
;                     RET

                    endif ; ~ _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
