
                        page 0
                
                        ORG #4000
Size_0                  EQU ((SizePage_0 % 256 > 0) & 0x01) + (SizePage_0 >> 8)
Size_1                  EQU ((SizePage_1 % 256 > 0) & 0x01) + (SizePage_1 >> 8)
Size_2                  EQU ((SizePage_2 % 256 > 0) & 0x01) + (SizePage_2 >> 8)
Size_3                  EQU ((SizePage_3 % 256 > 0) & 0x01) + (SizePage_3 >> 8)
Size_4                  EQU ((SizePage_4 % 256 > 0) & 0x01) + (SizePage_4 >> 8)
Size_5                  EQU ((SizePage_5 % 256 > 0) & 0x01) + (SizePage_5 >> 8)
Size_6                  EQU ((SizePage_6 % 256 > 0) & 0x01) + (SizePage_6 >> 8)
Size_7                  EQU ((SizePage_7 % 256 > 0) & 0x01) + (SizePage_7 >> 8)

TilemapAddress          EQU MemoryPage_1.Map.Tilemap
TilemapSize             EQU MemoryPage_1.MapSize
OtherAddress            EQU MemoryPage_1.Map.Tilemap + TilemapSize
WaypointsSequenceSize   EQU WaypointArrayPtr - WaypointsSequencePtr
WayPointsSize           EQU SurfacePropertyPtr - WaypointArrayPtr
SurfPropSize            EQU TilemapTableAddress - SurfacePropertyPtr
TilemapTableAdrSize     EQU UnitArrayPtr - TilemapTableAddress
UnitArraySize           EQU 0x10000 - UnitArrayPtr
Page_MapSize            EQU TilemapSize + Others_S + WaypointsSequenceSize + WayPointsSize + SurfPropSize + TilemapTableAdrSize + UnitArraySize

Size_2_Real             EQU SizePage_2 + 768 ; 768 = (Page_2.SharedBuffer + Page_2.RenderBuffer + Page_2.TilemapBuffer)

                        module Boot                                     ; #5D40
Basic:                  DB #00, #0A                                     ; номер строки 10
                        DW EndBoot - StartBoot + 2                      ; длина строки
                        DB #EA                                          ; команда REM
StartBoot:              DI
                        LD A, %00010000
                        LD (MemoryPageRef), A
                        LD SP, StackTop
                        ; Чтение данных в 0 страницу
                        SeMemoryPage 0, PAGE_0_ID
                        LD HL, Page_0                                   ; загружаем по адресу Page_0
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_0                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 1 страницу
                        SeMemoryPage 1, PAGE_1_ID
                        LD HL, Page_1                                   ; загружаем по адресу Page_1
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_1                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 2 страницу
                        ; SeMemoryPage 2
                        LD HL, Page_2                                   ; загружаем по адресу Page_2
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_2                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 3 страницу
                        SeMemoryPage 3, PAGE_3_ID
                        LD HL, Page_3                                   ; загружаем по адресу Page_3
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_3                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 4 страницу
                        SeMemoryPage 4, PAGE_4_ID
                        LD HL, Page_4                                   ; загружаем по адресу Page_4
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_4                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 6 страницу
                        SeMemoryPage 6, PAGE_6_ID
                        LD HL, Page_6                                   ; загружаем по адресу Page_6
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_6                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 7 страницу
                        SeMemoryPage 7, PAGE_7_ID
                        LD HL, Page_7                                   ; загружаем по адресу Page_7
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_7                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        CALL #3D13                                      ; переход в TR-DOS
                        ; Чтение данных в 5 страницу
                        ; SeMemoryPage 5
                        LD HL, Game.EntryPoint
                        PUSH HL
                        LD HL, Page_5                                   ; загружаем по адресу Page_5
                        LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                        LD B, Size_5                                    ; регистр B содержит кол-во секторов
                        LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                        JP #3D13                                        ; переход в TR-DOS                
EndBoot:
                        DB #0D                                          ; конец строки

                        DB #00, #14                                     ; номер строки 20
                        DB #2A, #00                                     ; длина строки 42 байта
                        DB #F9                                          ; RANDOMIZE
                        DB #C0                                          ; USE
                        DB #28                                          ; (
                        DB #BE                                          ; PEEK
                        DB #B0                                          ; VAL
                        DB #22                                          ; "
                        DB #32, #33, #36, #33, #36                      ; 23636
                        DB #22                                          ; "
                        DB #2A                                          ; *
                        DB #32, #35, #36                                ; 256
                        DB #0E, #00, #00, #00, #01, #00                 ; значение 256
                        DB #2B                                          ; +
                        DB #BE                                          ; PEEK
                        DB #B0                                          ; VAL
                        DB #22                                          ; "
                        DB #32, #33, #36, #33, #35                      ; 23635
                        DB #22                                          ; "
                        DB #2B                                          ; +
                        DB #35                                          ; 5
                        DB #0E, #00, #00, #05, #00, #00                 ; значение 5
                        DB #29                                          ; )
                        DB #0D                                          ; конец строки
