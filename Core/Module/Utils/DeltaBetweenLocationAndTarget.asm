
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
GetDeltaTarget: BIT FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)
                JR Z, .IsNotValid                           ; текущий Way Point не валидный

                LD A, (IX + FUnitTargets.WayPoint.Y)
                EX AF, AF'
                LD A, (IX + FUnitTargets.WayPoint.X)

                DEC IXH                                     ; FUnitLocation (2)

                ; delta x = FUnitTargets.WayPoint.X - FUnitLocation.TilePosition.X
                SUB (IX + FUnitLocation.TilePosition.X)
                JP NZ, .SkipX
                ADD A, (IX + FUnitLocation.OffsetByPixel.X)
                CPL
                ; JP .SetX
.SkipX          ; ADC A, A

                ; --------
                ; LD E, A
                ; LD A, (IX + FUnitLocation.OffsetByPixel.X)
                ; RLA
                ; LD A, E
                ; ADC A, A
                ; --------

.SetX           LD E, A

                ; delta y = FUnitTargets.WayPoint.Y - FUnitLocation.TilePosition.Y
                EX AF, AF'
                SUB (IX + FUnitLocation.TilePosition.Y)
                JP NZ, .SkipY
                ADD A, (IX + FUnitLocation.OffsetByPixel.Y)
                CPL
                ; JP .SetY
.SkipY          ; ADC A, A

                ; --------
                ; LD D, A
                ; LD A, (IX + FUnitLocation.OffsetByPixel.Y)
                ; RLA
                ; LD A, D
                ; ADC A, A
                ; --------
                
.SetY           LD D, A
                SCF                                         ; успешность операции

                RET

.IsNotValid     XOR A                                       ; неудача операции
                LD D, A
                LD E, A
                DEC IXH                                     ; FUnitLocation (2)
                
                RET
                ; delta x = (FUnitTargets.WayPoint.X - FUnitLocation.TilePosition.X) * 16 + 8 + FUnitLocation.OffsetByPixel.X
                ; delta y = (FUnitTargets.WayPoint.Y - FUnitLocation.TilePosition.Y) * 16 + 8 + FUnitLocation.OffsetByPixel.Y
                ; LD L, (IX + FUnitTargets.WayPoint + 0)
                ; LD H, (IX + FUnitTargets.WayPoint + 1)
                ; LD C, (IX + FUnitLocation.TilePosition + 0)
                ; LD B, (IX + FUnitLocation.TilePosition + 1)
                ; OR A
                ; SBC HL, DE
                ; ADD HL, HL
                ; ADD HL, HL
                ; ADD HL, HL
                ; ADD HL, HL
                ; LD E, H

                endif ; ~ _CORE_MODULE_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_