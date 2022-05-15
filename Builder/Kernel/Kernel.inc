
                ifndef _BUILDER_KERNEL_
                define _BUILDER_KERNEL_
; memory
SetPage         EQU Kernel.Memory.SetPage
SetPage0        EQU Kernel.Memory.SetPage0
SetPage1        EQU Kernel.Memory.SetPage1
SetPage3        EQU Kernel.Memory.SetPage3
SetPage4        EQU Kernel.Memory.SetPage4
SetPage5        EQU Kernel.Memory.SetPage5
SetPage6        EQU Kernel.Memory.SetPage6
SetPage7        EQU Kernel.Memory.SetPage7
ScrPageToC000   EQU Kernel.Memory.ScrPageToC000
ScrPageToC000_  EQU Kernel.Memory.ScrPageToC000_
MemcpyPages     EQU Kernel.Memcpy.Pages

                endif ; ~_BUILDER_KERNEL_
