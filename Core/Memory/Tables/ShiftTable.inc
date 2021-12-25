
LocalVariableST:
.Shift                  defl 7
.Count                  defl 0

                        align 256
ShiftTable:
                        dup 7
LocalVariableST.Count = 0
                        dup 256
                        DB ((LocalVariableST.Count << LocalVariableST.Shift) >> 8) & 0xFF
LocalVariableST.Count = LocalVariableST.Count + 1
                        edup

LocalVariableST.Count = 0
                        dup 256
                        DB ((LocalVariableST.Count << LocalVariableST.Shift) >> 0) & 0xFF
LocalVariableST.Count = LocalVariableST.Count + 1
                        edup
LocalVariableST.Shift = LocalVariableST.Shift - 1
                        edup