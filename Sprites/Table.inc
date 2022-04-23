    
                ifndef _SPRITES_TABLE_
                define _SPRITES_TABLE_
Sprite_Cursor_Table:
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_0    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_1    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_2    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_3    ; 
                
                include "Units/Infantry/Sprite.inc"
                include "Units/Tank/Sprite.inc"

; ----------------------------------------------------------------------------------------
; Note:
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   |  0 |  0 |  0 |  0 | T4 | T3 | T2 | T1 |   | T0 | D2 | D1 | D0 | S2 | S1 | S0 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   T4-T0 - unit type:
;             0 - Infantry
;             1 - Tank
;   D2-D0 - unit direction:
;           000 - up
;           001 - up-right
;           010 - right
;           011 - down-right
;           100 - down
;           101 - down-left
;           110 - left
;           111 - up-left
;   S2-S0 - unit state:
;           00 - idle
;           01 - move
;           10 - attack
;           11 - ?
;
;   the animation goes in order, from the current address
;
; ----------------------------------------------------------------------------------------
SpritesTable:   include "Units/Infantry/Table.inc"
                include "Units/Tank/Table.inc"
 
                endif ; ~_SPRITES_TABLE_
