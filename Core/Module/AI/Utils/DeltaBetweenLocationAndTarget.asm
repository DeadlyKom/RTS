
                ifndef _CORE_MODULE_AI_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_
                define _CORE_MODULE_AI_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_

; -----------------------------------------
; In:
;   IX - pointer to FUnitTargets (3)
; Out:
;   IX - pointer to FUnitLocation (2)
;   DE - deltas (D - dY, E - dX)
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetDeltaTarget: ; get target location
                BIT FUTF_INDEX, (IX + FUnitTargets.Flags)
                LD L, (IX + FUnitTargets.Location.IDX_X)
                JR Z, .GetLocation
                LD H, (IX + FUnitTargets.Location.Y)
                JR $
                ; calculate direction delta
                DEC IXH                                     ; FUnitLocation (2)

                ; delta x
                LD A, H
                SUB (IX + FUnitLocation.TilePosition.X)
                LD E, A
                
                ; delta y
                LD A, L
                SUB (IX + FUnitLocation.TilePosition.Y)
                LD D, A
                
                RET

.GetLocation    ; calculate direction delta
                DEC IXH                                     ; FUnitLocation (2)
                LD A, (HighWayPointArrayRef)
                LD H, A

                ; delta x
                LD A, (HL)
                SUB (IX + FUnitLocation.TilePosition.X)
                JP NZ, .SkipX
                ADD A, (IX + FUnitLocation.OffsetByPixel.X)
                CPL
                JP .SetX
.SkipX          ADC A, A
                LD E, A
                LD A, (IX + FUnitLocation.OffsetByPixel.X)
                RLA
                LD A, E
                ADC A, A
.SetX           LD E, A
                
                INC H

                ; delta y
                LD A, (HL)
                SUB (IX + FUnitLocation.TilePosition.Y)
                JP NZ, .SkipY
                ADD A, (IX + FUnitLocation.OffsetByPixel.Y)
                CPL
                JP .SetY
.SkipY          ADC A, A
                LD D, A
                LD A, (IX + FUnitLocation.OffsetByPixel.Y)
                RLA
                LD A, D
                ADC A, A
.SetY           LD D, A


                RET

                endif ; ~ _CORE_MODULE_AI_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_