EndBasic:
                        endmodule

                        display "-------------------------------------------------------------------------------------------------------------------------------"
                        display "Building the TRD-image of the \'", TRD_FILENAME, "\' project ..."
                        display "Boot  :  ", /A, Boot.Basic, " = [ ", /D, Boot.EndBasic - Boot.Basic, " bytes ]"
                        display "Page 0:  ", /A, Page_0, " = busy [ ", /D, SizePage_0, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - SizePage_0 - Page_0 & 0x3FFF, " bytes ]     \t |  ", /D, (SizePage_0 - Page_0 & 0x3FFF) * 100 / #4000, " % occupied", "\t graphic #01"
                        display "Page 1:  ", /A, Page_1, " = busy [ ", /D, Page_MapSize, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - Page_MapSize - Page_1 & 0x3FFF, " bytes ]     \t |  ", /D, (Page_MapSize - Page_1 & 0x3FFF) * 100 / #4000, " % occupied", "\t map & data units"
                        display "Page 2:  ", /A, Page_2, " = busy [ ", /D, Size_2_Real, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - Size_2_Real - Page_2 & 0x3FFF, " bytes ]     \t |  ", /D, (Size_2_Real - Page_2 & 0x3FFF) * 100 / #4000, " % occupied", "\t code"
                        display "Page 3:  ", /A, Page_3, " = busy [ ", /D, SizePage_3, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - SizePage_3 - Page_3 & 0x3FFF, " bytes ]     \t |  ", /D, (SizePage_3 - Page_3 & 0x3FFF) * 100 / #4000, " % occupied", "\t music"
                        display "Page 4:  ", /A, Page_4, " = busy [ ", /D, SizePage_4, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - SizePage_4 - Page_4 & 0x3FFF, " bytes ]     \t |  ", /D, (SizePage_4 - Page_4 & 0x3FFF) * 100 / #4000, " % occupied", "\t graphic #02"
                        display "Page 5:  ", /A, Page_5, " = busy [ ", /D, SizePage_5, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - SizePage_5 - Page_5 & 0x3FFF, " bytes ]     \t |  ", /D, (SizePage_5 - Page_5 & 0x3FFF) * 100 / #4000, " % occupied", "\t sprite table"
                        display "Page 6:  ", /A, Page_6, " = busy [ ", /D, SizePage_6, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - SizePage_6 - Page_6 & 0x3FFF, " bytes ]     \t |  ", /D, (SizePage_6 - Page_6 & 0x3FFF) * 100 / #4000, " % occupied", "\t graphic #03"
                        display "Page 7:  ", /A, Page_7 - #1B00, " = busy [ ", /D, SizePage_7_Real, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - (SizePage_7_Real + 0x1B00), " bytes ]     \t |  ", /D, (SizePage_7_Real + 0x1B00) * 100 / #4000, " % occupied", "\t graphic #04"
                        display "-------------------------------------------------------------------------------------------------------------------------------"
                        display "Building the TRD-image of the \'", TRD_FILENAME, "\' maps ..."
                        display "Map 'Draft' :  \t\t", /A, TilemapAddress, " = busy [ ", /D, TilemapSize, " bytes ]", "\t /    RAM space [ ", /D, 0x4000 - TilemapSize, " bytes ]     \t |  ", /D, TilemapSize * 100 / #4000, " % occupied"
                        display "Other : \t\t\t", /A, OtherAddress, " = busy [ ", /D, Others_S, " bytes  ]"
                        display "Waypoints Sequence : \t\t", /A, WaypointsSequencePtr, " = busy [ ", /D, WaypointsSequenceSize, " bytes ]"
                        display "Waypoint Array : \t\t", /A, WaypointArrayPtr, " = busy [ ", /D, WayPointsSize, " bytes  ]"
                        display "Surface Property : \t\t", /A, SurfacePropertyPtr, " = busy [ ", /D, SurfPropSize, " bytes  ]"
                        display "Tilemap table address : \t", /A, TilemapTableAddress, " = busy [ ", /D, TilemapTableAdrSize, " bytes  ]"
                        display "Unit Array : \t\t\t", /A, UnitArrayPtr, " = busy [ ", /D, UnitArraySize, " bytes ]"
                        display "\t\t\t---------------------------------------------------------------------------------------------------------"
                        display "Total Size : \t\t\t",  "\t\t\t\t\t\t\t\t\t\t    ", /D, Page_MapSize * 100 / #4000, " % occupied"
                        display "-------------------------------------------------------------------------------------------------------------------------------"

                        emptytrd TRD_FILENAME
                        savetrd  TRD_FILENAME, "boot.B", Boot.Basic, Boot.EndBasic - Boot.Basic
                        page 0
                        savetrd  TRD_FILENAME, "Page0.C", Page_0, SizePage_0        ; bank 03
                        page 1
                        savetrd  TRD_FILENAME, "Page1.C", Page_1, SizePage_1        ; bank 03
                        ; page 1
                        ; savetrd  TRD_FILENAME, "Map 1.C", TileMap, SizePage_1_Map   ; bank 01
                        page 2
                        savetrd  TRD_FILENAME, "Page2.C", Page_2, SizePage_2        ; bank 02
                        page 3
                        savetrd  TRD_FILENAME, "Page3.C", Page_3, SizePage_3        ; bank 03
                        page 4
                        savetrd  TRD_FILENAME, "Page4.C", Page_4, SizePage_4        ; bank 03 
                        page 6
                        savetrd  TRD_FILENAME, "Page6.C", Page_6, SizePage_6        ; bank 03
                        page 7
                        savetrd  TRD_FILENAME, "Page7.C", Page_7, SizePage_7        ; bank 03 
                        page 5
                        savetrd  TRD_FILENAME, "Page5.C", Page_5, SizePage_5        ; bank 01
