
                            ifndef _STRUCTURE_UNIT_TYPE_
                            define _STRUCTURE_UNIT_TYPE_
; FUnitType.Type unit types

; сдвиг необходим для быстрого получить адрес из таблице по типу юнита (GetAdrInTable)
Infantry                    EQU 0x00 << 1
Tank                        EQU 0x01 << 1
Gunner                      EQU 0x02 << 1
HeavyGunner                 EQU 0x03 << 1
Sniper                      EQU 0x04 << 1
Engineer                    EQU 0x05 << 1
ArmoredCarrier              EQU 0x06 << 1

FACTION_TYPE_BIT            EQU 0x07                                            ; тип фракции (0 - нейтральная, 1 - враждебная)
COMPOSITE_UNIT_BIT          EQU 0x00                                            ; флаг что юнит является составной (из 2х частей)

NEUTRAL_FACTION             EQU 0x00 << FACTION_TYPE_BIT                        ; нейтральная фракция
ENEMY_FACTION               EQU 0x01 << FACTION_TYPE_BIT                        ; враждебная фракция
FACTION_TYPE                EQU 1 << FACTION_TYPE_BIT
COMPOSITE_UNIT              EQU 1 << COMPOSITE_UNIT_BIT
IDX_UNIT_TYPE               EQU %00111110


; FUnit.State state flags

UNIT_STATE_IDLE             EQU 0x00 << 1
UNIT_STATE_MOVE             EQU 0x01 << 1
UNIT_STATE_ATTACK           EQU 0x02 << 1
UNIT_STATE_DEAD             EQU 0x03 << 1
UNIT_STATE_MOVE_ATTACK      EQU 0x04 << 1                                       ; состояние для 2х уровневых юнитов

UNIT_STATE_MASK             EQU %00001110
UNIT_STATE_INV_MASK         EQU (~UNIT_STATE_MASK) & 0xFF
UNIT_STATE_MASK_EXTENDED    EQU %00001111


FUSF_SELECTED_BIT           EQU 0x00                                            ; объект выбран
FUSF_REGENERATION_BIT       EQU 0x04                                            ; объект в состоянии регенерации
FUSE_RECONNAISSANCE_BIT     EQU 0x05                                            ; объект провёл разведку
FUSF_RENDER_BIT_0           EQU 0x06                                            ; объект необходимо обновить (экран 0)
FUSF_RENDER_BIT_1           EQU 0x07                                            ; объект необходимо обновить (экран 1)

FUSF_SELECTED               EQU 1 << FUSF_SELECTED_BIT
FUSF_REGENERATION           EQU 1 << FUSF_REGENERATION_BIT
FUSE_RECONNAISSANCE         EQU 1 << FUSE_RECONNAISSANCE_BIT
FUSF_RENDER                 EQU 1 << FUSF_RENDER_BIT_0 | 1 << FUSF_RENDER_BIT_1


; direction flags
DF_UP                       EQU %000                                            ; направление вверх
DF_UP_RIGHT                 EQU %001                                            ; направление вверх-вправо
DF_RIGHT                    EQU %010                                            ; направление вправо
DF_DOWN_RIGHT               EQU %011                                            ; направление вниз-вправо
DF_DOWN                     EQU %100                                            ; направление вниз
DF_DOWN_LEFT                EQU %101                                            ; направление вниз-влево
DF_LEFT                     EQU %110                                            ; направление влево
DF_UP_LEFT                  EQU %111                                            ; направление вверх-влево

DF_DOWN_MASK                EQU %00111000                                       ; маска направления (низ)

; FUnit.Data state flags
FUTF_VALID_WP_BIT           EQU 0x07                                            ; бит отвечающий, что значение Target не хранит корректный Way Point
FUTF_ENEMY_BIT              EQU 0x06                                            ; бит отвечающий, что значения Target хранят позицию цели для атаки
FUTF_VALID_IDX_BIT          EQU 0x05                                            ; бит валидности данных об индексе
FUTF_INSERT_BIT             EQU 0x04                                            ; бит отвечающий, что произведена временная вставка значения в Target (т.е., увеличивать смещение не нужно, если это Way Point или иной цели)
FUTF_LOOP_BIT               EQU 0x03                                            ; бит зациклености путей
; FUTF_NEXT_BIT               EQU 0x03                                            ; бит длины последовательности более 8, последний индекс (отсчёт от 7 до 0) в цепочке указывает индекс следующей цепочки

; биты 0, 1, 2 заняты
FUTF_VALID_WP               EQU 1 << FUTF_VALID_WP_BIT
FUTF_ENEMY                  EQU 1 << FUTF_ENEMY_BIT
FUTF_VALID_IDX              EQU 1 << FUTF_VALID_IDX_BIT
FUTF_INSERT                 EQU 1 << FUTF_INSERT_BIT
FUTF_LOOP                   EQU 1 << FUTF_LOOP_BIT
; FUTF_NEXT                   EQU 1 << FUTF_NEXT_BIT
FUTF_MASK_OFFSET            EQU 0x07                                            ; маска смещения в массиве последовательностей

; FUnit.Animation state flags
FUAF_ANIMATION_MASK         EQU %00000011

; FUnit.Flags state flags
FUAF_TURN_MOVE_BIT          EQU 0x00                                            ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
FUAF_Y_BIT                  EQU 0x01                                            ; бит оси Y (0 - инкремент, 1 - декремент)
FUAF_X_BIT                  EQU 0x02                                            ; бит оси X (0 - инкремент, 1 - декремент)
FUAF_FLASH_BIT              EQU 0x03                                            ; бит мерцания
FUAF_FULL_PLAYBACK          EQU 0x07                                            ; бит полного проигрывания анимации, только после этого можно переключать флаги
FUAF_X_Y_MASK               EQU (~(1 << FUAF_X_BIT | 1 << FUAF_Y_BIT)) & 0xFF
FUAF_MOVE_MASK              EQU (~(1 << FUAF_TURN_MOVE_BIT | 1 << FUAF_X_BIT | 1 << FUAF_Y_BIT)) & 0xFF
FUAF_IDLE_COUNT_MASK        EQU %01100000                                       ; маска счётчика в состоянии простоя юнита
FUAF_IDLE_DECREMENT         EQU %00100000                                       ; значение декремента счётчика юнита в состоянии простоя
FUAF_IDLE_COUNT_MASK_INV    EQU (~FUAF_IDLE_COUNT_MASK) & 0xFF
FUAF_COUNT_DOWN_MASK        EQU %00011111                                       ; маска нижнего счётчика

; FAnimationInfo flags
FAIF_NOT_INTERRUPT          EQU 0x00                                            ; бит невозможности прервать анимацию, она должна проиграться вся
FAIF_END                    EQU 0x07                                            ; бит последний кадр

                            endif ; ~_STRUCTURE_UNIT_TYPE_