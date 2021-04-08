                ifndef _EDITOR_
                define _EDITOR_

                include "../Core/Memory/Include.inc"
Editor:         LD HL, MemoryPage_0.MenuSprites + 10
                HALT
                CALL MemoryPage_2.DisplayTileMap;  печать экрана
                CALL Scroll
                CALL Cursor
                CALL CopyShadow


                CALL CtrMouse
                ld hl,(MemoryPage_5.TileMapPtr)

                
                ld hl,#7000
                
                ld (hl),#01+#80
                JP Editor
        ; карта в памяти page 05  addres #7000 

Scroll:         LD BC, (MousePosition)
                LD A,C
                CP 248
                CALL NC,S_Right
                LD A,C
                CP 0
                CALL Z,S_Left
                LD A,B
                CP 191
                CALL NC,S_Down
                LD A,B
                CP 0
                CALL Z,S_Up
                RET

S_Up:        
                LD HL,(MemoryPage_5.TileMapPtr)
                LD A,(StopY)
                CP 0
                RET Z
                DEC A
                LD (StopY),A
                AND A
                LD DE,64
                SBC HL,DE
                LD (MemoryPage_5.TileMapPtr),HL
                RET

S_Down:        
                LD HL,(MemoryPage_5.TileMapPtr)
                LD A,(StopY)
                CP 64-12
                RET Z
                INC A
                LD (StopY),A
                LD DE,64
                ADD HL,DE
                LD (MemoryPage_5.TileMapPtr),HL
                RET
S_Left:        
                LD HL,(MemoryPage_5.TileMapPtr)
                LD A,(StopX)
                CP 0
                RET Z
                DEC A
                LD (StopX),A
                DEC HL
                LD (MemoryPage_5.TileMapPtr),HL
                RET
S_Right:        
                LD HL,(MemoryPage_5.TileMapPtr)
                LD A,(StopX)
                CP 64-16
                RET Z
                INC A
                LD (StopX),A
                INC HL
                LD (MemoryPage_5.TileMapPtr),HL
                RET

Cursor:         LD BC, (MousePosition);  обработка курсора
                LD A,C
                CP 256-8
                CALL NC,StopCur
                CALL MemoryPage_2.DrawCursor; печать курсора
                RET
StopCur:        LD C,248
                LD (MousePosition),BC
                RET
CtrMouse:       LD A,1
                CALL GetMouseKeyState
                RET NZ
                LD HL,(MemoryPage_5.TileMapPtr)
                LD BC,(MousePosition)
                SRL B
                SRL B
                SRL B
                SRL B
                LD A,B
                LD C,A
                LD B,A
                LD DE,64
Loop            ADD HL,DE
                DJNZ Loop

               ; ADD HL,BC 
                LD BC,(MousePosition)
                SRL C
                SRL C
                SRL C
                SRL C
                LD B,0
                ADD HL,BC
                LD (HL),128
                RET




Chek:           LD A,R;  для быстрого чека меняем бордюр
                OUT (#FE),A
                RET
CopyShadow:     LD BC, PORT_7FFD; переключаем экран
                LD A, MemoryPage_ShadowScreen   
                OUT (C), A
                CALL MemoryPage_7.CopyScreen
                RET
Sprite:         DEFB #00; номер спрайта который выводим
StopX           DEFB 0
StopY           DEFB 0

                endif ; ~_INPUT_KEYBOARD_INCLUDE_