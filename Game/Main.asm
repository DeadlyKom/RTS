    
            DEVICE ZXSPECTRUM128

            include "Include.inc"

            ORG EntryPointer
Main:       JR $
            DI
            LD SP, StackTop

            XOR A
            LD (HL), A
            JR $
MainEnd:
            include "Builder.asm"
