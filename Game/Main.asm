    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                ; define ENABLE_MUSIC                         ; разрешить музыку
                define ENABLE_MOUSE                         ; разрешить мышь
                ; define ENABLE_FOW                           ; разрешить туман войны
                define ENABLE_CLS                           ; разрешить очистить 2 экрана перед стартом

                define SHOW_DEBUG_BORDER                    ; разрешить отображать на бордюрах время выполнение
                define SHOW_DEBUG_BORDER_TILEMAP            ; отображение на бордюрах время отображения бэкграунда карты
                define SHOW_DEBUG_BORDER_DRAW_UNITS         ; отображение на бордюрах время отображения юнитов
                define SHOW_DEBUG_BORDER_FOW                ; отображение на бордюрах время отображения тумана войны
                define SHOW_DEBUG_BORDER_CURSOR             ; отображение на бордюрах время отображения курсора
                define SHOW_DEBUG_BORDER_CURSOR_RESTORE     ; отображение на бордюрах время востановление фона после курсора
                define SHOW_DEBUG_BORDER_PLAY_MUSIC         ; отображение на бордюрах время проигрывания музыки

                define SHOW_DEBUG                           ; разрешить отображать дебажную инормацию
                ifdef SHOW_DEBUG
                define SHOW_FPS                             ; отображать FPS
                define SHOW_MOUSE_POSITION                  ; отображать координаты мыши
                define SHOW_OFFSET_TILEMAP                  ; отображать смещение карты
                define SHOW_VISIBLE_UNITS                   ; отображать количество видимых юнитов
                define ENABLE_TOGGLE_SCREENS_DEBUG          ; разрешить 2х экранное отображение дебажной инфы
                endif

                include "Include.inc"
                include "../Core/Memory/Include.inc"
                include "../Core/Builder.asm"

                endif ; ~_GAME_MAIN_
