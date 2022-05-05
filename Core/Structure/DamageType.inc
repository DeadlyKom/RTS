
                ifndef _STRUCTURE_DAMAGE_TYPE_
                define _STRUCTURE_DAMAGE_TYPE_

; типы урона
MELEE_HIT_BITE  EQU 0x00                                                        ; ближний "удар/укус"
GUNSHOT_SMALL   EQU 0x01                                                        ; огнестрельное "мелкокалиберное"
GUNSHOT_LARGE   EQU 0x02                                                        ; огнестрельное "крупнокалиберное"
EXPLOSIVE_SMALL EQU 0x03                                                        ; взрывное "снаряд"
EXPLOSIVE_LARGE EQU 0x04                                                        ; взрывное "ракета"
ENERGY_LASER    EQU 0x05                                                        ; энергетическое "лазер"
ENERGY_ELECTRIC EQU 0x06                                                        ; энергетическое "электрический"
NATURAL_ACID    EQU 0x07                                                        ; природный "кислота"

; типу устойчивости
RES_MHB         EQU 0 << MELEE_HIT_BITE                                         ; ближний "удар/укус"
RES_MHB_IMMUNE  EQU 1 << MELEE_HIT_BITE                                         ; иммунитет ближний "удар/укус"
RES_GSS         EQU 0 << GUNSHOT_SMALL                                          ; огнестрельное "мелкокалиберное"
RES_GSS_IMMUNE  EQU 1 << GUNSHOT_SMALL                                          ; иммунитет огнестрельное "мелкокалиберное"
RES_GSL         EQU 0 << GUNSHOT_LARGE                                          ; огнестрельное "крупнокалиберное"
RES_GSL_IMMUNE  EQU 1 << GUNSHOT_LARGE                                          ; иммунитет огнестрельное "крупнокалиберное"
RES_EPS         EQU 0 << EXPLOSIVE_SMALL                                        ; взрывное "снаряд"
RES_EPS_IMMUNE  EQU 1 << EXPLOSIVE_SMALL                                        ; иммунитет взрывное "снаряд"
RES_EPL         EQU 0 << EXPLOSIVE_LARGE                                        ; взрывное "ракета"
RES_EPL_IMMUNE  EQU 1 << EXPLOSIVE_LARGE                                        ; иммунитет взрывное "ракета"
RES_ERL         EQU 0 << ENERGY_LASER                                           ; энергетическое "лазер"
RES_ERL_IMMUNE  EQU 1 << ENERGY_LASER                                           ; иммунитет энергетическое "лазер"
RES_ERE         EQU 0 << ENERGY_ELECTRIC                                        ; энергетическое "электрический"
RES_ERE_IMMUNE  EQU 1 << ENERGY_ELECTRIC                                        ; иммунитет энергетическое "электрический"
RES_NTA         EQU 0 << NATURAL_ACID                                           ; природный "кислота"
RES_NTA_IMMUNE  EQU 1 << NATURAL_ACID                                           ; иммунитет природный "кислота"

                endif ; ~_STRUCTURE_DAMAGE_TYPE_
