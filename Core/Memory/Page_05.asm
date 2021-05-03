
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
                
                module MemoryPage_5
Start:
CopyScreenCont: ;
; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 LD A, R
;                 JP M, .Play
;                 EI
;                 HALT
;                 DI
;                 JR .SkipPlay
; .Play           CALL PlayMusic
; .SkipPlay       LD (.ContainerSP_), SP
                ;
.Offset         defl 364 * 16
                dup 68 - 48
                ; получение 16 байт
                LD SP, #4000 + .Offset
                POP HL
                POP DE
                POP BC
                POP AF
                EX AF, AF'
                POP AF
                EXX
                POP HL
                POP DE
                POP BC
                ; сохранение 16 байт
                LD SP, #C010 + .Offset
                PUSH BC
                PUSH DE
                PUSH HL
                EXX
                PUSH AF
                EX AF, AF'
                PUSH AF
                PUSH BC
                PUSH DE
                PUSH HL
.Offset = .Offset + 16
                edup
.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                RET
GameEntry:      CALL GameInitialize                                     ; #6412

                ; ---- test ----
                ; LD HL, #4000
                ; LD DE, #4001
                ; LD BC, #1800 - 1
                ; LD (HL), #FF
                ; LDIR

                ; SeMemoryPage MemoryPage_TilemapSprite
                ; LD HL, MemoryPage_0.Sprite_Bot_0
                ; LD DE, #0201
                ; CALL MemoryPage_2.DisplaySBP
                LD A, #01
                OUT (#FE), A
                LD IY, .ArrayUnits
                CALL MemoryPage_2.HandlerUnits
                JR .SkipArray

.ArrayUnits     FUnit 0, 0, 0, 0,  0, 0,  0, -8
                FUnit 0, 0, 0, 0,  0, 2,  0, 0
.CountUnits     DB #02

.SkipArray
                ; ~~~~ test ~~~~

                CALL MemoryPage_2.InitTilemap

                LD HL, #C000
                CALL MemoryPage_2.PrepareTilemap

                LD HL, BufferCMD
                
                ; display tilemap
                LD DE, MemoryPage_2.DisplayTilemap             
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                ; display Fog of War
                LD DE, MemoryPage_2.DisplayTileFOW
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                ; main loop
.MainLoop       LD A, #00
                LD (Flags), A
                HALT
                LD A, #FF
                LD (Flags), A
                
                LD HL, BufferCMD
                LD (PointerCMD), HL
                ; LD HL, (MemoryPage_5.TileMapPtr)
                ; LD (MemoryPage_2.DisplayTileMap.TileMapRow), HL

                ;CALL PlayMusic

.ResetFrame     LD HL, #0000
                LD D, H
                LD E, L
                LD (CounterTime), HL

.HandlerCMD     LD HL, (CounterTime)
                ADD HL, DE
                LD (CounterTime), HL
                LD BC, #FE00                            ; the frame time is modified in the interrupt (3.5 - #FE00, 14 - #FA67)
                ADD HL, BC
                JR C, .IsEnd
                ; execute block code
                LD HL, .HandlerCMD
                PUSH HL
                LD HL, (PointerCMD)
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (PointerCMD), HL
                LD A, D
                OR E
                JR Z, .BufferIsEmpty
                ifdef _DEBUG_CHECK
                LD BC, -(SizeBufferCMD + BufferCMD)
                ADD HL, BC
                JR Z, .BufferIsEmpty
                endif
                EX DE, HL
                JP (HL)                                 ; block code must return delta time in DE

.IsEnd          ; some code to the end of the frame

                LD HL, MemoryPage_2.InterruptCounter
                LD A, (HL)
                
.WaitInterrupt  CP (HL)
                JR Z, .WaitInterrupt

                JR .ResetFrame

.BufferIsEmpty  ; copy from buffer screen to shadow screen

                POP HL
                LD HL, 1000;1650
                LD BC, 1
.L1             SBC HL, BC
                JR NZ, .L1

                ; toggle to memory page with shadow screen
                SeMemoryPage MemoryPage_ShadowScreen
                CALL MemoryPage_7.CopyScreen
                JR .MainLoop
Flags           DB #00
SizeBufferCMD:  EQU 8 * 2
PointerCMD:     DW BufferCMD
CounterTime:    DW #0000
BufferCMD:      DS SizeBufferCMD, 0

GameInitialize: CALL MemoryPage_2.InitMouse
                CALL MemoryPage_2.InitInterrupt
                ; initialize music
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                LD A, R
                RRA
                LD HL, #D11B
                JR C, $+5
                LD HL, #C86E
                CALL #C003
                EI
                ; initialize background
                CALL MemoryPage_2.BackgroundFill

                RET
PlayMusic:      ;
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                CALL #C005
                RET

TileMapPtr:     DW TileMap + 1
TileMapOffset:  FLocation 0, 0
TileMapSize:    FMapSize 64, 64
TileMapBuffer:  DS 192, 0

TableSprites:   DW TableSprites_Infantry
TableSprites_Infantry:
                FSprite 24, 0, 24, 9, 0, MemoryPage_TilemapSprite, MemoryPage_0.Sprite_Bot_0     ; 0

                include "../Display/ShiftTable.inc"                     ; удалить!
                include "../Display/OffsetTableByAnimIndex.inc"
End:
                endmodule
SizePage_5:     EQU MemoryPage_5.End - MemoryPage_5.Start

                endif ; ~_CORE_MEMORY_PAGE_05_
