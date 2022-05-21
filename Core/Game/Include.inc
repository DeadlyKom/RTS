
                    ifndef _CORE_GAME_INCLUDE_
                    define _CORE_GAME_INCLUDE_

                    module Game

                    include "EntryPoint.asm"
                    include "Initialize.asm"
                    include "LoadMap.asm"
                    include "Loop.asm"
                    include "Music.asm"

; tilemap
TilemapSize:        FMapSize 64, 64
TilemapSize_NEG:    FMapSize -64, -64

; animation
AnimTurnUpTable:    DW #0000                                                    ; адрес таблицы анимации поворотов (вверх)
AnimTurnDownTable:  DW #0000                                                    ; адрес таблицы анимации поворотов (низа)
AnimMoveTable:      DW #0000                                                    ; адрес таблицы анимации перемещения

; unit
UnitsChar           DW #0000                                                    ; адрес таблицы характеристик юнитов

; TilemapAddress:     DW #0000
; AddressTable:       DW #0000
; SurfacePropertyPtr: DW #0000
WaypointCounter:    DB #00
WaypointArray:      DW #0000
TilemapPtr:         DW #0000
UnitArrayPtr:       DW #0000
TilemapOffset:      FLocation 0, 0


AI_UpdateFreq:      DB #00
AI_NumUnits:        DB #00
BehaviorTable:      DW #0000

; UnitArray:          DW #0000
FrameFlags:         DB #00
GameplayState:      DB #00
InputState:         DB #00
TilemapState:       DB #00
AIFlags:            DB #00
FrameUnitsFlag:     DB #00
HardwareFlags:      DB #00
MinCursorSpeed:     DB #00
MaxCursorSpeed:     DB #00

; keyboard
VK_Keys             EQU $
VK_KeyUp:           DB VK_W
VK_KeyDown:         DB VK_S
VK_KeyLeft:         DB VK_A
VK_KeyRight:        DB VK_D
VK_KeySelect:       DB VK_SPACE

                    ifdef _DEBUG
DebugFlags:         DB #00

                    endif

                    endmodule

                    endif ; ~_CORE_GAME_INCLUDE_
