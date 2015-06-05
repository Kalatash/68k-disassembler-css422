*-----------------------------------------------------------
* Title      :  Test Code
* Written by :  Brent Eaves
* Date       :  5-Jun-2015
* Description:  Testing Various Values to Disasemble
*-----------------------------------------------------------
START:  ORG    $7000        ; first instruction of program
                  
* MOVE

    MOVE.B  #$A, D0
    MOVE.B  D5, Addr_One
    MOVE.W  A5, Addr_One
    MOVE.W  D2, D3
    
    MOVE.L  #$1234, D5
    MOVE.L  D5, Addr_Two
    MOVE.L  #$1234ABCD, D4
    
    MOVEA.W D5, A5
    MOVEA.L D5, A4


    MOVE.B  #9, D0           ; End
    TRAP    #15

* Put variables and constants here

Addr_One    DS.W    4
Addr_Two    DS.W    4
Addr_Thr    DS.W    4
Addr_Fou    DS.W    4

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
