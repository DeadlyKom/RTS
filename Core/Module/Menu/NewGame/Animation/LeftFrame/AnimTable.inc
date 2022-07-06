
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_ANIM_TABLE_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_ANIM_TABLE_
Cooler1Table:   FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_1_0 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_1_1 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_1_2 }
Cooler2Table:   FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_2_0 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_2_1 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Cooler_2_2 }
MonitorTable:   FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Monitor_0 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Monitor_1 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Monitor_2 }
StorageTable:   FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Storage_0 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Storage_1 }
                FSpriteData { Page.MenuGraphics.A, Adr.Module.MenuGraphics.Storage_2 }

Cooler1Anim:    FStaticAnimation {
                {0, 0}, {3, 2},
                Cooler1Table,
                0, 3, 6, 6 }
Cooler2Anim:    FStaticAnimation {
                {0, 0}, {3, 1},
                Cooler2Table,
                0, 3, 6, 6 }
MonitorAnim:    FStaticAnimation {
                {0, 0}, {2, 1},
                MonitorTable,
                0, 3, 6, 6 }
StorageAnim:    FStaticAnimation {
                {0, 0}, {2, 2},
                StorageTable,
                0, 3, 6, 6 }

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_ANIM_TABLE_
