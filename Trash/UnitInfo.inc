
                            ifndef _STRUCTURE_UNIT_
                            define _STRUCTURE_UNIT_

; размер структуры юнита
UNIT_SIZE                   EQU FUnitState + FSpriteLocation + FUnitTargets + FUnitAnimation

; unit types
Infantry                    EQU 0x01
Ganner                      EQU 0x02
HeavyGunner                 EQU 0x03
Sniper                      EQU 0x04
Engineer                    EQU 0x05
ArmoredCarrier              EQU 0x06
Tank                        EQU 0x07

; effects flags (buffs/debuffs)
EF_SLOW                     EQU 0x01                                            ; эффект замедления

; FUnitState state flags
FUSF_SELECTED_BIT           EQU 0x00                                            ; объект выбран
FUSF_MOVE_BIT               EQU 0x01                                            ; объект движется
FUSF_ATTACK_BIT             EQU 0x02                                            ; объект атакует
FUSF_FLY_BIT                EQU 0x03                                            ; объект в полёте
FUSF_REGENERATION_BIT       EQU 0x04                                            ; объект в состоянии регенерации
FUSE_RECONNAISSANCE_BIT     EQU 0x05                                            ; объект провёл разведку
FUSF_RENDER_BIT_0           EQU 0x06                                            ; объект необходимо обновить (экран 0)
FUSF_RENDER_BIT_1           EQU 0x07                                            ; объект необходимо обновить (экран 1)

FUSF_SELECTED               EQU 1 << FUSF_SELECTED_BIT
FUSF_MOVE                   EQU 1 << FUSF_MOVE_BIT
FUSF_ATTACK                 EQU 1 << FUSF_ATTACK_BIT
FUSF_FLY                    EQU 1 << FUSF_FLY_BIT
FUSF_REGENERATION           EQU 1 << FUSF_REGENERATION_BIT
FUSE_RECONNAISSANCE         EQU 1 << FUSE_RECONNAISSANCE_BIT
FUSF_RENDER                 EQU 1 << FUSF_RENDER_BIT_0 | 1 << FUSF_RENDER_BIT_1

FUSF_IS_IDLE                EQU FUSF_MOVE | FUSF_ATTACK | FUSF_FLY

; direction flags
DF_UP                       EQU %000                                            ; направление вверх
DF_UP_RIGHT                 EQU %001                                            ; направление вверх-вправо
DF_RIGHT                    EQU %010                                            ; направление вправо
DF_DOWN_RIGHT               EQU %011                                            ; направление вниз-вправо
DF_DOWN                     EQU %100                                            ; направление вниз
DF_DOWN_LEFT                EQU %101                                            ; направление вниз-влево
DF_LEFT                     EQU %110                                            ; направление влево
DF_UP_LEFT                  EQU %111                                            ; направление вверх-влево

; FUnitTargets flags
FUTF_VALID_WP_BIT           EQU 0x07                                            ; бит валидности Way Point
FUTF_VALID_IDX_BIT          EQU 0x06                                            ; бит валидности данных об индексе
FUTF_INSERT_BIT             EQU 0x05                                            ; бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
FUTF_LOOP_BIT               EQU 0x04                                            ; бит зациклености путей
FUTF_NEXT_BIT               EQU 0x03                                            ; бит длины последовательности более 8, последний индекс (отсчёт от 7 до 0) в цепочке указывает индекс следующей цепочки
FUTF_VALID_WP               EQU 1 << FUTF_VALID_WP_BIT
FUTF_VALID_IDX              EQU 1 << FUTF_VALID_IDX_BIT
FUTF_INSERT                 EQU 1 << FUTF_INSERT_BIT
FUTF_LOOP                   EQU 1 << FUTF_LOOP_BIT
FUTF_NEXT                   EQU 1 << FUTF_NEXT_BIT
FUTF_MASK_OFFSET            EQU 0x07                                            ; маска смещения в массиве последовательностей

; FUnitAnimation flags
FUAF_TURN_MOVE              EQU 0x00                                            ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
FUAF_Y                      EQU 0x01                                            ; бит оси Y (0 - инкремент, 1 - декремент)
FUAF_X                      EQU 0x02                                            ; бит оси X (0 - инкремент, 1 - декремент)
FUAF_FULL_PLAYBACK          EQU 0x07                                            ; бит полного проигрывания анимации, только после этого можно переключать флаги
FUAF_X_Y_MASK               EQU (~(1 << FUAF_X | 1 << FUAF_Y)) & 0xFF
FUAF_MOVE_MASK              EQU (~(1 << FUAF_TURN_MOVE | 1 << FUAF_X | 1 << FUAF_Y)) & 0xFF
FUAF_IDLE_COUNT_MASK        EQU %01100000                                       ; маска счётчика в состоянии простоя юнита
FUAF_IDLE_COUNT_MASK_INV    EQU (~FUAF_IDLE_COUNT_MASK) & 0xFF

; FAnimationInfo flags
FAIF_NOT_INTERRUPT          EQU 0x00                                            ; бит невозможности прервать анимацию, она должна проиграться вся
FAIF_END                    EQU 0x07                                            ; бит последний кадр


                            struct FUnit                                        ; (0)
Health                      DB #00                                              ; 1 byte (количество жизни)
Armor                       DB #00                                              ; 1 byte (количество брони)
Rank                        DB #00                                              ; 1 byte (ранг)
Killed                      DB #00                                              ; 1 byte (количество ибитых)

                            ends


                            struct FUnitState                                   ; (1) - 0xFC00
State                       DB #00                                              ; 1 byte (состояния поведения)
Direction                   DB #00                                              ; 1 byte (направления)
Type                        DB #00                                              ; 1 byte (тип юнита)
Animation                   DB #00                                              ; 1 byte (номер анимации * 8)

                            ends

                    
                            struct FSpriteLocation                              ; (2) - 0xFD00
TilePosition                FLocation                                           ; 2 bytes (позиция в тайлах)
OffsetByPixel               FLocation                                           ; 2 bytes (смещение относительно тайла)

                            ends


                            struct FUnitTargets                                 ; (3) - 0xFE00
WayPoint                    FLocation                                           ; 2 bytes (позиция Way Point)
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | WP | IX | IN | LP | NX | O2 | O1 | O0 |
;   +----+----+----+----+----+----+----+----+
;
;   WP - [7]     бит валидности указанного Way Point
;   IX - [6]     бит валидности данных об индексе
;   IN - [5]     бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
;   LP - [4]     бит зацикленности
;   NX - [3]     бит длины последовательности более 8, последний индекс (отсчёт от 7 до 0) в цепочке указывает индекс следующей цепочки
;   O  - [2..0]  смещение (обратное от 7 до 0)
;
Data                        DB #00                                              ; данные последовательности
Idx                         DB #00                                              ; 1 byte (индекс в массиве Way Points)

                            ends


                            struct FUnitAnimation                               ; (4) - 0xFF00
CounterDown                 DB #00                                              ; 1 byte (счётчика)
CounterUp                   DB #00                                              ; 1 byte (счётчика)
Delta                       DB #00                                              ; 1 byte (дельта)
Flags                       DB #00                                              ; 1 byte

                            ends


                            struct FAnimationInfo                               ; структура описания тайминги анимаций
DeltaTime                   DB #00
Flags                       DB #00

                            ends

                            endif ; ~_STRUCTURE_UNIT_