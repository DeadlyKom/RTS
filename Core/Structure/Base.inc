
                    ifndef _STRUCTURE_BASE_
                    define _STRUCTURE_BASE_

; -------------------- size map --------------------

                    struct FMapSize
X                   DB #00
Y                   DB #00

                    ends

; -------------------- location coordinates on the tilemap --------------------

                    struct FLocation
X                   DB #00
Y                   DB #00            

                    ends

; -------------------- path finding stack --------------------

                    struct FPathFindingStack
Stack               DS 8, 0

                    ends

                    endif ; ~_STRUCTURE_BASE_