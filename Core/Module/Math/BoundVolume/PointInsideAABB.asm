
                ifndef _MATH_POINT_INSIDE_AABB_
                define _MATH_POINT_INSIDE_AABB_

                module Math
; -----------------------------------------
; проверка нахождения точки внутри AABB
; In :
; Out :
; Corrupt :
; Note:
; -----------------------------------------
PointInsideAABB:
                RET

                display " - Point Inside AABB : \t\t\t\t\t", /A, PointInsideAABB, " = busy [ ", /D, $ - PointInsideAABB, " bytes  ]"

                endmodule

                endif ; ~_MATH_POINT_INSIDE_AABB_
