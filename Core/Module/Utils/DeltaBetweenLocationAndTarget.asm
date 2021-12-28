
                        ifndef _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
                        define _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_

; -----------------------------------------
; In:
;   IX - pointer to FUnitTargets (3)
; Out:
;   IX - pointer to FSpriteLocation (2)
;   DE - deltas (D - dY, E - dX)
;   flag Carry true, говорит об успешности расчёта дельт
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetDeltaTarget:         BIT FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)
                        JR Z, .IsNotValid                           ; текущий Way Point не валидный

                        LD A, (IX + FUnitTargets.WayPoint.Y)
                        EX AF, AF'
                        LD A, (IX + FUnitTargets.WayPoint.X)

                        DEC IXH                                     ; FSpriteLocation (2)

                        LD C, #00                                                               ; С = 0 (нет необходимости выравнивать), 
                                                                                                ; С = 1 (нужно привести к одной точности)
                        ; delta x = FUnitTargets.WayPoint.X - FSpriteLocation.TilePosition.X
                        SUB (IX + FSpriteLocation.TilePosition.X)
                        JP NZ, .SetX
                        ; увеличение точности X
                        ADD A, (IX + FSpriteLocation.OffsetByPixel.X)
                        CPL
                        INC C                                                                   ; X = более точный, Y нужно будет увеличить точность (Y << 3)
.SetX                   LD E, A

                        ; delta y = FUnitTargets.WayPoint.Y - FSpriteLocation.TilePosition.Y
                        EX AF, AF'
                        SUB (IX + FSpriteLocation.TilePosition.Y)
                        JP NZ, .IsImprovedAccuracy                                              ; Y имеет грубую точность, нужно проверить на необходимость увеличения точности
                        ; увеличение точности Y
                        ADD A, (IX + FSpriteLocation.OffsetByPixel.Y)
                        CPL
                        LD D, A

                        ; проверка на необходимость увеличения точности X,
                        ; т.к. Y имеет более высокую точность
                        DEC C                                                                   ; если С = 1, значит X имеет высокую точность, и не требуется его улучшение
                        JR Z, .Successfully                                                     ; X и Y одинаковой точности (точная)
                        
                        ; увеличение точности X
                        LD A, E
                        ADD A, A
                        ADD A, A
                        ADD A, A
                        LD E, A
                        JR .Successfully
                
.IsImprovedAccuracy     ; проверка на необходимость увеличения точности Y,
                        ; т.к. X имеет более высокую точность
                        DEC C                                                                   ; если С = 1, значит X имеет высокую точность, и Y необходимо увеличить точность
                        JR NZ, .SetY                                                            ; X и Y одинаковой точности (грубая)

                        ; увеличение точности Y
                        ADD A, A
                        ADD A, A
                        ADD A, A
.SetY                   LD D, A

.Successfully           SCF                                                     ; успешность операции
                        RET

.IsNotValid             XOR A                                                   ; неудача операции
                        LD D, A
                        LD E, A
                        DEC IXH                                                 ; FSpriteLocation (2)
                        RET

; -----------------------------------------
; get the perfect delta to target
; In:
;   IX - pointer to FUnitTargets    (3)
; Out:
;   IX - pointer to FSpriteLocation (2)
;   DE - deltas (D - dY, E - dX)
;   flag Carry true, говорит об успешности расчёта дельт
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetPerfectTargetDelta:  BIT FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)
                        JR Z, GetDeltaTarget.IsNotValid                                         ; текущий Way Point не валидный

                        LD A, (IX + FUnitTargets.WayPoint.Y)
                        EX AF, AF'
                        LD A, (IX + FUnitTargets.WayPoint.X)

                        DEC IXH                                                                 ; FSpriteLocation (2)

                        ; delta x = (X - FSpriteLocation.TilePosition.X) * 16 - FSpriteLocation.OffsetByPixel.X
                        SUB (IX + FSpriteLocation.TilePosition.X)
                        LD L, A
                        SBC A, A
                        LD H, A
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        LD A, (IX + FSpriteLocation.OffsetByPixel.X)
                        CPL
                        LD C, A
                        ADD A, A
                        SBC A, A
                        LD B, A
                        ADD HL, BC

                        EX DE, HL
                        EX AF, AF'

                        ; delta y = (Y - FSpriteLocation.TilePosition.Y) * 16 - FSpriteLocation.OffsetByPixel.Y
                        SUB (IX + FSpriteLocation.TilePosition.Y)
                        LD L, A
                        SBC A, A
                        LD H, A
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        ADD HL, HL
                        LD A, (IX + FSpriteLocation.OffsetByPixel.Y)
                        CPL
                        LD C, A
                        ADD A, A
                        SBC A, A
                        LD B, A
                        ADD HL, BC

                        ; нормализация значений

.Normalize              LD A, H
                        OR A
                        JR Z, .NormalizeDE
                        INC A
                        JR Z, .NormalizeDE

                        SRA H
                        RR L

                        SRA D
                        RR E
                        JP .Normalize

.NormalizeDE            LD A, D
                        OR A
                        JR Z, .Finalize
                        INC A
                        JR Z, .Finalize

                        SRA H
                        RR L

                        SRA D
                        RR E
                        JP .NormalizeDE

.Finalize               SRA H
                        RR L

                        SRA D
                        RR E

                        LD D, L
                        
                        SCF                                                                     ; успешность операции
                        RET

                        endif ; ~ _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
