
                align 256
SCR_ADR_TABLE:
.Count          defl 0

                ; адрес экрана младший байт
                dup 192
                DB ((.Count & %00111000) << 2)
.Count          = .Count + 1
                edup

                align 256
.Count          = 0
                ; адрес экрана старший байт
                dup 192
                DB ((.Count & %11000000) >> 3) | (.Count & %00000111) + 0x40
.Count          = .Count + 1
                edup

                align 256
.Count          = 0
                ; смещение по горизонтали
                dup 256
                DB ((.Count >> 3) & %0011111)
.Count          = .Count + 1
                edup

                align 256
.Count          = 0
                ; 
                dup 256
                DB (1 << ((~.Count) & %0000111))
.Count          = .Count + 1
                edup