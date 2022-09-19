
                ifndef _BUILDER_MENU_PACK_MENU_GRAPHICS_
                define _BUILDER_MENU_PACK_MENU_GRAPHICS_

                MMU 3, Page.Graphics.A                                          ; 3 bank, Page.MenuGraphics.A (0) page
                ORG Adr.Module.Graphics.A
                module Graphics

                display "\'Menu - Graphics\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Graphics.A, "]\t-------------------------------------------------"

                ifdef _REBUILD
                include "Core/Module/Sprites/Main/NewGame/Compress.inc"
                endif
Begin:          EQU $

Interact_1:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_1.ar.spr"
Interact_2:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_2.ar.spr"
Interact_3:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_3.ar.spr"
Interact_4:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_4.ar.spr"
Interact_5:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_5.ar.spr"
Interact_6:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_6.ar.spr"
Interact_7:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_7.ar.spr"
Interact_8:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_8.ar.spr"
Interact_9:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_9.ar.spr"
Interact_10:    EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Compressed/Room/interact_10.ar.spr"

; анимации первого фрейма (левая)
Cooler_1_0:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_1_0.spr"
Cooler_1_1:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_1_1.spr"
Cooler_1_2:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_1_2.spr"
Cooler_1_Size:  EQU $ - Cooler_1_2 - MemBank_03
Cooler_2_0:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_2_0.spr"
Cooler_2_1:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_2_1.spr"
Cooler_2_2:     EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Cooler_2_2.spr"
Cooler_2_Size:  EQU $ - Cooler_2_2 - MemBank_03
Monitor_0:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Monitor_0.spr"
Monitor_1:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Monitor_1.spr"
Monitor_2:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Monitor_2.spr"
Monitor_Size:   EQU $ - Monitor_2 - MemBank_03
Storage_0:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Storage_0.spr"
Storage_1:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Storage_1.spr"
Storage_2:      EQU $ - Begin
                incbin "Core/Module/Sprites/Main/NewGame/Original/Anim Frame 1/Storage_2.spr"
Storage_Size:   EQU $ - Storage_2 - MemBank_03
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, CaptainBridgeGraphicsANameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_MENU_GRAPHICS_

