
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
; ReadByteToPage  EQU Kernel.Memory.ReadByteToPage
ScrPageToC000   EQU Kernel.Memory.ScrPageToC000
ScrFromPageC000 EQU Kernel.Memory.ScrFromPageC000
ScrPageToC000_  EQU Kernel.Memory.ScrPageToC000_
SwapScreens     EQU Kernel.Memory.SwapScreens
ShowBaseScreen  EQU Kernel.Memory.ShowBaseScreen
ShowShadowScreen EQU Kernel.Memory.ShowShadowScreen
MemcpyPages     EQU Kernel.Memcpy.Pages
FastLDIR        EQU Kernel.Memcpy.FastLDIR

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
Input
.CheckKeyState  EQU Kernel.Input.CheckKeyState
.JumpDefaulKeys EQU Kernel.Input.JumpDefaulKeys
Kempston
.CheckKeyState  EQU Kernel.Kempston.CheckKeyState
Keyboard
.CheckKeyState  EQU Kernel.Keyboard.CheckKeyState
.GetPressedKey  EQU Kernel.Keyboard.GetPressedKey
.WaitPressedKey EQU Kernel.Keyboard.WaitPressedKey
.WaitReleasedKey EQU Kernel.Keyboard.WaitReleasedKey                            ; ожидание отпускание ранее нажатой клавиши
.AnyKeyPressed  EQU Kernel.Keyboard.AnyKeyPressed                               ; проверка нажатия какая либо клавиши
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
Math
.Rand8          EQU Kernel.Math.Rand8
.Div8x8         EQU Kernel.Math.Div8x8

; decompressor
Decompressor
.Forward        EQU Kernel.Decompressor.Forward
.Backward       EQU Kernel.Decompressor.Backward

; draw
PixelAddressC   EQU Kernel.Attribute.PixelAddressC
PixelAddressP   EQU Kernel.Attribute.PixelAddressP
PixelAttribute  EQU Kernel.Attribute.PixelAttribute
DrawSpriteOne   EQU Kernel.Attribute.DrawSpriteOne
DrawSpriteTwo   EQU Kernel.Attribute.DrawSpriteTwo
DrawSpriteMono  EQU Kernel.Monochrome.DrawSpriteMono
DrawSpriteOR    EQU Kernel.Monochrome.DrawSpriteOR
DrawSpriteORXOR EQU Kernel.Monochrome.DrawSpriteORXOR
DrawStencilSpr  EQU Kernel.Attribute.DrawStencilSpr
DrawTileRows    EQU Kernel.Tilemap.DrawTileRows
DrawCharOne     EQU Kernel.Attribute.DrawCharOne
DrawCharTwo     EQU Kernel.Attribute.DrawCharTwo
ShiftTable      EQU Kernel.Tables.ShiftTable

; load modules
LoadModule
.Loader         EQU Kernel.Modules.Loader

; functions
Functions
.LoadFont       EQU Kernel.Functions.LoadFont                                   ; загрузка языковых шрифтов
.LaunchLevel    EQU Kernel.Functions.LaunchLevel                                ; запуск уровня
.AnimTile       EQU Kernel.Functions.AnimTile                                   ; анимация тайлов
.ShiftRenderBuf EQU Kernel.Functions.ShiftRenderBuf                             ; сдвиг буфера рендера
.MemcpyTilemap  EQU Kernel.Functions.MemcpyTilemap                              ; копирование видимой части тайловой карты в буфер
.TextToBuffer   EQU Kernel.Functions.TextToBuffer
.StringLength   EQU Kernel.Functions.StringLength
.WordLength     EQU Kernel.Functions.WordLength
.StringToBuffer EQU Kernel.Functions.StringToBuffer
.DrawCharToScr  EQU Kernel.Functions.DrawCharToScr

                endif ; ~_BUILDER_KERNEL_
