
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
TickFrame:      ;
                LD A, (Menu.CaptainBridge.CapBridge.Room.Number)
                CP Menu.CaptainBridge.CapBridge.Room.ROTATE
                RET Z

                CP Menu.CaptainBridge.CapBridge.Room.LEFT
                JP Z, Room.Left.Tick

                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
