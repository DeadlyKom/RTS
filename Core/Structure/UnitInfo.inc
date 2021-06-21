
                    ifndef _STRUCTURE_UNIT_
                    define _STRUCTURE_UNIT_

; unit types
Infantry            EQU 0x01
Ganner              EQU 0x02
HeavyGunner         EQU 0x03
Sniper              EQU 0x04
Engineer            EQU 0x05
ArmoredCarrier      EQU 0x06
Tank                EQU 0x07

; effects flags (buffs/debuffs)
EF_SLOW             EQU 0x01                        ; эффект замедления

; behavior flags
BF_MOVE             EQU 0x01                        ; объект движется
BF_ATTACK           EQU 0x02                        ; объект атакует
BF_FLY              EQU 0x04                        ; объект в полёте
BF_REGENERATION     EQU 0x08                        ; объект в состоянии регенерации
BF_SELECTED         EQU 0x80                        ; объект выбран

; direction flags
DF_UP               EQU %000                        ; направление вверх
DF_UP_RIGHT         EQU %001                        ; направление вверх-вправо
DF_RIGHT            EQU %010                        ; направление вправо
DF_DOWN_RIGHT       EQU %011                        ; направление вниз-вправо
DF_DOWN             EQU %100                        ; направление вниз
DF_DOWN_LEFT        EQU %101                        ; направление вниз-влево
DF_LEFT             EQU %110                        ; направление влево
DF_UP_LEFT          EQU %111                        ; направление вверх-влево

; FUnitTargets flags
FUTF_INDEX          EQU 0x00                        ; бит о типе Location (0 - индекс, 1 - 2 байта позиции)
FUTF_ENEMY          EQU 0x01                        ; бит о валидности индекса цели врага

; FUnitAnimation flags
FUAF_MOVE           EQU 0x00                        ; бит перемещения
FUAF_TURN_DOWN      EQU 0x01                        ; бит поворота низа
FUAF_TURN_UP        EQU 0x02                        ; бит поворота верха
FUAF_FULL_PLAYBACK  EQU 0x07                        ; бит полного проигрывания анимации, только после этого можно переключать флаги

; FAnimationInfo flags
FAIF_NOT_INTERRUPT  EQU 0x00                        ; бит невозможности прервать анимацию, она должна проиграться вся
FAIF_END            EQU 0x07                        ; бит последний кадр


                    struct FUnit
Health              DB #00                          ; 1 byte (количество жизни)
Armor               DB #00                          ; 1 byte (количество брони)
Rank                DB #00                          ; 1 byte (ранг)
Killed              DB #00                          ; 1 byte (количество ибитых)

                    ends


                    struct FUnitState               ; (1)
Behavior            DB #00                          ; 1 byte (состояния поведения)
Direction           DB #00                          ; 1 byte (направления)
Type                DB #00                          ; 1 byte (тип юнита)
Animation           DB #00                          ; 1 byte (номер анимации * 8)

                    ends

                    
                    struct FUnitLocation            ; (2)
TilePosition        FLocation                       ; 2 bytes (позиция в тайлах)
OffsetByPixel       FLocation                       ; 2 bytes (смещение относительно тайла)

                    ends


                    struct FUnitTargets             ; (3)
Location            FLocationIndex                  ; 1 byte (индекс в массиве целей Way Point'ов) / 2 bytes (позиция тайла)
Enemy               DB #00                          ; 1 byte (индекс в массиве целей врагов)
Flags               DB #00

                    ends


                    struct FFUnitAnimation          ; (4)
CounterDown         DB #00                          ; 1 byte (счётчика)
CounterUp           DB #00                          ; 1 byte (счётчика)
Reserve             DB #00                          ; 1 byte
Flags               DB #00                          ; 1 byte

                    ends


                    struct FAnimationInfo           ; структура описания тайминги анимаций
DeltaTime           DB #00
Flags               DB #00

                    ends

                    endif ; ~_STRUCTURE_UNIT_