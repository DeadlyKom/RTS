
                    ifndef _CORE_AI_BEHAVIOR_INFANTRY_
                    define _CORE_AI_BEHAVIOR_INFANTRY_
BEHAVIOR_INFANTRY:  ; 
                    BT_SELECTOR     0,          1,    BTF_ROOT                  ; 0 - A
                    BT_SEQUENCE     0,          4,    BTF_NONE                  ; 1 - B
                    BT_SEQUENCE     0,          7,    BTF_NONE                  ; 2 - C
                    BT_TASK         0,   BTT_IDLE,    BTF_LAST                  ; 3 - D
                    BT_TASK         1,     BTT_WP,    BTF_NONE                  ; 4 - E
                    BT_TASK         1,    BTT_TTO,    BTF_NONE                  ; 5 - F
                    BT_TASK         1,    BTT_MTO,    BTF_LAST                  ; 6 - G
                    BT_TASK         2,     BTT_CE,    BTF_NONE                  ; 7 - H
                    BT_TASK         2,    BTT_TTO,    BTF_NONE                  ; 8 - I
                    BT_TASK         2,    BTT_ATO,    BTF_LAST                  ; 9 - J

                    endif ; ~ _CORE_AI_BEHAVIOR_INFANTRY_