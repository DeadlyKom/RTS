
                ifndef _CONST_LOADER_
                define _CONST_LOADER_

Page.Loader     EQU 0x05                                                        ; страница загрузчика
Adr.Loader      EQU MemBank_01_SCR                                              ; адрес загрузчика
Adr.Loader.Size EQU Loader.Size                                                 ; размер загрузчика

                endif ; ~_CONST_LOADER_
