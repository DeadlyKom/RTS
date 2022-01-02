
                ifndef _GAME_MAP_INFO_INCLUDE_
                define _GAME_MAP_INFO_INCLUDE_

                ORG #4000

                module MapInfo
START:          ; метка определения начала блока
                FMap {{"Map"}, 'C', {64, 64}, {0, 0} }
END:            ; метка определения конец блока

SIZE:           EQU END - START

                endmodule

                savetrd  TRD_FILENAME, MAP_INFO_FILENAME, #4000, MapInfo.SIZE

                endif ; ~ _GAME_MAP_INFO_INCLUDE_