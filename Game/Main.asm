    
            DEVICE ZXSPECTRUM128

            include "Include.inc"

            ORG EntryPointer
Main:
            DI
            ; LD SP, StackTop

            JR $
MainLength: EQU $-EntryPointer

            include "Builder.asm"
