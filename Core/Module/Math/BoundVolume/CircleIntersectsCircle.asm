
                ifndef _MATH_CIRCLE_INTERSECTS_CIRCLE_
                define _MATH_CIRCLE_INTERSECTS_CIRCLE_

                module Math
; -----------------------------------------
; проверка пересечения окружности с другой окружностью
; In :
; Out :
; Corrupt :
; Note:
; -----------------------------------------
CircleIntersectCircle:
                RET

                display " - Circle Intersects Circle : \t\t\t\t\t", /A, CircleIntersectCircle, " = busy [ ", /D, $ - CircleIntersectCircle, " bytes  ]"

                endmodule

                endif ; ~_MATH_CIRCLE_INTERSECTS_CIRCLE_
