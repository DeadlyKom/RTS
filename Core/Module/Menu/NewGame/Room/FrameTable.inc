
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_FRAME_TABLE_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_FRAME_TABLE_

FrameTable:     FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_1 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_2 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_3 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_4 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_5 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_6 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_7 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_8 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_9 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Interact_10 }

FRAME_LEFT      EQU 0x00
FRAME_CENTER    EQU 0x04
FRAME_RIGHT     EQU 0x09
FRAME_MAX       EQU FRAME_RIGHT + 1

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_FRAME_TABLE_
