
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

Screen:
.PageToC000     EQU Kernel.Memory.ScrPageToC000                                 ; установка страницы видимого экрана
.FromPageC000   EQU Kernel.Memory.ScrFromPageC000                               ; установка экрана расположенного в #C000
.PageToC000_    EQU Kernel.Memory.ScrPageToC000_                                ; установка страницы невидимого экрана
.Swap           EQU Kernel.Memory.SwapScreens                                   ; переключение экранов
.ShowBase       EQU Kernel.Memory.ShowBaseScreen                                ; отображение базового экрана
.ShowShadow     EQU Kernel.Memory.ShowShadowScreen                              ; отображение теневого экрана

Memcpy:
.Pages          EQU Kernel.Memcpy.Pages
.FastLDIR       EQU Kernel.Memcpy.FastLDIR
.Sprite         EQU Kernel.Memcpy.Sprite

; memory set
SafeFill:
.Screen         EQU Kernel.Memset.SafeFill_Screen
.b4096          EQU Kernel.Memset.SafeFill_4096
.b2048          EQU Kernel.Memset.SafeFill_2048
.b768           EQU Kernel.Memset.SafeFill_768
.b256           EQU Kernel.Memset.SafeFill_256
.b192           EQU Kernel.Memset.SafeFill_192
.b128           EQU Kernel.Memset.SafeFill_128
.b32            EQU Kernel.Memset.SafeFill_32

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
Convert:
.CharToScreen   EQU Kernel.Utils.PixelAddressC
.PixelToScreen  EQU Kernel.Utils.PixelAddressP
.ToAttribute    EQU Kernel.Utils.PixelAttribute

DrawSpriteOne   EQU Kernel.Charboundary.DrawSpriteOne
DrawSpriteTwo   EQU Kernel.Charboundary.DrawSpriteTwo
DrawCharOne     EQU Kernel.Charboundary.DrawCharOne
DrawCharTwo     EQU Kernel.Charboundary.DrawCharTwo
DrawStencilSpr  EQU Kernel.Charboundary.DrawStencilSpr

DrawSpriteMono  EQU Kernel.Monochrome.DrawSpriteMono
DrawSpriteOR    EQU Kernel.Monochrome.DrawSpriteOR
DrawSpriteORXOR EQU Kernel.Monochrome.DrawSpriteORXOR

DrawTileRows    EQU Kernel.Tilemap.DrawTileRows
DrawUnit        EQU Kernel.Sprite.DrawUnit


; load modules
LoadModule
.Loader         EQU Kernel.Modules.Loader

; functions
Functions
.LoadFont       EQU Kernel.Functions.LoadFont                                   ; загрузка языковых шрифтов
.LaunchLevel    EQU Kernel.Functions.LaunchLevel                                ; запуск уровня
.AnimTile       EQU Kernel.Functions.AnimTile                                   ; анимация тайлов
; .Sampling       EQU Kernel.Functions.Sampling                                   ; выборка анимации тайлов
.ShiftRenderBuf EQU Kernel.Functions.ShiftRenderBuf                             ; сдвиг буфера рендера
.MemcpyTilemap  EQU Kernel.Functions.MemcpyTilemap                              ; копирование видимой части тайловой карты в буфер
.TextToBuffer   EQU Kernel.Functions.TextToBuffer
.StringLength   EQU Kernel.Functions.StringLength
.WordLength     EQU Kernel.Functions.WordLength
.StringToBuffer EQU Kernel.Functions.StringToBuffer
.DrawCharToScr  EQU Kernel.Functions.DrawCharToScr

.SpawnUnit      EQU Kernel.Functions.SpawnUnit                                  ; спавн юнита

; tables
Table:
.Shift          EQU Kernel.Tables.ShiftTable
.ScreenAddress  EQU Kernel.Tables.ScreenAddress
.MultiplySprite EQU Kernel.Tables.MultiplySprite

; debug
                ifdef _DEBUG
Console:
.DrawChar       EQU Kernel.Console.DrawChar
.DrawByte       EQU Kernel.Console.DrawByte
.SetCursor      EQU Kernel.Console.SetCursor
.SetScreenAdr   EQU Kernel.Console.SetScreenAdr
.SetAttribute   EQU Kernel.Console.SetAttribute
FPS_Counter:
.Tick           EQU Kernel.FPS_Counter.Tick
.Frame          EQU Kernel.FPS_Counter.Frame
.Render         EQU Kernel.FPS_Counter.Render

                endif

                endif ; ~_BUILDER_KERNEL_
