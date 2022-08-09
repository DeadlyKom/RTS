
                module FOW
IDX_UP          EQU -SCREEN_TILE_X
IDX_DOWN        EQU SCREEN_TILE_X
ROW_UP          EQU SCREEN_TILE_X * SCREEN_TILE_Y                               ; 192               смещение в буфере верхней строки FOW 
ROW_DOWN        EQU ROW_UP + SCREEN_TILE_X                                      ; 192 + 16 = 208    смещение в буфере нижней строки FOW
ROW_0           EQU ROW_DOWN + SCREEN_TILE_X                    ; 208 + 16 = 224
ROW_1           EQU ROW_0 + 2                                   ; 224 + 2  = 226
ROW_2           EQU ROW_1 + 2                                   ; 226 + 2  = 228
ROW_3           EQU ROW_2 + 2                                   ; 228 + 2  = 230
ROW_4           EQU ROW_3 + 2                                   ; 230 + 2  = 232
ROW_5           EQU ROW_4 + 2                                   ; 232 + 2  = 234
ROW_6           EQU ROW_5 + 2                                   ; 234 + 2  = 236
ROW_7           EQU ROW_6 + 2                                   ; 236 + 2  = 238
ROW_8           EQU ROW_7 + 2                                   ; 238 + 2  = 240
ROW_9           EQU ROW_8 + 2                                   ; 240 + 2  = 242
ROW_A           EQU ROW_9 + 2                                   ; 242 + 2  = 244
ROW_B           EQU ROW_A + 2                                   ; 244 + 2  = 246

                align 256
Table:          EQU $
Idx             defl 0
IdxRow          defl 2

                ; верхний
                DB ROW_0, Idx + 1,                  Idx + ROW_UP, Idx + IDX_DOWN
Idx             = Idx + 1

                dup 14
                DB Idx - 1, Idx + 1,                Idx + ROW_UP, Idx + IDX_DOWN
Idx             = Idx + 1
                edup

                DB Idx - 1, ROW_0 + 1,              Idx + ROW_UP, Idx + IDX_DOWN
Idx             = Idx + 1


                ; середина
                dup 10

                DB ROW_0 + IdxRow, Idx + 1,         Idx + IDX_UP, Idx + IDX_DOWN
Idx             = Idx + 1

                dup 14
                DB Idx - 1, Idx + 1,                Idx + IDX_UP, Idx + IDX_DOWN
Idx             = Idx + 1
                edup

                DB Idx - 1, ROW_0 + IdxRow + 1,     Idx + IDX_UP, Idx + IDX_DOWN
Idx             = Idx + 1
IdxRow          = IdxRow + 2
                edup

                ; нижний
                DB ROW_B, Idx + 1,                  Idx + IDX_UP, (Idx & 0x0F) + ROW_DOWN
Idx             = Idx + 1

                dup 14
                DB Idx - 1, Idx + 1,                Idx + IDX_UP, (Idx & 0x0F) + ROW_DOWN
Idx             = Idx + 1
                edup

                DB Idx - 1, ROW_B + 1,              Idx + IDX_UP, (Idx & 0x0F) + ROW_DOWN

                display " - Bypass FOW : \t\t", /A, Table, " = busy [ ", /D, $ - Table, " bytes  ]"

                endmodule
