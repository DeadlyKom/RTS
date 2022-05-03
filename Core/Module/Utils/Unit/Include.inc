
                ifndef _CORE_MODULE_UTILS_UNIT_INCLUDE_
                define _CORE_MODULE_UTILS_UNIT_INCLUDE_

                module Unit

                include "Reconnaissance.asm"
                include "CalculateDirectionRotation.asm"
                include "GetScreenAABB.asm"
                include "GetAddressInTable.asm"
                include "GetAddress.asm"
                include "GetIndex.asm"
                include "GetUnitsListInLocation.asm"
                include "Damage/Include.inc"
                include "State/CheckState.asm"
                include "State/SetState.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_UNIT_INCLUDE_