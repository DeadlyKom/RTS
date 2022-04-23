TankSprite:
                ; Move

._0_1           ; t - 1 (), d - 0 (up), s - 1 (move)
                FSprite 18,     9,      3,      12,      MemoryPage_4.Tank_Move_0_0_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 0
                FSprite 18,     9,      3,      12,      MemoryPage_4.Tank_Move_0_1_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 1
                FSprite 18,     9,      3,      12,      MemoryPage_4.Tank_Move_0_2_S,  PageSprites_0 | FSSF_MASK,  MemoryPage_4.Tank_Move_0_0_M    ; напровление 0, индекс анимации 2

._1_1           ; t - 1 (), d - 1 (up-right), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_1_0   ; напровление 1, индекс анимации 0
;                 FSprite 16-4,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_1_1   ; напровление 1, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_1_2   ; напровление 1, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_1_3   ; напровление 1, индекс анимации 3

._2_1           ; t - 1 (), d - 2 (right), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_2_0   ; напровление 2, индекс анимации 0
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_2_1   ; напровление 2, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_2_2   ; напровление 2, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      2,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_2_3   ; напровление 2, индекс анимации 3

._3_1           ; t - 1 (), d - 3 (down-right), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_3_0   ; напровление 3, индекс анимации 0
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_3_1   ; напровление 3, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_3_2   ; напровление 3, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_3_3   ; напровление 3, индекс анимации 3

._4_1           ; t - 1 (), d - 4 (down), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_4_0   ; напровление 4, индекс анимации 0
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_4_1   ; напровление 4, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_4_2   ; напровление 4, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_4_3   ; напровление 4, индекс анимации 3

._5_1           ; t - 1 (), d - 5 (down-left), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_5_0   ; напровление 5, индекс анимации 0
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_5_1   ; напровление 5, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_5_2   ; напровление 5, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_5_3   ; напровление 5, индекс анимации 3

._6_1           ; t - 1 (), d - 6 (left), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_6_0   ; напровление 6, индекс анимации 0
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_6_1   ; напровление 6, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_6_2   ; напровление 6, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      2,     12,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_6_3   ; напровление 6, индекс анимации 3

._7_1           ; t - 1 (), d - 7 (up-left), s - 1 (move)
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_7_0   ; напровление 7, индекс анимации 0
;                 FSprite 16-4,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_7_1   ; напровление 7, индекс анимации 1
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_7_2   ; напровление 7, индекс анимации 2
;                 FSprite 16-2,     8-1+4,      1,      4,      0, PageSprites_0,    MemoryPage_4.SolderA_Move_7_3   ; напровление 7, индекс анимации 3
