
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_CONST_
                define _CORE_MODULE_VFX_TEXT_RENDER_CONST_
@VFX_COMPLITED_BIT EQU 0x07
@VFX_FRAME_COMPLITED_BIT EQU 0x06
@VFX_PLAYING_BIT EQU 0x05

@VFX_COMPLITED  EQU 1 << VFX_COMPLITED_BIT
@VFX_FRAME_COMPLITED EQU 1 << VFX_FRAME_COMPLITED_BIT
@VFX_PLAYING    EQU 1 << VFX_PLAYING_BIT

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_CONST_