
                        ; горизонталь - длина спрайта
                        ; вертикаль   - количество пропускаемых байт
                        ;
                        ;                ---- shift ----
                        ;        8          16         24         --
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |    0     |    1     |    2     |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |    5     |    6     |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |    10    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;                ---- not shift ----
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 0 |    12    |    13    |    14    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 1 |    --    |    17    |    18    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
                        ;   |          |          |          |          |
                        ; 2 |    --    |    --    |    22    |    --    |
                        ;   |          |          |          |          |
                        ;   +----------+----------+----------+----------+
TableLSJumpDraw:       ; left shift
                        DW Metod.SBP_8_0_LS,    Metod.SBP_16_0_LS,      Metod.SBP_24_0_LS, #0000
                        DW #0000,               Metod.SBP_16_1_LS,      Metod.SBP_24_1_LS, #0000
                        DW #0000,               #0000,                  Metod.SBP_24_2_LS, #0000
                        ; left, not shift
                        DW Metod.SBP_8_0,       Metod.SBP_16_0,         Metod.SBP_24_0,    #0000
                        DW #0000,               Metod.SBP_16_1_L,       Metod.SBP_24_1_L,  #0000
                        DW #0000,               #0000,                  Metod.SBP_24_2_L,  #0000
TableRSJumpDraw:       ; right shift
                        DW Metod.SBP_8_0_RS,    Metod.SBP_16_0_RS,      Metod.SBP_24_0_RS, #0000
                        DW #0000,               Metod.SBP_16_1_RS,      Metod.SBP_24_1_RS, #0000
                        DW #0000,               #0000,                  Metod.SBP_24_2_RS, #0000
                        ; right, not shift
                        DW Metod.SBP_8_0,       Metod.SBP_16_0,         Metod.SBP_24_0,    #0000
                        DW #0000,               Metod.SBP_16_1_R,       Metod.SBP_24_1_R,  #0000
                        DW #0000,               #0000,                  Metod.SBP_24_2_R,  #0000
TableJumpDraw:         ; method table by sprite width
                        DW Metod.SBP_8_0,       Metod.SBP_16_0,         Metod.SBP_24_0,    #0000
TableShiftJumpDraw:    ; shift method table by sprite width 
                        DW Metod.SBP_8_0_S,     Metod.SBP_16_0_S,       Metod.SBP_24_0_S,  #0000