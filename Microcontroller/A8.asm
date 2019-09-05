org 0000h


mov TMOD,#20h
mov SCON,#50h
mov TH1,#-3
setb TR1

again:
	mov A,#'K'
	ACALL TRANS


	mov A,#'A'
	ACALL TRANS


	mov A,#'L'
	ACALL TRANS


	mov A,#'P'
	ACALL TRANS


	mov A,#'I'
	ACALL TRANS


	mov A,#'T'
	ACALL TRANS

	sjmp AGAIN

TRANS:
        mov SBUF,A
    l1:
        JNB TI,l1
        clr TI
ret
 end
