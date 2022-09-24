
                ifndef _MACRO_INCLUDE_
                define _MACRO_INCLUDE_

                include "Config.inc"
                include "Basic.inc"
                include "Screen.inc"
                include "Memory.inc"
                include "Interrupt.inc"
                include "Flags.inc"

                ; game
                include "Core/Module/Unit/State/Macro/UnitState.inc"
                include "Core/Module/Unit/State/Macro/UnitRank.inc"

                include "Debug.inc"

                endif ; ~_MACRO_INCLUDE_
