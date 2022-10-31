TankSprite:
                ; Move

._0_1           ; t - 1 (), d - 0 (up), s - 1 (move)
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_0_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 2
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_0_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 1
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_0_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 0

._1_1           ; t - 1 (), d - 1 (up-right), s - 1 (move)
                FSprite 18,     6,      3,      10,      MemoryPage_4.Tank_Move_1_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_1_0_M    ; напровление 1, индекс анимации 2
                FSprite 18,     6,      3,      10,      MemoryPage_4.Tank_Move_1_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_1_0_M    ; напровление 1, индекс анимации 1
                FSprite 18,     6,      3,      10,      MemoryPage_4.Tank_Move_1_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_1_0_M    ; напровление 1, индекс анимации 0

._2_1           ; t - 1 (), d - 2 (right), s - 1 (move)
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_2_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_2_0_M    ; напровление 2, индекс анимации 2
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_2_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_2_0_M    ; напровление 2, индекс анимации 1
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_2_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_2_0_M    ; напровление 2, индекс анимации 0

._3_1           ; t - 1 (), d - 3 (down-right), s - 1 (move)
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_3_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_3_0_M    ; напровление 3, индекс анимации 2
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_3_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_3_0_M    ; напровление 3, индекс анимации 1
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_3_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_3_0_M    ; напровление 3, индекс анимации 0

._4_1           ; t - 1 (), d - 4 (down), s - 1 (move)
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_4_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_4_0_M    ; напровление 4, индекс анимации 2
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_4_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_4_0_M    ; напровление 4, индекс анимации 1
                FSprite 18,     7,      3,       8,      MemoryPage_4.Tank_Move_4_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_4_0_M    ; напровление 4, индекс анимации 0

._5_1           ; t - 1 (), d - 5 (down-left), s - 1 (move)
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_5_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_5_0_M    ; напровление 5, индекс анимации 2
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_5_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_5_0_M    ; напровление 5, индекс анимации 1
                FSprite 20,     9,      3,      11,      MemoryPage_4.Tank_Move_5_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_5_0_M    ; напровление 5, индекс анимации 0

._6_1           ; t - 1 (), d - 6 (left), s - 1 (move)
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_6_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_6_0_M    ; напровление 6, индекс анимации 2
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_6_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_6_0_M    ; напровление 6, индекс анимации 1
                FSprite 18,     8,      3,      10,      MemoryPage_4.Tank_Move_6_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_6_0_M    ; напровление 6, индекс анимации 0

._7_1           ; t - 1 (), d - 7 (up-left), s - 1 (move)
                FSprite 18,     6,      3,      11,      MemoryPage_4.Tank_Move_7_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_7_0_M    ; напровление 7, индекс анимации 2
                FSprite 18,     6,      3,      11,      MemoryPage_4.Tank_Move_7_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_7_0_M    ; напровление 7, индекс анимации 1
                FSprite 18,     6,      3,      11,      MemoryPage_4.Tank_Move_7_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_7_0_M    ; напровление 7, индекс анимации 0

                ; Attack

._0_2           ; t - 1 (), d - 0 (up), s - 2 (attack)
                FSprite 18,     15,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_0_2          ; напровление 0, индекс анимации 2
                FSprite 18,     15,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_0_1          ; напровление 0, индекс анимации 1
                FSprite 16,     13,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_0_0          ; напровление 0, индекс анимации 0

._1_2           ; t - 1 (), d - 1 (up-right), s - 1 (move)
                FSprite 16,     13,      3,      5,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_1_2          ; напровление 1, индекс анимации 2
                FSprite 16,     13,      3,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_1_1          ; напровление 1, индекс анимации 1
                FSprite 14,     11,      3,      5,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_1_0          ; напровление 1, индекс анимации 0

._2_2           ; t - 1 (), d - 2 (right), s - 2 (attack)
                FSprite 12,      9,      3,      5,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_2_2          ; напровление 2, индекс анимации 2
                FSprite 12,      9,      3,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_2_1          ; напровление 2, индекс анимации 1
                FSprite 12,      9,      3,      5,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_2_0          ; напровление 2, индекс анимации 0

._3_2           ; t - 1 (), d - 3 (down-right), s - 2 (attack)
                FSprite 16,      9,      3,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_3_2          ; напровление 3, индекс анимации 2
                FSprite 16,     10,      3,      7,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_3_1          ; напровление 3, индекс анимации 1
                FSprite 14,      9,      3,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_3_0          ; напровление 3, индекс анимации 0

._4_2           ; t - 1 (), d - 4 (down), s - 2 (attack)
                FSprite 18,      9,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_4_2          ; напровление 4, индекс анимации 2
                FSprite 22,     10,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_4_1          ; напровление 4, индекс анимации 1
                FSprite 18,      9,      2,      6,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_4_0          ; напровление 4, индекс анимации 0

._5_2           ; t - 1 (), d - 5 (down-left), s - 2 (attack)
                FSprite 16,      9,      3,     13,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_5_2          ; напровление 5, индекс анимации 2
                FSprite 16,      9,      3,     15,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_5_1          ; напровление 5, индекс анимации 1
                FSprite 14,      9,      3,     11,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_5_0          ; напровление 5, индекс анимации 0

._6_2           ; t - 1 (), d - 6 (left), s - 2 (attack)
                FSprite 12,      9,      3,     16,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_6_2          ; напровление 6, индекс анимации 2
                FSprite 12,      9,      3,     15,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_6_1          ; напровление 6, индекс анимации 1
                FSprite 12,      9,      3,     15,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_6_0          ; напровление 6, индекс анимации 0

._7_2           ; t - 1 (), d - 7 (up-left), s - 2 (attack)
                FSprite 16,     13,      3,     11,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_7_2          ; напровление 7, индекс анимации 2
                FSprite 16,     13,      3,     13,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_7_1          ; напровление 7, индекс анимации 1
                FSprite 14,     11,      3,     10,      0, PageSprites_0,    MemoryPage_4.Tank_Attack_7_0          ; напровление 7, индекс анимации 0
