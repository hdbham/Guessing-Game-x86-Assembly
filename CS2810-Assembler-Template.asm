TITLE CS2810 Assembler Template

; Student Name: Hunter Burningham
; Assignment Due Date: 12/5/2021

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vName byte "Hunter Burningham",0
	vAssignment byte "Assembler Assignment #4",0
	vSemester byte "CS2810 Fall Semester 2021",0
	
	vStartprompt byte "Guess a number between 0 and 100: ",0
	vGuessAgain byte "Guess Again! ",0
	VGreater byte " is too high",0
	VLess byte " is too low",0
	vCorrect byte " is the correct answer!",0

	vAgain byte "Would you like to play again (1 for yes, 0 for no)",0
	vBye byte "Thanks for playing!",0
	vCarriageReturn byte 13,10,0 ;adds a line

.code
main PROC
	;--------- Enter Code Below Here
	Call header
	call StartGame

	xor ecx, ecx
	call readchar

	Header:
		mov dh, 4
		mov dl, 0
		call gotoxy
		mov edx, offset vSemester
		call WriteString

		mov dh, 5
		mov dl, 0
		call gotoxy
		mov edx, offset vAssignment
		call WriteString

		mov dh, 6
		mov dl, 0
		call gotoxy
		mov edx, offset vName
		call WriteString

		ret

	StartGame:

		mov edx, offset vCarriageReturn
		call WriteString
		call WriteString

		mov eax, 101
		call RandomRange 

		mov ecx, eax  ; make copy of number

		mov edx, offset vStartPrompt
		call writeString

		jmp CheckGuess

	CheckGuess:

		call ReadDec

		
		call WriteDec		;appends answer given to whichever offset
		
		
		;--------------------------if greater conditional greater than jump to "GREATER""
		cmp eax, ecx 
		jg GREATER

		;--------------------------if less conditional less than jump to "LESS"
		cmp eax, ecx 
		jl LESS
	
		;---------------------------otherwise correct uncondtitional jump (else), jump to "CORRECT"
		jz CORRECT

		
		CORRECT:
			mov edx, offset vCorrect ;display correct message
			call writestring
			mov edx, offset vCarriageReturn
			call writestring
			mov edx, offset vGuessAgain

			jmp AskReset
	
		GREATER:
			mov edx, offset vGreater
			call writestring
			
			mov edx, offset vCarriageReturn
			call writestring
			
			jmp GuessAgain

		LESS:
			mov edx, offset vLess
			call writestring

			mov edx, offset vCarriageReturn
			call writestring
			
			jmp GuessAgain
	
		GuessAgain:
			mov edx, offset vGuessAgain
			call writestring
			
			jmp CheckGuess

	AskReset:
		
		;---------------------------Prompt for play again
		mov edx, offset vAgain 
		call writestring
		
		call ReadDec ;reads input

		;if 1 jump to StartGame
		cmp eax, 1
		jz StartGame

		;else
		mov edx, offset vCarriageReturn
		call writestring
		mov edx, offset vBye ;displays exit message
		
		ret

	
	exit
main ENDP

END main