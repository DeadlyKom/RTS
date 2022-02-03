
                    ifndef _CORE_MODULE_AI_DEFINITION_
                    define _CORE_MODULE_AI_DEFINITION_

; ; behavior tree branch type
; BT_SELECTOR_TYPE    EQU 0x80
; BT_SEQUENCE_TYPE    EQU 0x40
; BT_TASK_TYPE        EQU 0x01
; BT_BREAK_TYPE       EQU 0x00

; ; behavior tree macros
; BT_TYPE             macro Type?
;                     DB Type? & 0xFF
;                     endm
; ; Selector
; ; выполняет последовательность задачь, пока какая-то из них не вернёт успешное выполнение
; BT_Selector:        macro Offset?
;                     BT_TYPE BT_SELECTOR_TYPE
;                     if ((Offset? - $) & 0xFF) >? 0
;                     DB (Offset? - $) & 0xFF
;                     else
;                     DB #01
;                     endif
;                     endm
; ; Sequence
; ; выполняет последовательность задачь, до тех пор, пока какая-то из них вернёт неудачу
; BT_Sequence         macro Offset?
;                     BT_TYPE BT_SEQUENCE_TYPE
;                     if ((Offset? - $) & 0xFF) >? 0
;                     DB (Offset? - $) & 0xFF
;                     else
;                     DB #01
;                     endif
;                     endm
; BT_Task             macro AddressTask?
;                     BT_TYPE BT_TASK_TYPE
;                     DW AddressTask? & 0xFFFF
;                     endm
; BT_Break            macro
;                     BT_TYPE BT_BREAK_TYPE
;                     endm

; behavior tree macros

; ; Selector
; ; выполняет последовательность задачь, пока какая-то из них не вернёт успешное выполнение
; BT_Selector:    macro ;Offset?
;                 DB LOW AI.Selector
;                 ; if ((Offset? - $) & 0xFF) >? 0
;                 ; DB (Offset? - $) & 0xFF
;                 ; else
;                 ; DB #01
;                 ; endif
;                 endm
; ; Sequence
; ; выполняет последовательность задачь, до тех пор, пока какая-то из них вернёт неудачу
; BT_Sequence     macro ;Offset?
;                 DB LOW AI.Sequence
;                 ; if ((Offset? - $) & 0xFF) >? 0
;                 ; DB (Offset? - $) & 0xFF
;                 ; else
;                 ; DB #01
;                 ; endif
;                 endm
; BT_Nested       macro Offset?
;                 DB LOW AI.Nested
;                 DB (Offset? - $) & 0xFF
;                 endm
; BT_Task         macro AddressTask?
;                 DB LOW AI.Task
;                 DW AddressTask? & 0xFFFF
;                 endm
; BT_Break        macro
;                 DB LOW AI.RunBTT.Exit
;                 endm

BT_ROOT         EQU 0x03 << 6
BT_SELECTOR     EQU 0x01 << 6
BT_SEQUENCE     EQU 0x02 << 6
BT_TASK         EQU 0x00 << 6

BT_Selector     macro Name?

                define __BehaviorTree_Name Name?
                lua allpass

                MacroName = sj.get_define("__BehaviorTree_Name")
                if MacroName == "Root" then
                    -- print (MacroName)
                    
                    Root = CreateNode(MacroName)
                else
                    MacroName = _c("Name?")
                    print(MacroName)
                    
                end

                endlua
                undefine __BehaviorTree_Name


                ; DB BT.Offset & 0xFF                     ; $
                ; DB (BT_ROOT | BT.IdxParent) & 0xFF      ; index parent
                endm              
BT_Sequence     macro
                DB 00 & 0xFF                     ; $
                DB (BT_SELECTOR | 00) & 0xFF  ; index parent                
                endm
BT_Task         macro
                
                endm

                endif ; ~ _CORE_MODULE_AI_DEFINITION_