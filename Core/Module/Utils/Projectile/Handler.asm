
                ifndef _UTILS_PROJECTILE_HANDLER_
                define _UTILS_PROJECTILE_HANDLER_
; -----------------------------------------
; обработчик всех проджектайлов
; In:
;   в Number - хранится количество проджектайлов
; Out:
; Corrupt:
; -----------------------------------------
Handler:        ; инициализация
                LD IX, PROJECTILES                                              ; адрес буфера

                ; проверка что буфер не пуст
                LD A, (Number)
                OR A
                RET Z

                ; инициализация цикла обработки
                LD (.Counter), A

.Loop           ; проверка что данный проджектайл инициализированный (т.е. скорость > 0)
                LD A, (IX + FProjectile.Speed)
                OR A
                JR Z, .Next

                CALL Move                                                       ; перемещение проджектайла
                CALL Collision                                                  ; коллизия проджектайла
                CALL Draw                                                       ; отрисовка проджектайла

                ; декремент количистав обрабатываемых проджектайлов
.Counter        EQU $+1
                LD A, #00
                DEC A
                LD (.Counter), A

.Next           ; переход к следующему проджектайлу
                LD BC, FProjectile
                ADD IX, BC
                JR NZ, .Loop

                RET

                endif ; ~_UTILS_PROJECTILE_HANDLER_