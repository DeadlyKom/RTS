
				ifndef _STRUCTURE_BASE_
				define _STRUCTURE_BASE_

				struct FValue
Low             DB #00
High            DB #00
				ends

				struct FAddress
Low             DB #00
High            DB #00
				ends

				struct FSize
Width           DB #00
Height          DB #00            
				ends

				struct FOffset
X               DB #00
Y               DB #00            
				ends

				struct FMapSize
X               DB #00
Y               DB #00
				ends

				struct FLocation
X               DB #00
Y               DB #00            
				ends

				struct FLocation16
X               DW #0000
Y               DW #0000
				ends

				struct FWayPoint
Counter         DB #00                                                      	; счётчик ссылок
Location        FLocation 0, 0                                              	; позиция
				ends

				endif ; ~_STRUCTURE_BASE_