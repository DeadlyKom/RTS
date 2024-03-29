
                ifndef _CORE_MODULE_TRDOS_CONFIG_INCLUDE_
                define _CORE_MODULE_TRDOS_CONFIG_INCLUDE_

                module TRDOS
SECTOR_SIZE     EQU #0100                                                       ; размер сектора
EXE_CMD:        EQU #3D13                                                       ; выполнить команду TR-DOS, содержащую в регистре C

RD_SECTORS      EQU #05                                                         ; чтение группы секторов. в регистре 
                                                                                ; B-количество считываемых секторов,
                                                                                ; D-номер начального трека,
                                                                                ; E - начальный сектор, 
                                                                                ; HL-адрес буфера, в который производится чтение
RD_FILE_INFO    EQU #08                                                         ; чтение информации о файле. в регистре A предварительно помещается порядковый номер файла (0-127).
                                                                                ; из каталога диска 16 байт переносятся в область системных переменных TR-DOS.
                                                                                ; не имеет значения, стерт ли этот файл или нет и существует ли он вообще.
                                                                                ; адреса соответствующих системных переменных приведены ниже.
FIND_FILE       EQU #0A                                                         ; поиск файла по имени, заданному в области системных переменных.
                                                                                ; номер найденного файла возвращается в регистр C.
                                                                                ; можно искать файлы по имени и типу (9 байт) или по любому  количеству первых байтов имени (от 1 до 16),
                                                                                ; следует лишь указать  количество символов в системной переменной по адресу  #5D06.
LOAD_VERIFY     EQU #0E                                                         ; чтение / проверка  файла. имя и тип файла - в области системных переменных.
                                                                                ; при A = #00, адрес  загрузки  файла  берется с директории 
                                                                                ; при A = #03, в HL адрес загрузки, в DE длина
                                                                                ; при A = #FF, в HL адрес загрузки, длина берётся из директории.
                                                                                ; байт поадресу 23801 определяет тип операции: #00 - LOAD, #FF - VERIFY.
SET_NAME:       EQU #13                                                         ; в адрес #5CDD переписываются 16 байт информации из памяти, адресуемой регистровой парой HL


; переменные
HEAD:           EQU #5CDD                                                       ; имя файла
TYPE:           EQU #5CE5                                                       ; тип файла
START:          EQU #5CE6                                                       ; старт файла
SIZE_B:         EQU #5CE8                                                       ; размер файла в байтах
SIZE_S:         EQU #5CEA                                                       ; размер файла в секторах
FIRST_S:        EQU #5CEB                                                       ; номер первого сектора файла
FIRST_TR:       EQU #5CEC                                                       ; номер первого трека файла
CUR_SEC:        EQU #5CF4                                                       ; следующий сектор + 1
CUR_TRK:        EQU #5CF5                                                       ; следующий трек + 1

                endmodule

                endif ; ~ _CORE_MODULE_TRDOS_CONFIG_INCLUDE_