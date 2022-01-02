    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                define DEBUG

                ; define DEBUG_PAGE_ID                                            ; писать кто переключил страницу
                ; define ENABLE_MUSIC                                             ; разрешить музыку
                define ENABLE_MOUSE                                             ; разрешить мышь
                define ENABLE_KEMSTON_JOYSTICK_SEGA                             ; разрешить использовать расширенный Кемстон Джойстик (SEGA 8 bits)
                define ENABLE_FOW                                               ; разрешить туман войны
                define ENABLE_CLS                                               ; разрешить очистить 2 экрана перед стартом
                define ENABLE_FORCE_DRAW_UNITS                                  ; разрешить принудительное обновление унитов
                ; define ENABLE_FILL_FOW                                          ; разрешить заполнение туманом всю карту
                ; define ENABLE_TIME_OF_DAY                                       ; разрешить смену дня и ночи

                ; define SHOW_DEBUG_BORDER                                        ; разрешить отображать на бордюре время выполнение
                ; define SHOW_DEBUG_BORDER_INTERRUPT                              ; отображение на бордюре время прерывания
                ; define SHOW_DEBUG_BORDER_TILEMAP                                ; отображение на бордюре время отображения бэкграунда карты
                define SHOW_DEBUG_BORDER_SCROLL_PREPARE                         ; отображение на бордюре время операции подготовки нового участка тайловой карты
                ; define SHOW_DEBUG_BORDER_DRAW_UNITS                             ; отображение на бордюре время отображения юнитов
                ; define SHOW_DEBUG_BORDER_FOW                                    ; отображение на бордюре время отображения тумана войны
                ; define SHOW_DEBUG_BORDER_CURSOR                                 ; отображение на бордюре время отображения курсора
                ; define SHOW_DEBUG_BORDER_CURSOR_RESTORE                         ; отображение на бордюре время востановление фона после курсора
                ; define SHOW_DEBUG_BORDER_PLAY_MUSIC                             ; отображение на бордюре время проигрывания музыки
                ; define SHOW_DEBUG_BORDER_DRAFT_LOGIC                            ;
                
                define SHOW_DEBUG                                               ; разрешить отображать дебажную инормацию
                ifdef SHOW_DEBUG
                define SHOW_FPS                                                 ; отображать FPS
                define SHOW_AI_FREQUENCY                                        ; отображать частоту обновления AI
                ; define SHOW_MOUSE_POSITION                                      ; отображать координаты мыши
                ; define SHOW_OFFSET_TILEMAP                                      ; отображать смещение карты
                define SHOW_VISIBLE_UNITS                                       ; отображать количество видимых юнитов
                define ENABLE_TOGGLE_SCREENS_DEBUG                              ; разрешить 2х экранное отображение дебажной инфы
                ; define SHOW_AABB                                                ; разрешить отобразить AABB спрайта
                endif

                include "../Core/Structure/Include.inc"
                include "Include.inc"
                include "../Core/Memory/Include.inc"
                include "../Core/Builder.asm"
                include "../Game/Maps/Include.inc"

                endif ; ~_GAME_MAIN_
