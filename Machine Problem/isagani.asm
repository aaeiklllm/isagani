.MODEL SMALL
.STACK 500H
.DATA 

DEVELOPERS DB  'Developed by Layug and Trani$' 
PRESS_ANY_KEY DB 'Press any key to continue...$'

; GAME RULES
R DB 'Game Rules:$' 
R1 DB '1. Player will set "O" and AI will set "X".$'
R2 DB '2. Player will be the first to move.$'
R3 DB '3. Enter the cell name of the mark you want to move.$'
R4 DB '4. Enter the cell name where you want to place your mark.$'
R5 DB '5. Set 3 of your marks horizontally, vertically, or diagonally to win.$'   
R6 DB 'Have fun!$'

; BOARD LINES
L1 DB '[$'
L2 DB ']$'
L3 DB '-\-$'
L4 DB '-/-$'
L5 DB '---$'
N1 DB '    |     |     |$'
COL DB '    a     b     c$'
ROW1 DB '1 $' 
ROW2 DB '2 $'
ROW3 DB '3 $'

; CELL NUMBERS 
C1 DB '1$' 
C2 DB '2$'
C3 DB '3$'
C4 DB '4$'
C5 DB '5$'
C6 DB '6$'
C7 DB '7$'
C8 DB '8$'
C9 DB '9$'

; BOARD CELLS 
a1 DB 'a1$' 
b1 DB 'b1$'
_c1 DB 'c1$'
a2 DB 'a2$'
b2 DB 'b2$'
_c2 DB 'c2$'
a3 DB 'a3$'
b3 DB 'b3$'
_c3 DB 'c3$'

; VARIABLES
PLAYER DB 50, '$' 
O_MARK DB '(O)$' 
DONE DB 0
DR DB 0 
NUM_OF_O DB 3 
FROM_INPUT DB ?
TO_INPUT DB ?
FROM_INPUT_LETTER DB ?
FROM_INPUT_NUMBER DB ?
TO_INPUT_LETTER DB ?
TO_INPUT_NUMBER DB ?
AI_MOVES DW ?
PLAYER_MOVES DW ?
QUOTIENT DB ? 
REMAINDER DB ?
NEWLINE db 13, 10, "$"
VALID_MOVE DB 0
VALID_TO DB 0
VALID_FROM DB 0
RAND DB ?      
LRAND DB 100   
CRAND DB ?      
MAX DB 10 
CURRENT_MARK DB 88    

; PROMTS 
YOUR_MOVE DB 32, 'Your move. $'
FROM DB 32, 'From: $' 
TO DB 32, 'To: $'
TKN DB 'This cell is taken! Press any key...$' 
NUMBER_OF_MOVES DB ' Number of moves: $' 
PLAYER_MESSAGE DB 'Player $'
AI_MESSAGE DB 'AI $'
MOVES_FROM DB 'moves from $'
TO_MESSAGE DB ' to $'
WON_THE_GAME DB 'won the game!$'
DRW DB 'The game is draw!$'
TRA DB 'Want to play again? (y/n): $'
WI DB  32, 32, 32, 'Wrong input! Press any key...   $' 
INVALID_MESSAGE DB  32, 32, 32, 'Invalid move! Press any key...   $' 
TOTALAI DB  'AI # of moves: $'
TOTALPL DB  'Player # of moves: $'
EMP DB '                                        $'  

.CODE
MAKERANDOM PROC NEAR  
    MOV AL, RAND
    XOR AH, AH
    MOV BL, MAX
    DIV BL

    CMP AH, LRAND
    JNE @NOCHANGE
    INC AH
    CMP AH, MAX
    JB @NODEC
    SUB AH, 2
    @NODEC:
    @NOCHANGE:

    MOV CL, CRAND
    MOV LRAND, CL
    MOV CRAND, AH

    MOV CL, RAND
    INC CL
    RCL CL, 1
    MOV RAND, CL
    RET
MAKERANDOM ENDP

AI_MOVE_FROM PROC NEAR
    MOV AH, 2Ch
    INT 21h
    MOV RAND, DH

    CALL MAKERANDOM
    MOV BL, CRAND
    MOV FROM_INPUT, BL
    RET
AI_MOVE_FROM ENDP

AI_MOVE_TO PROC NEAR
    MOV AH, 2Ch
    INT 21h
    MOV RAND, DH

    CALL MAKERANDOM
    MOV BL, CRAND
    MOV TO_INPUT, BL
    RET
