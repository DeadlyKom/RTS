; // Copyright 2021 Sergei Smirnov. All Rights Reserved.

                    ifndef _FPS_COUNTER_
                    define _FPS_COUNTER_

                    module FPS_Counter
IntTick:            LD A, (TicksCount)
                    INC A
                    CP 50
                    JR Z, .StoreFramerate
                    LD (TicksCount), A
                    RET

.StoreFramerate     LD A, (FramesCount_BCD)
                    LD (Result_BCD), A
                    XOR A
                    LD (TicksCount), A
                    LD (FramesCount_BCD), A
                    RET
FrameRendered:      LD A, (FramesCount_BCD)
                    ADD A, #01
                    DAA
                    LD (FramesCount_BCD), A
                    RET
Render_FPS:         LD A, #1E
                    CALL Console.At
                    LD A, (Result_BCD)
                    LD B, A
                    JP Console.Logb
TicksCount:         DB #00
FramesCount_BCD:    DB #00
Result_BCD:         DB #00

                    endmodule

                    endif ; ~_FPS_COUNTER_