STOP_INC_BIT    EQU 2                                                           ; флаг блокировки инкремента анимации
STOP_DEC_BIT    EQU 3                                                           ; флаг блокировки декремента фнимации

STOP_INC        EQU 1 << STOP_INC_BIT
STOP_DEC        EQU 1 << STOP_DEC_BIT

ANIM_NUM_2      EQU 0x00                                                        ; две анимации 
ANIM_NUM_3      EQU 0x01                                                        ; три анимации
ANIM_NUM_4      EQU 0x02                                                        ; четыре анимации
ANIM_NUM_X      EQU 0x03                                                        ; количество анимации не определено
AnimCountTable: ; InfantrySprite
                DB (ANIM_NUM_4 << 4)              | (ANIM_NUM_4 << 0)           ; UNIT_STATE_MOVE | UNIT_STATE_IDLE
                DB ((STOP_INC | ANIM_NUM_4) << 4) | (ANIM_NUM_2 << 0)           ; UNIT_STATE_DEAD | UNIT_STATE_ATTACK
                DB (ANIM_NUM_X << 4)              | (ANIM_NUM_X << 0)           ; ..              | ..
                DB (ANIM_NUM_X << 4)              | (ANIM_NUM_X << 0)           ; ..              | ..

                ; TankSprite
                DB (ANIM_NUM_3 << 4) | (ANIM_NUM_X << 0)                        ; UNIT_STATE_MOVE | UNIT_STATE_IDLE
                DB (ANIM_NUM_X << 4) | (ANIM_NUM_X << 0)                        ; UNIT_STATE_DEAD | UNIT_STATE_ATTACK
                DB (ANIM_NUM_X << 4) | (ANIM_NUM_X << 0)                        ; ..              | ..
                DB (ANIM_NUM_X << 4) | (ANIM_NUM_X << 0)                        ; ..              | ..