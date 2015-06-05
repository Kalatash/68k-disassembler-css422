*-----------------------------------------------------------
* Title      :  Disassemble Test
* Written by :  Brent Eaves
* Date       :  4-Jun-2015
* Description:  Testing OA Disassembly
*-----------------------------------------------------------
    
START:      ORG    $1000    ; first instruction of program

    MOVEA.W #$7000, A5
    MOVEA.W #$7100, A6


main_DECODE

    MOVE.W  (A5), D4
    
    LSR     #8, D4
    LSR     #4, D4          ; Get First Nibble
    
    CMP.B   #%0000, D4      ; BCLR, CMPI, ORI
    BEQ     main_0
    CMP.B   #%0001, D4      ; MOVE.B
    BEQ     main_1
    CMP.B   #%0010, D4      ; MOVE(A).L
    BEQ     main_2
    CMP.B   #%0011, D4      ; MOVE(A).W
    BEQ     main_3
    CMP.B   #%0100, D4      ; MOVEM, LEA, NEG, JSR, RTS
    BEQ     main_4
    CMP.B   #%0101, D4      ; SUBQ
    BEQ     main_5
    CMP.B   #%0110, D4      ; Bcc, BRA
    BEQ     main_6
    CMP.B   #%1000, D4      ; DIVS, OR
    BEQ     main_8
    CMP.B   #%1001, D4      ; SUB
    BEQ     main_9
    CMP.B   #%1011, D4      ; EOR, CMP
    BEQ     main_B
    CMP.B   #%1100, D4      ; MULS
    BEQ     main_C
    CMP.B   #%1101, D4      ; ADD, ADDA
    BEQ     main_D
    CMP.B   #%1110, D4      ; LSR/LSL, ASR/ASL, ROL/ROR
    BEQ     main_E

    BRA     main_Bad_Data


* OP Code continued to be decoded
* BCLR, CMPI, ORI
main_0
    BRA     main_Bad_Data


* MOVE.B
main_1
    BRA     main_Bad_Data


* MOVE.L, MOVEA.L
main_2
    BRA     main_Bad_Data


* MOVE.W, MOVEA.W
main_3
    BRA     main_Bad_Data


* MOVEM, LEA, NEG, JSR, RTS
main_4
    BRA     main_Bad_Data


* SUBQ
main_5
    BRA     main_Bad_Data


* Bcc, BRA
main_6
    BRA     main_Bad_Data


* DIVS, OR
main_8
    BRA     main_Bad_Data


* SUB
main_9
    BRA     main_Bad_Data


* EOR, CMP
main_B
    BRA     main_Bad_Data


* MULS
main_C
    BRA     main_Bad_Data


* ADD, ADDA
main_D
    BRA     main_Bad_Data


* LSR/LSL, ASR/ASL, ROL/ROR
main_E
    BRA     main_Bad_Data



* Untranslateable / BAD DATA
main_Bad_Data
    LEA     prt_Bad_Data, A1
    MOVE.B  #14,D0
    TRAP    #15

    MOVE.W  (A5), D1
    MOVE.B  #$10, D2
    MOVE.B  #15, D0
    TRAP    #15
    
    JSR     main_new_line

    ADDA.L  #$4, A5
    
    BRA     main_test_end


main_new_line
    LEA     prt_new_line, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    ADDI    #1,D7
    
    RTS
    

main_test_end   
    CMPA    A5, A6
    BGT     main_DECODE
    
    BRA     main_end_decode
    


main_end_decode

    MOVE.B  #9,D0
    TRAP    #15
* Put variables and constants here

prt_Bad_Data    DC.B    'DATA    ',0
prt_MOVE_B      DC.B    'MOVE.B  ',0
prt_MOVE_W      DC.B    'MOVE.W  ',0
prt_MOVEA_W     DC.B    'MOVEA.W ',0
prt_MOVE_L      DC.B    'MOVE.L  ',0
prt_MOVEA_L     DC.B    'MOVEA.L ',0

prt_new_line    DC.B    $0D,$0A,0

test_data_str   DC.W    '125wyet347yrd654634test3634yeryrthncvz',0
test_data_end   DC.W    0
output          DS.B    30

    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
