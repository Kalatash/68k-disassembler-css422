*-----------------------------------------------------------
* Title      :  Disassemble Test
* Written by :  Brent Eaves
* Date       :  4-Jun-2015
* Description:  Testing OA Disassembly
*-----------------------------------------------------------
    
START:      ORG    $1000    ; first instruction of program

    MOVEA.W #$7000, A5      ; hardcode start
    MOVEA.W #$7030, A6      ; hardcode end


main_DECODE
    JSR     output_memline
    
    MOVE.W  (A5), D4
    LEA     (A5), A4
    
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

    BRA     main_Data


* OP Code continued to be decoded
* BCLR, CMPI, ORI
main_0
    BRA     main_Data


* MOVE.B
main_1
    BRA     main_Data


* MOVE.L, MOVEA.L
main_2
    BRA     main_Data


* MOVE.W, MOVEA.W
main_3
    BRA     main_Data


* MOVEM, LEA, NEG, JSR, RTS
main_4
    BRA     main_Data


* SUBQ
main_5
    BRA     main_Data


* Bcc, BRA
main_6
    BRA     main_Data


* DIVS, OR
main_8
    BRA     main_Data


* SUB
main_9
    BRA     main_Data


* EOR, CMP
main_B
    BRA     main_Data


* MULS
main_C
    BRA     main_Data


* ADD, ADDA
main_D
    BRA     main_Data


* LSR/LSL, ASR/ASL, ROL/ROR
main_E
    BRA     main_Data

* MOVE.B
main_MOVE_B

* MOVE.W
main_MOVE_W

* MOVE.L
main_MOVE_L

* MOVEA.W
main_MOVEA_W

* MOVEA.L
main_MOVEA_L

* Untranslateable / Data
main_Data
    LEA     prt_Data, A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     output_word
    
    JSR     output_new_line
    
    BRA     main_test_end

* Printing out the currnet Memory Address
output_memline
    MOVE.L  A5, D4
    MOVE.B  #$10, D2
    MOVE.B  #15, D0         ; prepare the forbidden trapcode
    
loop_memline    
    ROL.L   #$4, D4         ; roll over one nibble
    
    MOVE.L  #$F, D1
    AND.B   D4, D1          ; set D1 to digit
    TRAP    #15             ; print digit
    
    CMP.L   A5, D4
    BNE     loop_memline    ; loop if not printed entire longword
    
    ANDI.L  #$0, D4         ; clear register
    MOVE.B  #6, D0
    MOVE.B  #$09, D1
    TRAP    #15
    
    RTS

* Print out the Word at Memory Address
output_word
    MOVE.B  #$10, D2
    MOVE.B  #15, D0         ; prepare the forbidden trapcode
    MOVE.B  #$0, D3

    MOVE.W  (A5), D4
loop_word
    ROL.W   #$4, D4         ; roll over one nibble
    ADDI.B  #$1, D3
    
    MOVE.L  #$F, D1
    AND.B   D4, D1          ; set D1 to digit
    TRAP    #15             ; print digit
    
    CMP.B   #$4, D3
    BNE     loop_word       ; loop if not printed entire word
    
    ANDI.L  #$0, D3
    ANDI.L  #$0, D4         ; clear registers
    
    ADDA.L  #$2, A4         ; Advance current counter by a Word
    
    RTS


* Print and keep track of new lines
output_new_line
    MOVE.B  #6, D0
    MOVE.B  #$0D, D1
    TRAP    #15
    MOVE.B  #$0A, D1
    TRAP    #15
    
    ADDI    #1,D7
    
    RTS
    
* Testing for end of of run or page
main_test_end   
    LEA     (A4), A5
    CMPA    A5, A6
    BGT     main_DECODE
    
    BRA     main_end_decode
    
* Exit or Retry
main_end_decode

    MOVE.B  #9,D0
    TRAP    #15

* Varibles and Constants
prt_Data        DC.B    'Data    ',0
prt_MOVE_B      DC.B    'MOVE.B  ',0
prt_MOVE_W      DC.B    'MOVE.W  ',0
prt_MOVEA_W     DC.B    'MOVEA.W ',0
prt_MOVE_L      DC.B    'MOVE.L  ',0
prt_MOVEA_L     DC.B    'MOVEA.L ',0

prt_new_line    DC.B    $0D,$0A,0
prt_tab         DC.B    $09,0

output          DS.B    30

    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
