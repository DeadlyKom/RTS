
                ifndef _MODULE_TILEMAP_INCLUDE_
                define _MODULE_TILEMAP_INCLUDE_

                module Tilemap

                include "Animation/TileSampling.asm"
                include "Animation/AnimTile.asm"

                ;
                include "Surfrace/SurfaceProperty.asm"

                ;
                include "Convert/GetAddress.asm"
                include "Control/ShiftRenderBuffer.asm"

                ; memcpy
                include "Core/Module/Memory/MemcpyTilemap.asm"

                endmodule

                endif ; ~_MODULE_TILEMAP_INCLUDE_
