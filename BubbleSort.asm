;Project Code Name:: SMASHING SQUIRTILES
;The purpose of this project is to take 10 numbers that are given
;by the user and sort them in ascending order (1,2,3,4...i++)
;R1 holds ASCII
;R2 HOLDS STACK

.ORIG x3000

;INTRODUCTION

	LEA R0, INTRO	
	PUTS
	

;Takes user input and puts it into an array/stack
LOOP	IN			;ASKS FOR USER INPUT
	LD R1, ASCII_INVERSE	;PUTS -48 INTO REGISTER 1
	ADD R0, R0, R1
	BRp PUSH
	
COUNT	LEA R5, COUNTER		;COUNTER
	LD R3, #1		;LOAD 1 INTO R3
	NOT R3, R3		;TWO'S COMPLIMENT
	ADD R3, R3, #1		;
	
	ADD R5, R5, R3
	;BRz BUBBLE		;BRANCH TO BUBBLE
	JSR LOOP		;=/ BUBBLE THEN JMP BACK TO LOOP TILL COUNTER == 0
	
	
	;PUSH ONTO STACK
	
PUSH	AND R2, R2, #0		;CHECKS THE STACK FOR FULLNESS
	AND R1, R1, #0
	ST R2, SAVE2
	ST R1, SAVE1
	LD R1, TOP
	ADD R2, R6, R1
	BRz FAIL_EXIT		;IF FULL WILL EXIT
	STR R0, R6, #0		;PUSHES ONTO STACK
	ADD R6, R6, #-1
	JSR COUNT

POP	AND R2, R2, #0		;CHECKS STACK FOR EMPTINESS
	AND R1, R1, #0
	ST R2, SAVE2
	ST R1, SAVE1
	LD R1, BASE
	ADD R1, R1 #-1
	ADD R2, R6, R1
	BRz FAIL_EXIT		;IF EMPTY , WILL EXIT
	ADD R6, R6, #1		;POPS OFF THE STACK
	LDR R0, R6, #0
	BRnzp EXIT
	
EXIT	LD R1, SAVE1
	LD R2, SAVE2
	AND R5, R5, #0
	RET

FAIL_EXIT
	LD R1, SAVE1
	LD R2, SAVE2
	AND R5, R5, #0
	ADD R5, R5, #1
	RET
	
	
	

;Where the sorting takes place
BUBBLE	LDR R4, R6, #0		;Load R2  plus 0 into R4
	ADD R6, R6, #1		;Adds 1 to R2
	BR POP			;removes value
	LDR R3, R2, #0;		;Loads content of R2 into R3
	ADD R2, R2, #1;		;ADds 1 to R3
	NOT R3, R3		; Twos compliement
	ADD R3, R3, #1;
	ADD R5, R4, R3;
	BRn			;Branch to BRn when outcome is negative
	
	BUBBLE			;call itself
	
BRn	ADD R6, R4, #0
	NOT R4, R4;
	ADD R4, R4, R6;
	ADD R3, R4;
	
	LEA R0, DEBUG



HALT   
INTRO			.STRINGZ "Lets organize shall we!\nEnter 10 numbers\n"
ASCII_INVERSE		.FILL #-48
BASE			.FILL x2FE0	;STARTS AT 0
TOP			.FILL x2FFB	;TOP IS 10 WITH NULL TERMINATED
SAVE1			.FILL x0000
SAVE2			.FILL x0000
DEBUG			.STRINGZ "HERE"
COUNTER			.FILL #3
.END
