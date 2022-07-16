
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_

SetPrinted:     LD (IY + FDialogVariable.State), PRINTED_MSG
                RET
GetWaitInput:   LD A, (IY + FDialogVariable.State)
                CP WAITING_INPUT
                RET
SetWaitInput:   LD (IY + FDialogVariable.State), WAITING_INPUT
                RET

ResetWaitInput: RET

SetScroll:      LD (IY + FDialogVariable.State), SCROLL_MSG
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
