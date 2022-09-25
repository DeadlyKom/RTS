
                ifndef _CONST_FILES_NAME_
                define _CONST_FILES_NAME_

                define KernelExt                        '#'
                define SystemExt                        'S'
                define GraphicsExt                      'G'
                define LanguageExt                      'L'
                define FontExt                          'F'
                define TextExt                          'T'
                define CodeExt                          'C'
                define LevelsExt                        'M'
                define TilemapExt                       'I'
                
                define BootNameTRD                      "boot.B"
                
                define KernelName                       "Kernel"
                define KernelNameTRD                    "Kernel.#"

                define GameMainName                     "#05"                   ; имя файла модуля "основной блок"
                define GameMainNameTRD                  "#05.C"                 ; имя файла с расширением модуля "основной блок"

                define GameUnitCodeName                 "#00"                   ; имя файла модуля "кода работы с юнитами"
                define GameUnitCodeNameTRD              "#00.C"                 ; имя файла с расширением модуля "кода работы с юнитами"

                define GameTilemapCodeName              "#01"                   ; имя файла модуля "код работы с тайлами"
                define GameTilemapCodeNameTRD           "#01.C"                 ; имя файла с расширением модуля "код работы с тайлами"

                define GameTilemapExName                "#07"                   ; имя файла модуля "работы с тайлами расширенние"
                define GameTilemapExNameTRD             "#07.C"                 ; имя файла с расширением модуля "работы с тайлами расширенние"

                define LevelsName                       "Levels"                ; имя файла массива уровней
                define LevelsNameTRD                    "Levels.M"              ; имя файла массива уровней уровней с расширением
                
                define FileSystemName                   "FS"
                define FileSystemNameTRD                "FS.#"
                
                define LoaderName                       "Loader"                ; имя загрузчика
                define LoaderNameTRD                    "Loader.S"              ; имя загрузчика

                define LanguageName                     "Language"              ; имя модуля языка
                define LanguageNameTRD                  "Language.L"            ; имя модуля языка

                ; fonts
                define FontRuName                       "Font Ru"               ; имя шрифта русского языка
                define FontRuNameTRD                    "Font Ru.F"             ; имя шрифта русского языка
                define FontSpName                       "Font Sp"               ; имя шрифта испанского языка
                define FontSpNameTRD                    "Font Sp.F"             ; имя шрифта испанского языка
                define FontEnName                       "Font En"               ; имя шрифта английского языка
                define FontEnNameTRD                    "Font En.F"             ; имя шрифта английского языка

                ; text
                define MenuTextRuName                   "Menu Ru"               ; имя файла русского языка меню
                define MenuTextRuNameTRD                "Menu Ru.T"             ; имя файла русского языка меню
                define MenuTextSpName                   "Menu Sp"               ; имя файла испанского языка меню
                define MenuTextSpNameTRD                "Menu Sp.T"             ; имя файла испанского языка меню
                define MenuTextEnName                   "Menu En"               ; имя файла английского языка меню
                define MenuTextEnNameTRD                "Menu En.T"             ; имя файла английского языка меню

                define MsgTextRuName                    "Msg Ru"                ; имя файла русского языка сообщений
                define MsgTextRuNameTRD                 "Msg Ru.T"              ; имя файла русского языка сообщений
                define MsgTextSpName                    "Msg Sp"                ; имя файла испанского языка сообщений
                define MsgTextSpNameTRD                 "Msg Sp.T"              ; имя файла испанского языка сообщений
                define MsgTextEnName                    "Msg En"                ; имя файла английского языка сообщений
                define MsgTextEnNameTRD                 "Msg En.T"              ; имя файла английского языка сообщений
                
                define MenuCoreName                     "M.Core"                ; имя файла основных функций работы с меню
                define MenuCoreNameTRD                  "M.Core.C"              ; имя файла основных функций работы с меню

                define MenuMainName                     "M.Main"                ; имя файла "главного меню"
                define MenuMainNameTRD                  "M.Main.C"              ; имя файла "главного меню"

                define MenuOptionsName                  "M.Option"              ; имя файла "меню настроек"
                define MenuOptionsNameTRD               "M.Option.C"            ; имя файла "меню настроек"

                define CaptainBridgeName                "M.CB"                  ; имя файла "капитанский мостик"
                define CaptainBridgeNameTRD             "M.CB.C"                ; имя файла "капитанский мостик"

                define CaptainBridgeGraphicsAName       "M.CBG"                 ; имя файла графики для "капитанский мостик"
                define CaptainBridgeGraphicsANameTRD    "M.CBG.G"               ; имя файла графики для "капитанский мостик"

                ; Tilemap
                define TilemapTestName                  "Test"                  ; имя файла тайловой карты "Test"
                define TilemapTestNameTRD               "Test.I"                ; имя файла с расширением тайловой карты "Test"

                define TilemapTutorialName              "Tutorial"              ; имя файла тайловой карты "Tutorial"
                define TilemapTutorialNameTRD           "Tutorial.I"            ; имя файла с расширением тайловой карты "Tutorial"

                ; Graphics
                define TilemapPack_1_1_Name             "Pack1.1"               ; имя файла графики тайловой карты "Пакет 1.1"
                define TilemapPack_1_1_NameTRD          "Pack1.1.G"             ; имя файла с расширением графики тайловой карты "Пакет 1.1"

                define TilemapPack_1_2_Name             "Pack1.2"               ; имя файла графики тайловой карты "Пакет 1.2"
                define TilemapPack_1_2_NameTRD          "Pack1.2.G"             ; имя файла с расширением графики тайловой карты "Пакет 1.2"

                define GraphicsPack_1_Name              "Pack1"                 ; имя файла графики "Пакет 1"
                define GraphicsPack_1_NameTRD           "Pack1.G"               ; имя файла с расширением графики "Пакет 1"

                endif ; ~_CONST_FILES_NAME_
