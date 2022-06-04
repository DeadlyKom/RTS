
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_VARIABLES_
                define _CORE_MODULE_VFX_TEXT_RENDER_VARIABLES_

                struct FTextVFX
Shader          DW #0000                                                        ; адрес шейдера                     (const)
FrameTiming     DW #0000                                                        ; адрес таймингов фреймов           (const)
Length          DB #00                                                          ; длина эффекта в знакоместах       (const)
FrameCounter    DB #00                                                          ; счётчик фреймов                   (tmp)
TickCounter     DB #00                                                          ; счётчик тиков                     (tmp)
Flags           DB #00                                                          ; флаги
FrameComplited: DW #0000                                                        ; адрес функции FRAME_COMPLITED
VFX_Complited:  DW #0000                                                        ; адрес функции VFX_COMPLITED

                ends

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_VARIABLES_