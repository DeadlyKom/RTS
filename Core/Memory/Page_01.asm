
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1

                ORG FileSystemPtr

                include "../Module/FileSystem/Include.inc"
                include "../Module/Initialize/Include.inc"
FileSystem.End:


                module MemoryPage_1

                endmodule

FileSystem_S    EQU FileSystem.End - FileSystemPtr
StartPage_1     EQU FileSystemPtr
SizePage_1:     EQU FileSystem_S

                endif ; ~_CORE_MEMORY_PAGE_01_
