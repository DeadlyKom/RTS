
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_DATA_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_DATA_
; -----------------------------------------
; загрузка данных карты
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MapData:        ; копирование данных в область переменных
                LD HL, FileSystem.FileNameMap  
                CALL FileSystem.FindFile
                RET C

                ; копирование свойст поверхностей
                LD DE, SurfacePropertyPtr                                       ; адрес свойств поверхностей
.SurfPropSize   EQU $+1
                LD BC, #0000                                                    ; размер свойств поверхности
                LD A, #01                                                       ; страница свойств поверхности
                CALL FileSystem.SequentialRead

                ; копирование поведение юнитов
                LD DE, GameModeDataPtr                                          ; адрес поведение юнитов
.BehaviorSize   EQU $+1
                LD BC, #0000                                                    ; размер поведения юнитов
                LD A, UnitDataPage                                              ; страница поведения юнитов
                CALL FileSystem.SequentialRead

                ; копирование таблицы анимации поворотов (вверх)
                LD DE, (AnimTurnUpTableRef)                                     ; адрес таблицы анимации поворотов (вверх)
.AnimTUpSize    EQU $+1
                LD BC, #0000                                                    ; размер таблицы анимации поворотов (вверх)
                LD A, UnitDataPage                                              ; страница таблицы анимации поворотов (вверх)
                CALL FileSystem.SequentialRead

                ; копирование таблицы анимации поворотов (низа)
                LD DE, (AnimTurnDownTableRef)                                   ; адрес таблицы анимации поворотов (низа)
.AnimTDownpSize EQU $+1
                LD BC, #0000                                                    ; размер таблицы анимации поворотов (низа)
                LD A, UnitDataPage                                              ; страница таблицы анимации поворотов (низа)
                CALL FileSystem.SequentialRead

                ; копирование таблицы анимации перемещения
                LD DE, (AnimMoveTableRef)                                       ; адрес таблицы анимации перемещения
.AnimMoveSize   EQU $+1
                LD BC, #0000                                                    ; размер таблицы анимации перемещения
                LD A, UnitDataPage                                              ; страница таблицы анимации перемещения
                CALL FileSystem.SequentialRead

                ; копирование таблицы анимации перемещения
                LD DE, TilemapPtr                                               ; адрес тайловой карты
.TilemapSize    EQU $+1
                LD BC, #0000                                                    ; размер тайловой карты
                LD A, TilemapPage                                               ; страница тайловой карты
                CALL FileSystem.SequentialRead

                ; успешное выполнение
                OR A
                RET

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_DATA_