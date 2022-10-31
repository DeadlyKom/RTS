                            ifndef _CORE_MEMORY_PAGE_MAP_00_
                            define _CORE_MEMORY_PAGE_MAP_00_

; unit
; UnitsArrayPtr               EQU Page_0                                          ; адрес масива юнитов

; chunk array
; UnitsObjectArrayPtr         EQU UnitsArrayPtr + UNITS_STRUCTURE_SIZE            ; адрес массива чанков для юнитов
; UnitsObjectArraySize        EQU 256                                             ; размер массива
; DynamicObjectArrayPtr       EQU UnitsObjectArrayPtr + UnitsObjectArraySize      ; адрес массива чанков для динамических объектов
; DynamicObjectArraySize      EQU 256                                             ; размер массива

; way point
WaypointsSequencePtr        EQU DynamicObjectArrayPtr + DynamicObjectArraySize  ; адрес последовательностей Way Point'ов
WaypointsSequenceSize       EQU 256 * 8                                         ; размер массива последовательностей Way Point'ов, 256 последовательностей в каждой по 8 Way Point'ов

WaypointArrayPtr            EQU WaypointsSequencePtr + WaypointsSequenceSize    ; адрес массива Way Point'ов
WaypointArraySize           EQU 256 * FWayPoint                                 ; размер массива Way Point'ов

UnitCodePtr                 EQU WaypointArrayPtr + WaypointArraySize            ; начальный адрес расположения кода рыботы с юнитами
; AI
GameModeDataPtr             EQU UnitCodePtr + UnitCodeSize                      ; начальный адрес режима игры
                                                                                ; поведение юнитов

Size                        EQU UNITS_STRUCTURE_SIZE + UnitsObjectArraySize + DynamicObjectArraySize + WaypointsSequenceSize + WaypointArraySize

                            endif ; ~_CORE_MEMORY_PAGE_MAP_00_
