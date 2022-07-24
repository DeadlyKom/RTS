
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
TickFrame:      ;
                LD A, (Menu.CaptainBridge.CapBridge.Room.Number)
                CP Room.ROTATE
                RET Z

                CP Room.LEFT
                JP Z, Room.Left.Tick

                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_CORE_TICK_FRAME_
