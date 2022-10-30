
                ifndef _MODULE_GAME_RENDER_SWAP_SCREEN_
                define _MODULE_GAME_RENDER_SWAP_SCREEN_
; -----------------------------------------
; смена экранов 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Swap:           ifdef _DEBUG
                CALL FPS_Counter.Render
                endif

                CALL Screen.Swap

                ; сортировка видимых объектов
                LD DE, SortBuffer
                CALL Functions.VisibleUnits                                     ; получение массив видимых юнитов (отсортерован по вертикали)
                LD A, D
                LD (DrawUnits.Array), A

;                 ; подсчёт дельты значения 
;                 LD HL, (TickCounterRef)
; .OldTickCounter EQU $+1
;                 LD DE, #0000
;                 LD (.OldTickCounter), HL
;                 OR A
;                 EX DE, HL
;                 SBC HL, DE
;                 LD A, L
;                 LD (GameVar.DeltaTime), A

                RET

 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
