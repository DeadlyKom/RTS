
Normal              EQU 3
Possability_100     EQU Normal
Possability_75      EQU (((Normal * 125) - (Normal * 125 / 100 * 100) > 0) & 0x01) + Normal * 125 / 100         ; Normal * 125 / 100
Possability_50      EQU (((Normal * 150) - (Normal * 150 / 100 * 100) > 0) & 0x01) + Normal * 150 / 100         ; Normal * 150 / 100
Possability_25      EQU (((Normal * 175) - (Normal * 175 / 100 * 100) > 0) & 0x01) + Normal * 175 / 100         ; Normal * 175 / 100
Solder_Turn_Down:   FAnimation Possability_100, Possability_75, Possability_50, Possability_25
                    
