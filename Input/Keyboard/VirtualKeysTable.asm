
                    ifndef _INPUT_KEYBOARD_VIRTUAL_KEYS_
                    define _INPUT_KEYBOARD_VIRTUAL_KEYS_

VK_CTRL_SHIFT       EQU 0x00
VK_Z                EQU 0x01
VK_X                EQU 0x02
VK_C                EQU 0x03
VK_V                EQU 0x04

VK_A                EQU 0x05
VK_S                EQU 0x06
VK_D                EQU 0x07
VK_F                EQU 0x08
VK_G                EQU 0x09

VK_Q                EQU 0x0A
VK_W                EQU 0x0B
VK_E                EQU 0x0C
VK_R                EQU 0x0D
VK_T                EQU 0x0E

VK_1                EQU 0x0F
VK_2                EQU 0x10
VK_3                EQU 0x11
VK_4                EQU 0x12
VK_5                EQU 0x13

VK_6                EQU 0x14
VK_7                EQU 0x15
VK_8                EQU 0x16
VK_9                EQU 0x17
VK_0                EQU 0x18

VK_Y                EQU 0x19
VK_U                EQU 0x1A
VK_I                EQU 0x1B
VK_O                EQU 0x1C
VK_P                EQU 0x1D

VK_H                EQU 0x1E
VK_J                EQU 0x1F
VK_K                EQU 0x20
VK_L                EQU 0x21
VK_ENTER            EQU 0x22

VK_B                EQU 0x23
VK_N                EQU 0x24
VK_M                EQU 0x25
VK_SYMBOL_SHIFT     EQU 0x26
VK_SPACE            EQU 0x27

INSTRUCTION_BIT     EQU #40 + 0x07

VirtualKeysTable:   DB (SVK_CTRL_SHIFT << 3) | INSTRUCTION_BIT, HalfRow_CS_V
                    DB (SVK_Z << 3) | INSTRUCTION_BIT, HalfRow_CS_V
                    DB (SVK_X << 3) | INSTRUCTION_BIT, HalfRow_CS_V
                    DB (SVK_C << 3) | INSTRUCTION_BIT, HalfRow_CS_V
                    DB (SVK_V << 3) | INSTRUCTION_BIT, HalfRow_CS_V

                    DB (SVK_A << 3) | INSTRUCTION_BIT, HalfRow_A_G
                    DB (SVK_S << 3) | INSTRUCTION_BIT, HalfRow_A_G
                    DB (SVK_D << 3) | INSTRUCTION_BIT, HalfRow_A_G
                    DB (SVK_F << 3) | INSTRUCTION_BIT, HalfRow_A_G
                    DB (SVK_G << 3) | INSTRUCTION_BIT, HalfRow_A_G

                    DB (SVK_Q << 3) | INSTRUCTION_BIT, HalfRow_Q_T
                    DB (SVK_W << 3) | INSTRUCTION_BIT, HalfRow_Q_T
                    DB (SVK_E << 3) | INSTRUCTION_BIT, HalfRow_Q_T
                    DB (SVK_R << 3) | INSTRUCTION_BIT, HalfRow_Q_T
                    DB (SVK_T << 3) | INSTRUCTION_BIT, HalfRow_Q_T

                    DB (SVK_1 << 3) | INSTRUCTION_BIT, HalfRow_1_5
                    DB (SVK_2 << 3) | INSTRUCTION_BIT, HalfRow_1_5
                    DB (SVK_3 << 3) | INSTRUCTION_BIT, HalfRow_1_5
                    DB (SVK_4 << 3) | INSTRUCTION_BIT, HalfRow_1_5
                    DB (SVK_5 << 3) | INSTRUCTION_BIT, HalfRow_1_5

                    DB (SVK_6 << 3) | INSTRUCTION_BIT, HalfRow_6_0
                    DB (SVK_7 << 3) | INSTRUCTION_BIT, HalfRow_6_0
                    DB (SVK_8 << 3) | INSTRUCTION_BIT, HalfRow_6_0
                    DB (SVK_9 << 3) | INSTRUCTION_BIT, HalfRow_6_0
                    DB (SVK_0 << 3) | INSTRUCTION_BIT, HalfRow_6_0

                    DB (SVK_Y << 3) | INSTRUCTION_BIT, HalfRow_Y_P
                    DB (SVK_U << 3) | INSTRUCTION_BIT, HalfRow_Y_P
                    DB (SVK_I << 3) | INSTRUCTION_BIT, HalfRow_Y_P
                    DB (SVK_O << 3) | INSTRUCTION_BIT, HalfRow_Y_P
                    DB (SVK_P << 3) | INSTRUCTION_BIT, HalfRow_Y_P

                    DB (SVK_H << 3) | INSTRUCTION_BIT, HalfRow_H_ENT
                    DB (SVK_J << 3) | INSTRUCTION_BIT, HalfRow_H_ENT
                    DB (SVK_K << 3) | INSTRUCTION_BIT, HalfRow_H_ENT
                    DB (SVK_L << 3) | INSTRUCTION_BIT, HalfRow_H_ENT
                    DB (SVK_ENTER << 3) | INSTRUCTION_BIT, HalfRow_H_ENT

                    DB (SVK_B << 3) | INSTRUCTION_BIT, HalfRow_B_SPC
                    DB (SVK_N << 3) | INSTRUCTION_BIT, HalfRow_B_SPC
                    DB (SVK_M << 3) | INSTRUCTION_BIT, HalfRow_B_SPC
                    DB (SVK_SYMBOL_SHIFT << 3) | INSTRUCTION_BIT, HalfRow_B_SPC
                    DB (SVK_SPACE << 3) | INSTRUCTION_BIT, HalfRow_B_SPC

                    endif ; ~_INPUT_KEYBOARD_VIRTUAL_KEYS_
