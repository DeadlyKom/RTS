
                ifndef _STRUCTURE_DAMAGE_
                define _STRUCTURE_DAMAGE_

                include "DamageType.inc"

                struct FDamage                                                  ; скорей всего не нужно!
MeleeHit_Bite   DB #00                                                          ; ближний "удар/укус"
GunshotSmall    DB #00                                                          ; огнестрельное "мелкокалиберное"
GunshotLarge    DB #00                                                          ; огнестрельное "крупнокалиберное"
ExplosiveSmall  DB #00                                                          ; взрывное "снаряд"
ExplosiveLarge  DB #00                                                          ; взрывное "ракета"
EnergyLaser     DB #00                                                          ; энергетическое "лазер"
EnergyElectric  DB #00                                                          ; энергетическое "электрический"
NaturalAcid     DB #00                                                          ; природный "кислота"

                ends

                struct FResistance
MeleeHit_Bite   DB #00                                                          ; ближний "удар/укус"
GunshotSmall    DB #00                                                          ; огнестрельное "мелкокалиберное"
GunshotLarge    DB #00                                                          ; огнестрельное "крупнокалиберное"
ExplosiveSmall  DB #00                                                          ; взрывное "снаряд"
ExplosiveLarge  DB #00                                                          ; взрывное "ракета"
EnergyLaser     DB #00                                                          ; энергетическое "лазер"
EnergyElectric  DB #00                                                          ; энергетическое "электрический"
NaturalAcid     DB #00                                                          ; природный "кислота"

                ends

; структура характеристик юнита
                struct FUnitCharacteristics
Cooldown        DB #00                                                          ; перезарядка       [0]
Weapon:         DB #00                                                          ; тип урона         [1]
Damage:         DB #00                                                          ; величина урона    [2]
Armor:          DB #00                                                          ; броня
ResistanceBits: DB #00                                                          ; устойчивость, включеные биты отвечает за имунитет
Resistance:     FResistance                                                     ; величины устойчивости к урону
Distance:       DB #00                                                          ; дистанция

                ends

                endif ; ~_STRUCTURE_DAMAGE_
