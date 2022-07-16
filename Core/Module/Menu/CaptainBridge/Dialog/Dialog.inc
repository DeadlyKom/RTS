
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_
FUNCTION_BIT    EQU 0x07
SELECT_BIT      EQU 0x06
FUNCTION        EQU 1 << FUNCTION_BIT
SELECT          EQU 1 << SELECT_BIT

FLAGS_MASK      EQU %11000000
FLAGS_MASK_INV  EQU (~FLAGS_MASK) & 0xFF

Dialog_0:    
.Primary        DB /*length*/ 0x03,             /*indexes*/ 00, 01, 02, /*offset*/ $-.Tutorial              ; приветствие, информирование
.Tutorial       DB /*length*/ 0x02 | SELECT,    /*indexes*/ 03, 04,     /*offset*/ $-.Recruit, $-.Veteran   ; выбора боевого опыта
.Recruit        DB /*length*/ 0x01,             /*indexes*/ 05,         /*offset*/ $-.RecruitFinal          ; вариант "новичок"
.Veteran        DB /*length*/ 0x01,             /*indexes*/ 06,         /*offset*/ $-.VeteranFinal          ; вариант "ветеран"
.RecruitFinal   DB /*length*/ 0x00 | FUNCTION,  /*indexes*/ 07, 08, 09, /*func*/   $                        ; реакция выбора варианта "новичок"
.VeteranFinal   DB /*length*/ 0x00 | FUNCTION,  /*indexes*/ 10, 11,     /*func*/   $                        ; реакция выбора варианта "ветеран"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_