AI_MOVE_TO ENDP

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    TITLESCREEN:   
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H 

        MOV AH, 2
        MOV BH, 0
        MOV DH, 6
        MOV DL, 14
        INT 10H 
            
        MOV AH, 2
        MOV DH, 7
        MOV DL, 14
        INT 10H 
        
        MOV AH, 2
        MOV DH, 8
        MOV DL, 14
        INT 10H 
    
        MOV AH, 2
        MOV DH, 9
        MOV DL, 14
        INT 10H  
            
        MOV AH, 2
        MOV DH, 10
        MOV DL, 14
        INT 10H 
    
        MOV AH, 2
        MOV DH, 11
        MOV DL, 22
        INT 10H 
        
        LEA DX, DEVELOPERS 
        MOV AH, 9
        INT 21H
 
        MOV AH, 2
        MOV DH, 13
        MOV DL, 24
        INT 10H  
        
        LEA DX, PRESS_ANY_KEY 
        MOV AH, 9
        INT 21H
        
        MOV AH, 7   
        INT 21H
    
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H 
        
        JMP RULES

    RULES:
        MOV AH, 2
        MOV BH, 0
        MOV DH, 6
        MOV DL, 7
        INT 10H
    
        LEA DX, R
        MOV AH, 9
        INT 21H

        MOV AH, 2
        MOV DH, 7
        MOV DL, 7
        INT 10H 
    
        LEA DX, R1   
        MOV AH, 9
        INT 21H 

        MOV AH, 2
        MOV DH, 8
        MOV DL, 7
        INT 10H 
    
        LEA DX, R2   
        MOV AH, 9
        INT 21H

        MOV AH, 2
        MOV DH, 9
        MOV DL, 7
        INT 10H 
    
        LEA DX, R3   
        MOV AH, 9
        INT 21H
    
        MOV AH, 2
        MOV DH, 10
        MOV DL, 7
        INT 10H
    
        LEA DX, R4  
        MOV AH, 9
        INT 21H

        MOV AH, 2
        MOV DH, 11
        MOV DL, 7
        INT 10H      
            
        LEA DX, R5 
        MOV AH, 9
        INT 21H
            
        MOV AH, 2
        MOV DH, 13
        MOV DL, 7
        INT 10H
        
        LEA DX, R6
        MOV AH, 9
        INT 21H
        
        MOV AH, 2
        MOV DH, 15
        MOV DL, 7
        INT 10H 
    
        LEA DX, PRESS_ANY_KEY 
        MOV AH, 9
        INT 21H
        
        MOV AH, 7   
        INT 21H 
        
    INIT: 
        MOV PLAYER, 50    
        MOV DONE, 0
        MOV DR, 0 

        MOV PLAYER_MOVES, 0
        MOV AI_MOVES, 0
        
        MOV C1, 88
        MOV C2, 88
        MOV C3, 88
        MOV C4, ' '
        MOV C5, ' '
        MOV C6, ' '
        MOV C7, 79
        MOV C8, 79
        MOV C9, 79
                                                
        JMP PLRCHANGE

    VICTORY:
        .IF PLAYER == 49
            LEA DX, PLAYER_MESSAGE
            MOV AH, 9
            INT 21H
        .ELSEIF PLAYER == 50
            LEA DX, AI_MESSAGE
            MOV AH, 9
            INT 21H
        .ENDIF

        LEA DX, WON_THE_GAME
        MOV AH, 9
        INT 21H

        .IF PLAYER == 49
            LEA DX, NUMBER_OF_MOVES
            MOV AH, 9
            INT 21H
            
            MOV AX, PLAYER_MOVES
            MOV BL, 10
            DIV BL

            MOV QUOTIENT, AL
            MOV REMAINDER, AH

            MOV DL, QUOTIENT
            ADD DL, '0'
            MOV AH, 2
            INT 21H

            MOV DL, REMAINDER
            ADD DL, '0'
            MOV AH, 2
            INT 21H
        .ELSEIF PLAYER == 50
            LEA DX, NUMBER_OF_MOVES
            MOV AH, 9
            INT 21H

            MOV AX, AI_MOVES
            MOV BL, 10
            DIV BL

            MOV QUOTIENT, AL
            MOV REMAINDER, AH

            MOV DL, QUOTIENT
            ADD DL, '0'
            MOV AH, 2
            INT 21H

            MOV DL, REMAINDER
            ADD DL, '0'
            MOV AH, 2
            INT 21H
        .ENDIF
        
        MOV AH, 2
        MOV DH, 17
        MOV DL, 28 
        INT 10H  
            
        LEA DX, PRESS_ANY_KEY  
        MOV AH, 9
        INT 21H
        
        MOV AH, 7    
        INT 21H    
        
        JMP TRYAGAIN                     

    CHECK:   
        CHECK1:
            .IF C1 == 79
                MOV AL, C1
                MOV BL, C2 
                MOV CL, C3

                CMP AL, BL
                JNZ CHECK2

                CMP BL, CL
                JNZ CHECK2

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK2
            .ENDIF

        CHECK2:
            .IF C4 == 79
                MOV AL, C4
                MOV BL, C5 
                MOV CL, C6

                CMP AL, BL
                JNZ CHECK3

                CMP BL, CL
                JNZ CHECK3

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C4 == 88
                MOV AL, C4
                MOV BL, C5 
                MOV CL, C6

                CMP AL, BL
                JNZ CHECK3

                CMP BL, CL
                JNZ CHECK3

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK3
            .ENDIF

        CHECK3:
            .IF C7 == 88
                MOV AL, C7
                MOV BL, C8
                MOV CL, C9

                CMP AL, BL
                JNZ CHECK4

                CMP BL, CL
                JNZ CHECK4 

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK4
            .ENDIF

        CHECK4:
            .IF C1 == 88
                MOV AL, C1
                MOV BL, C4 
                MOV CL, C7

                CMP AL, BL
                JNZ CHECK5

                CMP BL, CL
                JNZ CHECK5

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C1 == 79
                MOV AL, C1
                MOV BL, C4 
                MOV CL, C7

                CMP AL, BL
                JNZ CHECK5

                CMP BL, CL
                JNZ CHECK5

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK5
            .ENDIF

        CHECK5:
            .IF C2 == 88
                MOV AL, C2
                MOV BL, C5 
                MOV CL, C8

                CMP AL, BL
                JNZ CHECK6

                CMP BL, CL
                JNZ CHECK6

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C2 == 79
                MOV AL, C2
                MOV BL, C5 
                MOV CL, C8

                CMP AL, BL
                JNZ CHECK6

                CMP BL, CL
                JNZ CHECK6

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK6
            .ENDIF

        CHECK6:
            .IF C3 == 88
                MOV AL, C3
                MOV BL, C6 
                MOV CL, C9

                CMP AL, BL
                JNZ CHECK7

                CMP BL, CL
                JNZ CHECK7

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C3 == 79
                MOV AL, C3
                MOV BL, C6 
                MOV CL, C9

                CMP AL, BL
                JNZ CHECK7

                CMP BL, CL
                JNZ CHECK7

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK7
            .ENDIF

        CHECK7:
            .IF C1 == 79
                MOV AL, C1
                MOV BL, C5 
                MOV CL, C9

                CMP AL, BL
                JNZ CHECK8

                CMP BL, CL
                JNZ CHECK8

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C1 == 88
                MOV AL, C1
                MOV BL, C5 
                MOV CL, C9

                CMP AL, BL
                JNZ CHECK8

                CMP BL, CL
                JNZ CHECK8

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP CHECK8
            .ENDIF

        CHECK8:
            .IF C3 == 88
                MOV AL, C3
                MOV BL, C5 
                MOV CL, C7

                CMP AL, BL
                JNZ PLRCHANGE

                CMP BL, CL
                JNZ PLRCHANGE

                MOV DONE, 1
                JMP BOARD
            .ELSEIF C3 == 79
                MOV AL, C3
                MOV BL, C5 
                MOV CL, C7

                CMP AL, BL
                JNZ PLRCHANGE

                CMP BL, CL
                JNZ PLRCHANGE

                MOV DONE, 1
                JMP BOARD
            .ELSE
                JMP PLRCHANGE
            .ENDIF
   
    PLRCHANGE:                     
        CMP PLAYER, 49
        JZ P2
        CMP PLAYER, 50
        JZ P1
        
        P1:
            MOV PLAYER, 49
            MOV CURRENT_MARK, 79 ; O
            JMP BOARD
             
        P2:
            MOV PLAYER, 50
            MOV CURRENT_MARK, 88 ; X
            JMP BOARD

    BOARD:    
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H
    
        MOV AH, 2
        MOV BH, 0
        MOV DH, 6
        MOV DL, 30
        INT 10H

        LEA DX, COL
        MOV AH, 9
        INT 21H 

        MOV AH, 2
        MOV DH, 7
        MOV DL, 30 
        INT 10H
    
        MOV AH, 2
        MOV DL, 32
        INT 21H

        LEA DX, ROW1
        MOV AH, 9
        INT 21H 

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C1
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H 
        
        LEA DX, L3
        MOV AH, 9
        INT 21H
    
        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C2
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H
        
        LEA DX, L4
        MOV AH, 9
        INT 21H
        
        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C3
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H
    
        MOV AH, 2
        MOV DH, 8
        MOV DL, 30 
        INT 10H 
    
        LEA DX, N1
        MOV AH, 9
        INT 21H 
    
        MOV AH, 2
        MOV DH, 9
        MOV DL, 30 
        INT 10H
    
        MOV AH, 2
        MOV DL, 32
        INT 21H
        
        LEA DX, ROW2
        MOV AH, 9
        INT 21H 

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C4
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H 
    
        LEA DX, L5
        MOV AH, 9
        INT 21H

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C5
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H
        
        LEA DX, L5
        MOV AH, 9
        INT 21H

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C6
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H
    
        MOV AH, 2
        MOV DH, 10
        MOV DL, 30 
        INT 10H   

        LEA DX, N1
        MOV AH, 9
        INT 21H  

        MOV AH, 2
        MOV DH, 11
        MOV DL, 30 
        INT 10H
        
        MOV AH, 2
        MOV DL, 32
        INT 21H   
    
        LEA DX, ROW3
        MOV AH, 9
        INT 21H 

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C7
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H 
        
        LEA DX, L4
        MOV AH, 9
        INT 21H

        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C8
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H
        
        LEA DX, L3
        MOV AH, 9
        INT 21H
    
        LEA DX, L1
        MOV AH, 9
        INT 21H 
        
        LEA DX, C9
        MOV AH, 9
        INT 21H 

        LEA DX, L2
        MOV AH, 9
        INT 21H

        MOV AH, 2
        MOV DH, 12
        MOV DL, 30 
        INT 10H 
    
        MOV AH, 2
        MOV DH, 13
        MOV DL, 30 
        INT 10H
    
        LEA DX, TOTALPL
        MOV AH, 9
        INT 21H

        MOV AX, PLAYER_MOVES
        MOV BL, 10
        DIV BL

        MOV QUOTIENT, AL
        MOV REMAINDER, AH

        MOV DL, QUOTIENT
        ADD DL, '0'
        MOV AH, 2
        INT 21H

        MOV DL, REMAINDER
        ADD DL, '0'
        MOV AH, 2
        INT 21H


        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H

        LEA DX, TOTALAI
        MOV AH, 9
        INT 21H

        MOV AX, AI_MOVES
        MOV BL, 10
        DIV BL

        MOV QUOTIENT, AL
        MOV REMAINDER, AH

        MOV DL, QUOTIENT
        ADD DL, '0'
        MOV AH, 2
        INT 21H

        MOV DL, REMAINDER
        ADD DL, '0'
        MOV AH, 2
        INT 21H

        MOV AH, 2
        MOV DH, 16
        MOV DL, 20
        INT 10H 
    
        CMP DONE, 1
        JZ VICTORY

    INPUT:
        .IF PLAYER == 49 ; Player
            JMP PLAYER_MOVE_MSG
        .ELSEIF PLAYER == 50 ; AI
            INC AI_MOVES
            JMP GENERATE_AI_MOVE_FROM
        .ENDIF

    PLAYER_MOVE_MSG:
        LEA DX, PLAYER_MESSAGE
        MOV AH, 9
        INT 21H
        
        LEA DX, O_MARK
        MOV AH, 9
        INT 21H 
        JMP TAKEINPUT

    GENERATE_AI_MOVE_FROM:
        CALL AI_MOVE_FROM 
        JMP AI_CHECK_VALID_FROM

    AI_CHECK_VALID_FROM:
        .IF FROM_INPUT == 1
            .IF C1 == 88
                .IF C2 == 88
                    .IF C4 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C4 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C2 == 79
                    .IF C4 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C4 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 2
            .IF C2 == 88
                .IF C1 == 88
                    .IF C3 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C3 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C1 == 79
                    .IF C3 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C3 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 3
            .IF C3 == 88
                .IF C2 == 88
                    .IF C6 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C6 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                        .ENDIF
                .ELSEIF C2 == 79
                    .IF C6 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C6 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 4
            .IF C4 == 88
                .IF C1 == 88
                    .IF C7 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C7 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C1 == 79
                    .IF C7 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C7 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 5
            .IF C5 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 6
            .IF C6 == 88
                .IF C3 == 88
                    .IF C9 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C9 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C3 == 79
                    .IF C9 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C9 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 7
            .IF C7 == 88
                .IF C8 == 88
                    .IF C4 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C4 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C8 == 79
                    .IF C4 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C4 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 8
            .IF C8 == 88
                .IF C7 == 88
                    .IF C9 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C9 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C7 == 79
                    .IF C9 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C9 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF

        .ELSEIF FROM_INPUT == 9
            .IF C9 == 88
                .IF C6 == 88
                    .IF C8 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C8 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSEIF C6 == 79
                    .IF C8 == 79
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ELSEIF C8 == 88
                        .IF C5 == 88
                            JMP GENERATE_AI_MOVE_FROM
                        .ELSEIF C5 == 79
                            JMP GENERATE_AI_MOVE_FROM
                        .ENDIF
                    .ENDIF
                .ELSE
                    JMP GENERATE_AI_MOVE_TO
                .ENDIF
            .ELSE
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSE    
            JMP GENERATE_AI_MOVE_FROM
        .ENDIF

    GENERATE_AI_MOVE_TO:
        CALL AI_MOVE_TO
        JMP AI_CHECK_VALID_TO

    AI_CHECK_VALID_TO:
        .IF TO_INPUT == 1
            .IF C1 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C1 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 2
            .IF C2 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C2 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 3
            .IF C3 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C3 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 4
            .IF C4 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C4 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 5
            .IF C5 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C5 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 6
            .IF C6 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C6 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 7
            .IF C7 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C7 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 8
            .IF C8 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C8 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 9
            .IF C9 == 88
                JMP GENERATE_AI_MOVE_TO
            .ELSEIF C9 == 79
                JMP GENERATE_AI_MOVE_TO
            .ELSE
                JMP AI_MOVE
            .ENDIF
        .ELSE
            JMP GENERATE_AI_MOVE_TO
        .ENDIF

    AI_MOVE:
        .IF FROM_INPUT == 1
            .IF TO_INPUT == 2 
                MOV C1, ' ' 
                MOV C2, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 4
                MOV C1, ' '
                MOV C4, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C1, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 2
            .IF TO_INPUT == 1
                MOV C2, ' '
                MOV C1, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 3
                MOV C2, ' '
                MOV C3, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C2, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 3
            .IF TO_INPUT == 2 
                MOV C3, ' '
                MOV C2, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C3, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 6
                MOV C3, ' '
                MOV C6, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 4
            .IF TO_INPUT == 1
                MOV C4, ' '
                MOV C1, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C4, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 7
                MOV C4, ' '
                MOV C7, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 5
            .IF TO_INPUT == 1
                MOV C5, ' '
                MOV C1, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 2
                MOV C5, ' '
                MOV C2, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 3
                MOV C5, ' '
                MOV C3, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 4
                MOV C5, ' '
                MOV C4, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 6
                MOV C5, ' '
                MOV C6, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 7
                MOV C5, ' '
                MOV C7, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 8
                MOV C5, ' '
                MOV C8, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 9
                MOV C5, ' '
                MOV C9, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 6
            .IF TO_INPUT == 3
                MOV C6, ' '
                MOV C3, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C6, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 9
                MOV C6, ' '
                MOV C9, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 7
            .IF TO_INPUT == 4
                MOV C7, ' '
                MOV C4, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C7, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 8
                MOV C7, ' '
                MOV C8, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 8
            .IF TO_INPUT == 7
                MOV C8, ' '
                MOV C7, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 5
                MOV C8, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 9
                MOV C8, ' '
                MOV C9, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSEIF FROM_INPUT == 9
            .IF TO_INPUT == 5
                MOV C9, ' '
                MOV C5, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 6
                MOV C9, ' '
                MOV C6, 88
                JMP PRINT_AI_MOVE
            .ELSEIF TO_INPUT == 8
                MOV C9, ' '
                MOV C8, 88
                JMP PRINT_AI_MOVE
            .ELSE 
                JMP GENERATE_AI_MOVE_FROM
            .ENDIF
        .ELSE
            JMP GENERATE_AI_MOVE_FROM
        .ENDIF
        
    ADD_MARK:
        .IF TO_INPUT == 1
            .IF FROM_INPUT == 2
                JMP C1U
            .ELSEIF FROM_INPUT == 4
                JMP C1U
            .ELSEIF FROM_INPUT == 5
                JMP C1U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 2
            .IF FROM_INPUT == 1
                JMP C2U
            .ELSEIF FROM_INPUT == 3
                JMP C2U
            .ELSEIF FROM_INPUT == 5
                JMP C2U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 3
            .IF FROM_INPUT == 2
                JMP C3U
            .ELSEIF FROM_INPUT == 5
                JMP C3U
            .ELSEIF FROM_INPUT == 6
                JMP C3U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 4
            .IF FROM_INPUT == 1
                JMP C4U
            .ELSEIF FROM_INPUT == 5
                JMP C4U
            .ELSEIF FROM_INPUT == 7
                JMP C4U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 5
            .IF FROM_INPUT == 1
                JMP C5U
            .ELSEIF FROM_INPUT == 2
                JMP C5U
            .ELSEIF FROM_INPUT == 3
                JMP C5U
            .ELSEIF FROM_INPUT == 4
                JMP C5U
            .ELSEIF FROM_INPUT == 6
                JMP C5U
            .ELSEIF FROM_INPUT == 7
                JMP C5U
            .ELSEIF FROM_INPUT == 8
                JMP C5U
            .ELSEIF FROM_INPUT == 9
                JMP C5U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 6
            .IF FROM_INPUT == 3
                JMP C6U
            .ELSEIF FROM_INPUT == 5
                JMP C6U
            .ELSEIF FROM_INPUT == 9
                JMP C6U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 7
            .IF FROM_INPUT == 4
                JMP C7U
            .ELSEIF FROM_INPUT == 5
                JMP C7U
            .ELSEIF FROM_INPUT == 8
                JMP C7U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 8
            .IF FROM_INPUT == 5
                JMP C8U
            .ELSEIF FROM_INPUT == 7
                JMP C8U
            .ELSEIF FROM_INPUT == 9
                JMP C8U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 9
            .IF FROM_INPUT == 8
                JMP C9U
            .ELSEIF FROM_INPUT == 5
                JMP C9U
            .ELSEIF FROM_INPUT == 6
                JMP C9U
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSE 
            JMP INVALID_MOVE
        .ENDIF

    PRINT_AI_MOVE:
        LEA DX, AI_MESSAGE
        MOV AH, 9
        INT 21H

        LEA DX, MOVES_FROM
        MOV AH, 9
        INT 21H

        .IF FROM_INPUT == 1
            LEA DX, a1
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 2
            LEA DX, b1
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 3
            LEA DX, _c1
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 4
            LEA DX, a2
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 5
            LEA DX, b2
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 6
            LEA DX, _c2
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 7
            LEA DX, a3
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 8
            LEA DX, b3
            MOV AH, 9
            INT 21H
        .ELSEIF FROM_INPUT == 9
            LEA DX, _c3
            MOV AH, 9
            INT 21H
        .ENDIF

        LEA DX, TO_MESSAGE
        MOV AH, 9
        INT 21H

        .IF TO_INPUT == 1
            LEA DX, a1
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 2
            LEA DX, b1
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 3
            LEA DX, _c1
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 4
            LEA DX, a2
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 5
            LEA DX, b2
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 6
            LEA DX, _c2
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 7
            LEA DX, a3
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 8
            LEA DX, b3
            MOV AH, 9
            INT 21H
        .ELSEIF TO_INPUT == 9
            LEA DX, _c3
            MOV AH, 9
            INT 21H
        .ENDIF

        LEA DX, NEWLINE
        MOV AH, 9
        INT 21H

        MOV AH, 2
        MOV DH, 17
        MOV DL, 20
        INT 10H 

        LEA DX, PRESS_ANY_KEY  
        MOV AH, 9
        INT 21H
            
        MOV AH, 7   
        INT 21H
        
        JMP CHECK
    
    TAKEINPUT:
        LEA DX, YOUR_MOVE
        MOV AH, 9
        INT 21H

        LEA DX, FROM
        MOV AH, 9
        INT 21H

        MOV AH, 1 ; Getting letter input
        INT 21H 
        MOV FROM_INPUT_LETTER, AL

        MOV AH, 1 ; Getting number input
        INT 21H 
        MOV FROM_INPUT_NUMBER, AL

        LEA DX, TO
        MOV AH, 9
        INT 21H

        MOV AH, 1 ; Getting letter input
        INT 21H 
        MOV TO_INPUT_LETTER, AL

        MOV AH, 1 ; Getting number input
        INT 21H 
        MOV TO_INPUT_NUMBER, AL

        .IF FROM_INPUT_LETTER == 97 ;a
            .IF FROM_INPUT_NUMBER == 49 ;a1
                MOV FROM_INPUT, 1
            .ELSEIF FROM_INPUT_NUMBER == 50 ;a2
                MOV FROM_INPUT, 4
            .ELSEIF FROM_INPUT_NUMBER == 51 ;a3
                MOV FROM_INPUT, 7
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF FROM_INPUT_LETTER == 98 ;b
            .IF FROM_INPUT_NUMBER == 49 ;b1
                MOV FROM_INPUT, 2
            .ELSEIF FROM_INPUT_NUMBER == 50 ;b2
                MOV FROM_INPUT, 5
            .ELSEIF FROM_INPUT_NUMBER == 51 ;b3
                MOV FROM_INPUT, 8
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF FROM_INPUT_LETTER == 99 ;c
            .IF FROM_INPUT_NUMBER == 49 ;c1
                MOV FROM_INPUT, 3
            .ELSEIF FROM_INPUT_NUMBER == 50 ;c2
                MOV FROM_INPUT, 6
            .ELSEIF FROM_INPUT_NUMBER == 51 ;c3
                MOV FROM_INPUT, 9
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSE
            JMP INVALID_MOVE
        .ENDIF

        .IF TO_INPUT_LETTER == 97 ;a
            .IF TO_INPUT_NUMBER == 49 ;a1
                MOV TO_INPUT, 1
            .ELSEIF TO_INPUT_NUMBER == 50 ;a2
                MOV TO_INPUT, 4
            .ELSEIF TO_INPUT_NUMBER == 51 ;a3
                MOV TO_INPUT, 7
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT_LETTER == 98 ;b
            .IF TO_INPUT_NUMBER == 49 ;b1
                MOV TO_INPUT, 2
            .ELSEIF TO_INPUT_NUMBER == 50 ;b2
                MOV TO_INPUT, 5
            .ELSEIF TO_INPUT_NUMBER == 51 ;b3
                MOV TO_INPUT, 8
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT_LETTER == 99 ;c
            .IF TO_INPUT_NUMBER == 49 ;c1
                MOV TO_INPUT, 3
            .ELSEIF TO_INPUT_NUMBER == 50 ;c2
                MOV TO_INPUT, 6
            .ELSEIF TO_INPUT_NUMBER == 51 ;c3
                MOV TO_INPUT, 9
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSE
            JMP INVALID_MOVE
        .ENDIF

    MOVE_TO:
        MOV CL, CURRENT_MARK
        .IF TO_INPUT == 1
            .IF FROM_INPUT == 2
                .IF C2 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C1_TO
            .ELSEIF FROM_INPUT == 4
                .IF C4 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C1_TO

            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C1_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 2
            .IF FROM_INPUT == 1
                .IF C1 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C2_TO
            .ELSEIF FROM_INPUT == 3
                .IF C3 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C2_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C2_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF 
        .ELSEIF TO_INPUT == 3
            .IF FROM_INPUT == 2
                .IF C2 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C3_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C3_TO
            .ELSEIF FROM_INPUT == 6
                .IF C6 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C3_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF 
        .ELSEIF TO_INPUT == 4
            .IF FROM_INPUT == 1
                .IF C1 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C4_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C4_TO
            .ELSEIF FROM_INPUT == 7
                .IF C7 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C4_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 5
            .IF FROM_INPUT == 1
                .IF C1 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 2
                .IF C2 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 3
                .IF C3 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 4
                .IF C4 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 6
                .IF C6 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 7
                .IF C7 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 8
                .IF C8 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSEIF FROM_INPUT == 9
                .IF C9 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C5_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 6
            .IF FROM_INPUT == 3
                .IF C3 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C6_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C6_TO
            .ELSEIF FROM_INPUT == 9
                .IF C9 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C6_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 7
            .IF FROM_INPUT == 4
                .IF C4 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C7_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C7_TO
            .ELSEIF FROM_INPUT == 8
                .IF C8 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C7_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF   
        .ELSEIF TO_INPUT == 8
            .IF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C8_TO
            .ELSEIF FROM_INPUT == 7
                .IF C7 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C8_TO
            .ELSEIF FROM_INPUT == 9
                .IF C9 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C8_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 9
            .IF FROM_INPUT == 8
                .IF C8 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C9_TO
            .ELSEIF FROM_INPUT == 5
                .IF C5 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C9_TO
            .ELSEIF FROM_INPUT == 6
                .IF C6 == 88
                    JMP INVALID_MOVE
                .ELSE 
                    MOV VALID_FROM, 1
                .ENDIF
                MOV VALID_MOVE, 1
                JMP CHECK_C9_TO
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ENDIF

    WRONG_INPUT:
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H 
            
        LEA DX, WI  
        MOV AH, 9
        INT 21H
        
        MOV AH, 7  
        INT 21H
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
            
        LEA DX, EMP  
        MOV AH, 9
        INT 21H  
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H 
        
        JMP INPUT

    INVALID_MOVE:
        MOV NUM_OF_O, 3
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H 
            
        LEA DX, INVALID_MESSAGE  
        MOV AH, 9
        INT 21H
        
        MOV AH, 7   
        INT 21H
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
            
        LEA DX, EMP  
        MOV AH, 9
        INT 21H  
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H 
        
        JMP INPUT       

    TAKEN:
        .IF PLAYER == 50 ;AI
        JMP INPUT
        .ENDIF

        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H   
            
        LEA DX, TKN   
        MOV AH, 9
        INT 21H  
        
        MOV AH, 7     
        INT 21H 
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
            
        LEA DX, EMP  
        MOV AH, 9
        INT 21H 
        
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
        
        JMP INPUT

        CHECK_C1_TO:
            .IF C1 == 88 ;X
                JMP TAKEN
            .ELSEIF C1 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C2_TO:
            .IF C2 == 88 ;X
                JMP TAKEN
            .ELSEIF C2 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF
        
        CHECK_C3_TO:
            .IF C3 == 88 ;X
                JMP TAKEN
            .ELSEIF C3 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C4_TO:
            .IF C4 == 88 ;X
                JMP TAKEN
            .ELSEIF C4 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C5_TO:
            .IF C5 == 88 ;X
                JMP TAKEN
            .ELSEIF C5 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C6_TO:
            .IF C6 == 88 ;X
                JMP TAKEN
            .ELSEIF C6 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C7_TO:
            .IF C7 == 88 ;X
                JMP TAKEN
            .ELSEIF C7 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C8_TO:
            .IF C8 == 88 ;X
                JMP TAKEN
            .ELSEIF C8 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        CHECK_C9_TO:
            .IF C9 == 88 ;X
                JMP TAKEN
            .ELSEIF C9 == 79 ;O
                JMP TAKEN
            .ELSE 
                MOV VALID_TO, 1
                JMP PLAYER_MOVE
            .ENDIF

        PLAYER_MOVE:
            .IF TO_INPUT == 1
                .IF FROM_INPUT == 2
                    .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                        JMP CLEAR_C2
                    .ELSE 
                        JMP INVALID_MOVE
                    .ENDIF
                .ELSEIF FROM_INPUT == 4
                    .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                        JMP CLEAR_C4
                    .ELSE 
                        JMP INVALID_MOVE
                    .ENDIF
                .ELSEIF FROM_INPUT == 5
                    .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                        JMP CLEAR_C5
                    .ELSE 
                        JMP INVALID_MOVE
                    .ENDIF
                .ELSE
                    JMP INVALID_MOVE
                .ENDIF
        .ELSEIF TO_INPUT == 2
            .IF FROM_INPUT == 1
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C1
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 3
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C3
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF 
        .ELSEIF TO_INPUT == 3
            .IF FROM_INPUT == 2
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C2
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 6
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C6
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF 
        .ELSEIF TO_INPUT == 4
            .IF FROM_INPUT == 1
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C1
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 7
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C7
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 5
            .IF FROM_INPUT == 1
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C1
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 2
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C2
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 3
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C3
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 4
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C4
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 6
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C6
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 7
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C7
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 8
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C8
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 9
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C9
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 6
            .IF FROM_INPUT == 3
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C3
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 9
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                JMP CLEAR_C9
                .ELSE 
                JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 7
            .IF FROM_INPUT == 4
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C4
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 8
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C8
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF   
        .ELSEIF TO_INPUT == 8
            .IF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 7
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C7
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 9
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C9
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ELSEIF TO_INPUT == 9
            .IF FROM_INPUT == 8
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C8
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 5
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C5
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSEIF FROM_INPUT == 6
                .IF VALID_MOVE == 1 && VALID_TO == 1 && VALID_FROM == 1
                    JMP CLEAR_C6
                .ELSE 
                    JMP INVALID_MOVE
                .ENDIF
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        .ENDIF

        CLEAR_C1:
            .IF C1 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C1, ' '
            JMP ADD_MARK

        CLEAR_C2:
            .IF C2 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C2, ' '
            JMP ADD_MARK

        CLEAR_C3:
            .IF C3 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C3, ' '
            JMP ADD_MARK

        CLEAR_C4:
            .IF C4 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C4, ' '
            JMP ADD_MARK

        CLEAR_C5:
            .IF C5 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C5, ' '
            JMP ADD_MARK

        CLEAR_C6:
            .IF C6 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C6, ' '
            JMP ADD_MARK

        CLEAR_C7:
            .IF C7 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C7, ' '
            JMP ADD_MARK

        CLEAR_C8:
            .IF C8 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C8, ' '
            JMP ADD_MARK

        CLEAR_C9:
            .IF C9 == 79 ;O
                DEC NUM_OF_O
            .ENDIF

            MOV C9, ' '
            JMP ADD_MARK

        C1U:
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C1, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C2U:
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C2, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C3U:
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C3, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF
        C4U: 
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C4, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C5U: 
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C5, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C6U:
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C6, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C7U: 
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C7, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C8U: 
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C8, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

        C9U:
            INC NUM_OF_O
            .IF NUM_OF_O == 3
                MOV C9, CL
                INC PLAYER_MOVES
                JMP CHECK
            .ELSE
                JMP INVALID_MOVE
            .ENDIF

    TRYAGAIN:             
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H  
        
        MOV AH, 2
        MOV BH, 0
        MOV DH, 10
        MOV DL, 24
        INT 10H

        LEA DX, TRA   
        MOV AH, 9 
        INT 21H
        
        MOV AH, 1     
        INT 21H
        
        CMP AL, 121 ; y
        JZ INIT 
        
        CMP AL, 89 ; Y
        JZ INIT

        CMP AL, 110  ; n
        JZ EXIT
        CMP AL, 78  ; N
        JZ EXIT  
        
        MOV AH, 2
        MOV BH, 0
        MOV DH, 10
        MOV DL, 24
        INT 10H
    
        LEA DX, WI  
        MOV AH, 9
        INT 21H 
        
        MOV AH, 7 
        INT 21H
        
        MOV AH, 2
        MOV BH, 0
        MOV DH, 10
        MOV DL, 24
        INT 10H
    
        LEA DX, EMP  
        MOV AH, 9
        INT 21H
    
        JMP TRYAGAIN 

    EXIT:
        MOV AH, 4CH
        INT 21H 
    MAIN ENDP
END MAIN