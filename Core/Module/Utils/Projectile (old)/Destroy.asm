
                ifndef _UTILS_PROJECTILE_DESTROY_
                define _UTILS_PROJECTILE_DESTROY_
; -----------------------------------------
; удаление проджектайла из обработки
; In:
;   IX - адрес обрабатываемого проджектайла
; Out:
; Corrupt:
; -----------------------------------------
Destroy:        ; обнулить скорость проджектайла, что означает что его не существует
                XOR A
                LD (IX + FProjectile.Speed), A

                ; уменьшаем счётчик пуль в буфере
                LD A, (Number)
                DEC A
                LD (Number), A

                RET

                endif ; ~_UTILS_PROJECTILE_DESTROY_