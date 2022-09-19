
                ifndef _MATH_POINT_INSIDE_CIRCLE_
                define _MATH_POINT_INSIDE_CIRCLE_

                module Math
; -----------------------------------------
; проверка нахождения точки внутри круга
; In :
; Out :
; Corrupt :
; Note:
; -----------------------------------------
PointInsideCircle:
                RET

                display " - Point Inside Circle : \t\t\t", /A, PointInsideCircle, " = busy [ ", /D, $ - PointInsideCircle, " bytes  ]"

                endmodule

                endif ; ~_MATH_POINT_INSIDE_CIRCLE_
