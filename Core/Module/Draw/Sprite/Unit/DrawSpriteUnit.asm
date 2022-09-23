
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
; -----------------------------------------
; отображение спрайта без атрибутов
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; переход в зависимости от типа юнита
                LD A, (IX + FUnit.Type)                                         ; получим тип юнита
                AND IDX_UNIT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; 0
                JP DrawInfantry
                DB #00                                                          ; dummy
                ; 1
                JP DrawTank
                DB #00                                                          ; dummy
                ; 2
                JP $
                DB #00                                                          ; dummy
                ; 3
                JP $
                DB #00                                                          ; dummy
                ; 4
                JP $
                DB #00                                                          ; dummy
                ; 5
                JP $
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JP DrawShuttle

                display " - Draw Sprite Unit: \t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
