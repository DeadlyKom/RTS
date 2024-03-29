
                    ifndef _STRUCTURE_PATHFINDING_
                    define _STRUCTURE_PATHFINDING_

; pathfinding flags
PF_IN_OPEN_LIST_BIT     EQU 7                                                   ; находится в открытом списке
PF_CLOSED_BIT           EQU 6
PF_IS_START_COORD_BIT   EQU 0                                                   ; это стартовая позиция (чтобы не производить сравнение координат)

PF_IN_OPEN_LIST         EQU 1 << PF_IN_OPEN_LIST_BIT
PF_CLOSED               EQU 1 << PF_CLOSED_BIT
PF_IS_START_COORD       EQU 1 << PF_IS_START_COORD_BIT


; данная структура хранится в памяти не линейно
; т.е. для перехода к следующему полю структуры приращаем старший байт адреса

                    struct FPFInfo
Flags               DB #00          ; pathfinding flags                 (0)
ParentCoord         FLocation       ;                                   (1,2)
OpenListIdx         DB #00          ; index in open list                (3)
G_Cost              DW #0000        ; distance from starting node       (4,5)
H_Cost              DW #0000        ; distance from end node            (6,7)
F_Cost              DW #0000        ; G_Cost + H_Cost                   (8,9)

                    ends

                    endif ; ~_STRUCTURE_PATHFINDING_