
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
                ; LD A, (HL)
                ; SUB (IX + FUnitLocation.TilePosition.X)
                ; ADC A, A
                ; LD E, A
                ; LD A, (IX + FUnitLocation.OffsetByPixel.X)
                ; RLA
                ; LD A, E
                ; ADC A, A
                ; LD E, A

                ; JR $
                PUSH HL
                LD L, (IX + FUnitLocation.TilePosition.X)
                LD H, #00
                ADD HL, HL
                INC HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD E, (IX + FUnitLocation.OffsetByPixel.X)
                LD A, E
                RLA
                SBC A, A
                LD D, A
                ADD HL, DE
                EX DE, HL
                POP HL
                LD A, (HL)
                INC H
                PUSH HL
                LD H, (HL)
                LD L, A
                OR A
                SBC HL, DE

                LD A, L
                RR H
                RRA
                ; LD L, A
                LD (.ContainerX), A


                POP HL
                
                INC H

                ; delta y
                ; LD A, (HL)
                ; SUB (IX + FUnitLocation.TilePosition.Y)
                ; ADC A, A
                ; LD D, A
                ; LD A, (IX + FUnitLocation.OffsetByPixel.Y)
                ; RLA
                ; LD A, D
                ; ADC A, A
                ; LD D, A

                PUSH HL
                LD L, (IX + FUnitLocation.TilePosition.Y)
                LD H, #00
                ADD HL, HL
                INC HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD E, (IX + FUnitLocation.OffsetByPixel.Y)
                LD A, E
                RLA
                SBC A, A
                LD D, A
                ADD HL, DE
                EX DE, HL
                POP HL
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A
                OR A
                SBC HL, DE

                LD A, L
                RR H
                RRA
                LD L, A

.ContainerX     EQU $+1
                LD E, #00
                LD D, L

                RET

                endif ; ~ _CORE_MODULE_AI_UTILS_DELTA_BETWEEN_LOCATION_AND_TARGET_