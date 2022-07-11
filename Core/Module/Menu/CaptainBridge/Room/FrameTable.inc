
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_FRAME_TABLE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_FRAME_TABLE_

FrameTable:     FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_1 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_2 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_3 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_4 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_5 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_6 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_7 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_8 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_9 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Interact_10 }

FRAME_LEFT      EQU 0x00
FRAME_CENTER    EQU 0x04
FRAME_RIGHT     EQU 0x09
FRAME_MAX       EQU FRAME_RIGHT + 1

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_FRAME_TABLE_
