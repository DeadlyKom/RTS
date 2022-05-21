
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_VARIABLES_
                define _CORE_MODULE_FILE_SYSTEM_BASE_VARIABLES_

                struct FVariables
; PackageAddress  FValue                                                          ; переменная для загрузки списка файла,
;                                                                                 ; адрес пакета файлов FFileArea
NumFilesPackage FValue                                                          ; переменная для загрузки списка файла,
                                                                                ; количество файлов в пакете
PackageSizeSec  DB #00                                                          ; переменная для загрузки списка файла,
                                                                                ; хранит общий размер загружаемых секторов
FuncProgress    FValue                                                          ; переменная для загрузки списка файла,
                                                                                ; адрес функции отображения прогресса загрузки
Progress        FValue                                                          ; переменная для загрузки списка файла,
                                                                                ; хранит текущий прогресс загрузки пакета файлов
ProgressStep    FValue                                                          ; переменная для загрузки списка файла,
                                                                                ; хранит значение приращения прогресса в виде Fix8.8
                ends

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_VARIABLES_
