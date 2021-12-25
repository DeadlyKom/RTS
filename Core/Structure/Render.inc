
                        ifndef _STRUCTURE_RENDER_
                        define _STRUCTURE_RENDER_

RENDER_TILEMAP_FLAG     EQU 0x80
RENDER_UNITS_FLAG       EQU 0x40
RENDER_TOP_FLAG         EQU 0x20
RENDER_FOW_FLAG         EQU 0x10

                        ifdef ENABLE_FOW
RENDER_ALL_FLAGS        EQU RENDER_TILEMAP_FLAG | RENDER_UNITS_FLAG | RENDER_TOP_FLAG | RENDER_FOW_FLAG

                        else
RENDER_ALL_FLAGS        EQU RENDER_TILEMAP_FLAG | RENDER_UNITS_FLAG

                        endif
WORD_RENDER_ALL_FLAGS   EQU (RENDER_ALL_FLAGS << 8) | RENDER_ALL_FLAGS

                        struct FRender
Field                   DB #00

                        ends

                        endif ; ~_STRUCTURE_RENDER_