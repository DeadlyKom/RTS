
                    ifndef _FRAME_FLAGS_INCLUDE_
                    define _FRAME_FLAGS_INCLUDE_

                    ; активное значение false
SWAP_SCREENS_FLAG   EQU 0x80                                                    ; разрешить смену экран
RENDER_FINISHED     EQU 0x40                                                    ; отрисовка завершена
RESTORE_CURSOR      EQU 0x20                                                    ; востановление данных экрана
DELAY_RENDER_FLAG   EQU 0x10                                                    ; отсрочить отрисовку экрана
FORCE_FOW_FLAG      EQU 0x08

                    endif ; ~_FRAME_FLAGS_INCLUDE_