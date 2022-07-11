
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_LEFT_ANIM_TABLE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_LEFT_ANIM_TABLE_
Cooler1Table:   FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_1_0 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_1_1 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_1_2 }
Cooler2Table:   FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_2_0 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_2_1 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Cooler_2_2 }
MonitorTable:   FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Monitor_0 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Monitor_1 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Monitor_2 }
StorageTable:   FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Storage_0 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Storage_1 }
                FSpriteData { Page.Graphics.A, Adr.Module.Graphics.Storage_2 }

Cooler1Anim:    FStaticAnimation {
                {14, 19}, {3, 2},
                Menu.Graphics.Cooler_1_Size,
                Cooler1Table,
                0, 3, 10, 5 }
Cooler2Anim:    FStaticAnimation {
                {18, 18}, {3, 1},
                Menu.Graphics.Cooler_2_Size,
                Cooler2Table,
                2, 3, 10, 6 }
MonitorAnim:    FStaticAnimation {
                {9, 12}, {2, 1},
                Menu.Graphics.Monitor_Size,
                MonitorTable,
                1, 3, 10, 7 }
StorageAnim:    FStaticAnimation {
                {13, 11}, {2, 2},
                Menu.Graphics.Storage_Size,
                StorageTable,
                2, 3, 10, 8 }

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_LEFT_ANIM_TABLE_
