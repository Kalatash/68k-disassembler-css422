#Table of commands
`0000`: BCLR, CMPI, OrI  
`0001`: MOVE.B  
`0010`: MOVE.L, MOVEA.L  
`0011`: MOVE.W, MOVEA.W  
`0100`: MOVEM, LEA, NEG, JSR, RTS  
`0101`: SUBQ  
`0110`: Bcc, BRA  
`0111`: ----  
`1000`: DIVS, OR  
`1001`: SUB  
`1010`: ----  
`1011`: EOR, CMP  
`1100`: MULS  
`1101`: ADD, ADDA  
`1110`: LSR/LSL, ASR/ASL, ROL/ROR  
`1111`: ---- 

#Table of EA
| EA Mode | Mode Code | Register |  
| --------|-----------|----------|  
| Dn | 000 | nnn |  
| An | 001 | nnn |  
| \(An\) | 010 | nnn |  
| \#\<data\> | 111 | 100 |  
| \(An\)+ | 011 | nnn |  
| -\(An\) | 100 | nnn |  
| \(xxx\).W | 111 | 000 |  
| \(xxx\).L | 111 | 001 |  

#Codes to Implement
##MOVE
Byte: 0001 DDDD DDSS SSSS  
Word: 0011 DDDD DDSS SSSS  
Long: 0010 DDDD DDSS SSSS  
4-116
##MOVEA
Word: 0011 DDD0 01SS SSSS  
Long: 0010 DDD0 01SS SSSS  
4-119
##MOVEM
0100 1D00 1SAA AAAA  
4-128
##ADD
1101 RegO pmAA AAAA  
4-4
##ADDA
1101 RegO pmAA AAAA  
4-7
##SUB
1001 RegO pmAA AAAA  
4-174
##SUBQ
0101 Dat1 SzAA AAAA  
4-181
##MULS
1100 Reg1 11AA AAAA  
4-136
##DIVS
1000 Reg1 11AA AAAA  
4-92
##LEA
0100 Reg1 11AA AAAA  
4-110
##OR
1000 RegO pmAA AAAA  
4-150
##ORI
0000 0000 SzAA AAAA  
4-153
##NEG
0100 0100 SzAA AAAA  
4-143
##EOR
1011 RegO pmAA AAAA  
4-100
##LSR, LSL
Regi: 1110 RegD SzL0 1Reg  
Memo: 1110 001D 11AA AAAA  
4-113
##ASR, ASL
Regi: 1110 RegD SzL0 0Reg  
Memo: 1110 000D 11AA AAAA  
4-22
##ROL, ROR
Regi: 1110 RegD SzL1 1Reg  
Memo: 1110 011D 11AA AAAA  
4-161
##BCLR
Regi: 0000 Reg1 10AA AAAA  
Stat: 0000 1000 10AA AAAA 0000 0000 NNNN NNNN  
4-30
##CMP
1011 RegO pmAA AAAA  
4-75
##CMPI
0000 1100 SzAA AAAA  
4-79
##Bcc (BCS, BGE, BLT, BVC)
0110 Cond AAAA AAAA  
4-25
##BRA
0110 0000 AAAA AAAA  
4-55
##JSR
0100 1110 10AA AAAA  
4-109
##RTS
0100 1110 0111 0101  
4-169


