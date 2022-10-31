
                    ifndef _STRUCTURE_INPUT_
                    define _STRUCTURE_INPUT_

; -------------------- Key State --------------------

                    struct FKeyState
VirtualKey          DB #00
Repeat              DB #00
Data                DW #00

                    ends

                    endif ; ~_STRUCTURE_INPUT_