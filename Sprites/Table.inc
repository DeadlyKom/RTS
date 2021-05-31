    
                ifndef _SPRITES_TABLE_
                define _SPRITES_TABLE_
Sprite_Cursor_Table:
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_0    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_1    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_2    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_3    ; 

; ----------------------------------------------------------------------------------------
; Note:
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   |  0 |  0 |  0 |  0 |  0 | T4 | T3 | T2 |   | T1 | T0 | D2 | D1 | D0 | S1 | S0 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   T4-T0 - unit type:
;             0 - Infantry
;             1 - 
;   D2-D0 - unit direction:
;           000 - up
;           001 - up-right
;           010 - right
;           011 - down-right
;           100 - down
;           101 - down-left
;           110 - left
;           111 - up-left
;   S1,S0 - unit state:
;           00 - idle
;           01 - move
;           10 - attack
;           11 - ?
;
;   the animation goes in order, from the current address
;
; ----------------------------------------------------------------------------------------
SpritesTable:   
                DW #0000                                ; t - 0 (infantry),     d - 0 (up),         s - 0 (idle)
                DW .Infantry_0_1                        ; t - 0 (infantry),     d - 0 (up),         s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 0 (up),         s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 0 (up),         s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 1 (up-right),   s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 1 (up-right),   s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 1 (up-right),   s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 1 (up-right),   s - 3 (?)
                
                DW #0000                                ; t - 0 (infantry),     d - 2 (right),      s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 2 (right),      s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 2 (right),      s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 2 (right),      s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 3 (down-right), s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 3 (down-right), s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 3 (down-right), s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 3 (down-right), s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 4 (down),       s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 4 (down),       s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 4 (down),       s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 4 (down),       s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 5 (down-left),  s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 5 (down-left),  s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 5 (down-left),  s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 5 (down-left),  s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 6 (left),       s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 6 (left),       s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 6 (left),       s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 6 (left),       s - 3 (?)

                DW #0000                                ; t - 0 (infantry),     d - 7 (up-left),    s - 0 (idle)
                DW #0000                                ; t - 0 (infantry),     d - 7 (up-left),    s - 1 (move)
                DW #0000                                ; t - 0 (infantry),     d - 7 (up-left),    s - 2 (attack)
                DW #0000                                ; t - 0 (infantry),     d - 7 (up-left),    s - 3 (?)

.Infantry_0_1   ; t - 0 (), d - 0 (up), s - 1 (move)
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_0   ; напровление 0, индекс анимации 0
                FSprite 16,     0,      16,     8,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_1   ; напровление 0, индекс анимации 1
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_2   ; напровление 0, индекс анимации 2
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_3   ; напровление 0, индекс анимации 3

                endif ; ~_SPRITES_TABLE_
