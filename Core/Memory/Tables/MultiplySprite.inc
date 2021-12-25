                align 256
MultiplySprite: ; таблица умножения для спрайтов
                ; LengthSprite = ширина спрайта                 1-4 байта
                ; SkipRow      = количество пропускаемых строк  1-32 строки
                ; размер таблицы 128 байт

.SkipRow        defl 1
.LengthSprite   defl 1
                dup 4                                                           ; максимальная длина спрайта в знакоместах
                dup 32                                                          ; максимальное количество пропускаемых строк спрайта
                DB (.SkipRow * (.LengthSprite << 1)) & 0xFF
.LengthSprite   = .LengthSprite + 1
                edup
.LengthSprite   = 1
.SkipRow        = .SkipRow + 1
                edup
