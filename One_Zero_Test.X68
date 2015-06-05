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
