
                ifndef _BUILDER_MENU_PACK_MENU_GRAPHICS_
                define _BUILDER_MENU_PACK_MENU_GRAPHICS_

                MMU 3, Page.MenuGraphics.A                                      ; 3 bank, Page.MenuGraphics.A (0) page
                ORG Adr.Module.MenuGraphics.A
                module MenuGraphics

                display "\'Menu - Graphics\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"

                ifdef _REBUILD
                include "Core/Module/Sprites/Main/NewGame/Compress.inc"
                endif

Begin:          EQU $

Interact_1:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_1.ar.spr"
Interact_2:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_2.ar.spr"
Interact_3:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_3.ar.spr"
Interact_4:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_4.ar.spr"
Interact_5:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_5.ar.spr"
Interact_6:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_6.ar.spr"
Interact_7:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_7.ar.spr"
Interact_8:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_8.ar.spr"
Interact_9:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_9.ar.spr"
Interact_10:    EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/interact_10.ar.spr"
                
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MenuNewGameGraphicsANameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_MENU_GRAPHICS_

