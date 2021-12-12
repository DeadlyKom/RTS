
                        align 256
SCR_ADR_ROWS_TABLE:
.Count                  defl 0
OffsetTableByAnimIndex: dup 192
                        DW ((0xC0 | (SCR_ADR_ROWS_TABLE.Count & %00000111) | ((SCR_ADR_ROWS_TABLE.Count & %11000000) >> 3)) << 8) | ((SCR_ADR_ROWS_TABLE.Count & %00111000) << 2)
SCR_ADR_ROWS_TABLE.Count = SCR_ADR_ROWS_TABLE.Count + 1
                        edup