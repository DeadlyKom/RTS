
                ifndef _BUILDER_KERNEL_
                define _BUILDER_KERNEL_
; memory switch page
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

; memory set
SafeFill_Screen EQU Kernel.Memset.SafeFill_Screen
SafeFill_4096   EQU Kernel.Memset.SafeFill_4096
SafeFill_2048   EQU Kernel.Memset.SafeFill_2048
SafeFill_768    EQU Kernel.Memset.SafeFill_768
SafeFill_256    EQU Kernel.Memset.SafeFill_256
SafeFill_192    EQU Kernel.Memset.SafeFill_192
SafeFill_128    EQU Kernel.Memset.SafeFill_128
SafeFill_32     EQU Kernel.Memset.SafeFill_32

; interrupt
RestoreRegister EQU Kernel.Interrupt.Handler.RestoreRegister
UserInterrupt   EQU Kernel.Interrupt.Handler.UserInterrupt
Interrupt_RET   EQU Kernel.Interrupt.Handler.RET
ReturnAddress   EQU Kernel.Interrupt.Handler.ReturnAddress
TickCounterRef  EQU Kernel.Interrupt.Handler.TickCounterPtr                     ; счётчик тиков 1/50
; input
Kempston
.CheckKeyState  EQU Kernel.Kempston.CheckKeyState
Keyboard
.CheckKeyState  EQU Kernel.Keyboard.CheckKeyState
Mouse
.CheckKeyState  EQU Kernel.Mouse.CheckKeyState
.PositionX      EQU Kernel.Mouse.PositionX
.PositionY      EQU Kernel.Mouse.PositionY
.PositionFlag   EQU Kernel.Mouse.PositionFlag
.SVK_LBUTTON    EQU Kernel.Mouse.SVK_LBUTTON
.SVK_RBUTTON    EQU Kernel.Mouse.SVK_RBUTTON
.SVK_MBUTTON    EQU Kernel.Mouse.SVK_MBUTTON

Cursor
.MoveUp         EQU Kernel.Input.Cursor.MoveUp
.MoveDown       EQU Kernel.Input.Cursor.MoveDown
.MoveLeft       EQU Kernel.Input.Cursor.MoveLeft
.MoveRight      EQU Kernel.Input.Cursor.MoveRight

; math
Math.Rand8      EQU Kernel.Math.Rand8

; draw
PixelAddress    EQU Kernel.Attribute.PixelAddress
PixelAttribute  EQU Kernel.Attribute.PixelAttribute
DrawSprite      EQU Kernel.Attribute.DrawSprite
DrawCharBoundary EQU Kernel.Attribute.DrawCharBoundary
ShiftTable      EQU Kernel.Tables.ShiftTable

; load modules
LoadModule
.Loader         EQU Kernel.Modules.Loader

; functions
Functions
.ChangeLanguage EQU Kernel.Functions.ChangeLanguage                             ; загрузка языковых шрифтов
.TextToBuffer   EQU Kernel.Functions.TextToBuffer
.StringToBuffer EQU Kernel.Functions.StringToBuffer

                endif ; ~_BUILDER_KERNEL_
