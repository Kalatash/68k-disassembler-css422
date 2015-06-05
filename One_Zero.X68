*-----------------------------------------------------------
* Title      :68K disassembler
* Written by :Brent Eaves & Karim Oumghar
* Date       :Spring 2015 - CSS422
* Description:Final project
*-----------------------------------------------------------
CR      EQU     $0D                 ASCII code for carriage return
LF      EQU     $0A                 ASCII code for line feed
stackptr    EQU $01000000           Stack pointer
begin   EQU     $00000000           minimum address
end     EQU     $00FFFFFE           maximum address

    ORG    $00001000
START:                  ; first instruction of program

* Program code
INTRO   LEA  INTRO_MESSAGE,A1           Loads INTRO_MESSAGE into address register A1
        MOVE.B  #14,D0            
        TRAP  #15                 Displays message
        
*prompt code starts here, a loop...
*first determine if the starting address is a valid input

prompt_start    CLR D1
                LEA  PROMPTBEGIN,A1
                MOVE.B  #14,D1
                TRAP    #15
                
                LEA     startAd,A1
                MOVE.B  #2,D0 *store input
                TRAP    #15
                
first_inp       LEA     startAd,A1
                MOVE.B  startAd,D1
                MOVE.L  #2,D0
                TRAP    #15
                JSR     parse
                
last_inp        LEA     PROMPTEND1,A1
                MOVE.B  #14,D1
                LEA     startAd,A1
                MOVE.B  #14,D0
                LEA     PROMPTEND2,A1
                MOVE.B  #14,D1
                TRAP    #15
                JSR     PARSE
                
                
*parse...this converts a users input to a valid memory address  
badInput        LEA     BAD_INP,A1
                MOVE.B  #14,D0
                TRAP    #15
                RTS
              
parse           MOVEQ   #$0,D6
                MOVEQ   #$0,D5
                CMP.B   D5,D1
                BEQ     badInput
                CMPI    #$8,D1
                BGT     badInput
                BRA     parseEach
                
parseEach       MOVE.B  (A1)+,D2
                CMP.B   D5,D2
                BEQ     parseLast
                CMP.B   #102,D2
                BGT     hexCompare
        
parseLast       MOVEQ   #$0,D6
                MOVEQ   #$0,D5
                CMP.B   D5,D1
                BEQ     badInput
                CMPI    #$8,D1
                BGT     badInput
                BRA     parseEach
                
decimalCompare  CMP.B   #47,D2
                BLE     badInput
                CMP.B   #58,D2
                BLT     decimalConvert
                
        *convert decimal to hex        
decimalConvert  SUBI.B  #48,D2
                ASL.L   #4,D6
                ADD.B   D2,D6
                BRA     parseEach
               
                
hexCompare  CMP.B   #65,D2
            BLT     badInput
            CMP.B   #71,D2
            BLT     upperASCII
          *convert ascii upper case to hex value  
upperASCII  SUBI.B  #55,D2
            ASL.L   #4,D6
            ADD.B   D2,D6
            BRA     parseEach
          *do the same with lower case to hex value
lowerASCII  SUBI.B  #87,D2
            ASL.L   #4,D6
            ADD.B   D2,D6
            BRA     parseEach
            
parseDone   MOVEQ   #$1,D4
            RTS     
            
            
*resultDisplay, displays the starting and ending addresses
resultDisplay   LEA     STRADDR,A1
                MOVE.B  #14,D0
                
                LEA     startAd,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     PROMPTEND1,A1
                MOVE.B  #14,D0
                
                LEA     finishAd,A1
                MOVE.B  #14,D0
                TRAP    #15
            
*Ending display
endDisplay  LEA     GOODINP,A1
            MOVE.B  #14,D0
            LEA     GOAGAIN,A1
            MOVE.B  #14,D0
            *prompt user to enter y or n here
            MOVE.B  #2,D0
            TRAP   #15
            MOVE.B  (A1),D2
            CMP.B   #$59,D2 *uppercase Y
            BEQ     prompt_start
            CMP.B   #79,D2  *lowercase y
            BEQ     prompt_start
            
exitMsg     LEA     FINALMESSAGE,A1
            MOVE.B  #14,D0
            
            
        
INTRO_MESSAGE DC.B  '******Welcome to the 68k disassembler*******',CR,LF
        DC.B    'Program written by: Karim Oumghar and Brent Eaves',CR,LF,CR,LF,0
PROMPTBEGIN     DC.B    'Enter a starting address from $0 to $00FFFFFE: ',CR,LF,0
startAd         DS.B    80
PROMPTEND1      DC.B    'Enter an ending address from : ',0
finishAd        DS.B    80
PROMPTEND2       DC.B    ' to $00FFFFFE: ',CR,LF,0
ODD_INP       DC.B    'Invalid address, address must be even!',CR,LF,0
OOR_INP       DC.B    'Invalid address,  must be within range!',CR,LF,0
BAD_INP         DC.B    'Input is not in correct format!',CR,LF,0
GOODINP             DC.B    'ADDRESS OK!',CR,LF,0
GOAGAIN             DC.B    'Would you like to run the program again? (Y/N)',CR,LF,0
STRADDR             DC.B    'Starting address: ',CR,LF,0
ENDADDR             DC.B    'Ending address: ',CR,LF,0
INVRESPONSE         DC.B    'You did not enter Y or N!',CR,LF,0
FINALMESSAGE        DC.B    'Thanks for using the 68k disassebler...',CR,LF,0


* Put variables and constants here

    END    START        ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
