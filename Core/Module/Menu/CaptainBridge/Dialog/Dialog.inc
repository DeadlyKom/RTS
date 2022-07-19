
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_

CHOICE_BIT      EQU 0x07                                                        ; бит обработки выбора

FUNCTION_BIT    EQU 0x07
SELECT_BIT      EQU 0x06
FUNCTION        EQU 1 << FUNCTION_BIT
SELECT          EQU 1 << SELECT_BIT


END_DIALOG      EQU #FF
FLAGS_MASK      EQU %11000000
FLAGS_MASK_INV  EQU (~FLAGS_MASK) & 0xFF

Dialog_0:    
.Primary        ; приветствие, информирование
                DB /*length*/   3
                DB /*indexes*/  0, 1, 2
                DB /*offset*/   .Tutorial-$
.Tutorial       ; выбора боевого опыта
                DB /*length*/   2 | SELECT
                DB /*indexes*/  3, 4
                DB /*choice*/   2
                DB /*offset*/   .Recruit-$
                DB /*offset*/   .Veteran-$
.Recruit        ; вариант "новичок"
                DB /*length*/   1
                DB /*indexes*/  5
                DB /*offset*/   .RecruitFinal-$
.Veteran        ; вариант "ветеран"
                DB /*length*/   1
                DB /*indexes*/  6
                DB /*offset*/   .VeteranFinal-$
.RecruitFinal   ; реакция выбора варианта "новичок"
                DB /*length*/   3 | FUNCTION
                DB /*indexes*/  7, 8, 9
                DW /*func*/     $                        
.VeteranFinal   ; реакция выбора варианта "ветеран"
                DB /*length*/   2 | FUNCTION
                DB /*indexes*/  10, 11
                DW /*func*/     $
.End            DB END_DIALOG

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_
