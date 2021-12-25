
                    ifndef _STRUCTURE_AABB_TREE_
                    define _STRUCTURE_AABB_TREE_

                    struct FAABB
MIN                 FVector2DHalf
MAX                 FVector2DHalf

                    ends


                    struct FAABBTreeNode
AABB                FAABB
ParentNext          DB #00
Left                DB #00
Right               DB #00
Height              DB #00

                    ends

                    endif ; ~_STRUCTURE_AABB_TREE_