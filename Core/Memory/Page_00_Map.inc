                            ifndef _CORE_MEMORY_PAGE_MAP_00_
                            define _CORE_MEMORY_PAGE_MAP_00_
UnitsArrayPtr               EQU Page_0                                          ; адрес масива юнитов

WaypointsSequencePtr        EQU UnitsArrayPtr + UNITS_STRUCTURE_SIZE            ; адрес последовательностей Way Point'ов
WaypointsSequenceSize       EQU 256 * 8                                         ; размер массива последовательностей Way Point'ов, 256 последовательностей в каждой по 8 Way Point'ов

WaypointArrayPtr            EQU WaypointsSequencePtr + WaypointsSequenceSize    ; адрес массива Way Point'ов
WaypointArraySize           EQU 256 * FWayPoint                                 ; размер массива Way Point'ов

                            endif ; ~_CORE_MEMORY_PAGE_MAP_00_