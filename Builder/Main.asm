    
                ifndef _BUILDER_MAIN_
                define _BUILDER_MAIN_

                DEVICE ZXSPECTRUM128

                ; define _REBUILD                                                 ; полная пересборка
                define _DEBUG                                                   ; включить отладочный код
                ; define _OPTIMIZE                                                ; включить оптимизацию (ускорение)
                define SHOW_DEBUG                                               ; отображение дебажной информации

                ; define ENABLE_SCREENSAVER                                       ; включить заставку
                ; define ENABLE_INITIAL_DIALOG                                    ; включить начальный диалог
                define ENABLE_START_GAME                                        ; включить сразу игру
                ; define ENABLE_MUSIC                                             ; разрешить музыку
                define ENABLE_MOUSE                                             ; разрешить мышь
                define ENABLE_KEMSTON_JOYSTICK_SEGA                             ; разрешить использовать расширенный Кемстон Джойстик (SEGA 8 bits)
                define ENABLE_FOW                                               ; разрешить туман войны
                define ENABLE_CLS                                               ; разрешить очистить 2 экрана перед стартом
                define ENABLE_FILL_FOW                                          ; разрешить заполнение туманом всю карту
                ; define ENABLE_TIME_OF_DAY                                       ; разрешить смену дня и ночи
                ; define ENABLE_DEBUG_NETWORK                                     ; разрешить отладку по сети

                ; define SHOW_DEBUG_BORDER                                        ; разрешить отображать на бордюре время выполнение
                ; define SHOW_DEBUG_BORDER_INTERRUPT                              ; отображение на бордюре время прерывания
                ; define SHOW_DEBUG_BORDER_TILEMAP                                ; отображение на бордюре время отображения бэкграунда карты
                ; define SHOW_DEBUG_BORDER_SCROLL_PREPARE                         ; отображение на бордюре время операции подготовки нового участка тайловой карты
                ; define SHOW_DEBUG_BORDER_DRAW_UNITS                             ; отображение на бордюре время отображения юнитов
                ; define SHOW_DEBUG_BORDER_FOW                                    ; отображение на бордюре время отображения тумана войны
                ; define SHOW_DEBUG_BORDER_CURSOR                                 ; отображение на бордюре время отображения курсора
                ; define SHOW_DEBUG_BORDER_CURSOR_RESTORE                         ; отображение на бордюре время востановление фона после курсора
                ; define SHOW_DEBUG_BORDER_PLAY_MUSIC                             ; отображение на бордюре время проигрывания музыки
                ; define SHOW_DEBUG_BORDER_DRAFT_LOGIC                            ;
                
                ifdef SHOW_DEBUG
                define SHOW_FPS                                                 ; отображать FPS
                define SHOW_AI_FREQUENCY                                        ; отображать частоту обновления AI
                ; define SHOW_MOUSE_POSITION                                      ; отображать координаты мыши
                ; define SHOW_OFFSET_TILEMAP                                      ; отображать смещение карты
                define SHOW_VISIBLE_UNITS                                       ; отображать количество видимых юнитов
                define ENABLE_TOGGLE_SCREENS_DEBUG                              ; разрешить 2х экранное отображение дебажной инфы
                ; define SHOW_AABB                                                ; разрешить отобразить AABB спрайта

                ifdef ENABLE_DEBUG_NETWORK
                define ENABLE_BEHAVIOR_TREE_STATE                               ; разрешить отображать состояния дерева поведения
                endif

                endif

                include "Includes/Include.inc"

                display "-------------------------------------------------------------------------------------------------------------------------------"
                display "Build version: ", /D, BUILD, ".", /D, MAJOR,".", /D, MINOR
                display "Building the TRD-image of the \'", TRD_FILENAME, "\' project ..."
                display "-------------------------------------------------------------------------------------------------------------------------------"

                include "Pack.inc"

                endif ; ~_BUILDER_MAIN_
