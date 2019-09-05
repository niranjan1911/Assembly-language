org 0000h

;Commands
mov a,#38h
acall cmmd
acall delay

mov a,#80h
acall cmmd
acall delay

mov a,#0Eh
acall cmmd
acall delay

mov a,01h
acall cmmd
acall delay

mov a,#06h
acall cmmd
acall delay

;Data
mov a,#'K'
acall datawrd
acall delay

mov a,#'A'
acall datawrd
acall delay

mov a,#'L'
acall datawrd
acall delay

mov a,#'P'
acall datawrd
acall delay

mov a,#'I'
acall datawrd
acall delay

mov a,#'T'
acall datawrd
acall delay


cmmd:
	mov p2,a
	clr p1.0  ;Clearing RS bit i.e. For Command, it is 0
	clr p1.1  ;Clearing R/#W i.e. Set for Write
	setb p1.2 ;Set Enable Bit

	acall delay
	clr p1,2
	ret

datawrd:
	mov p2,a
	setb p1.0 ;Set for Data
	clr p1.1
	setb p1.2

	acall delay
	clr p1.2
	ret

delay:	mov r3,#01h

here:	mov r4,#01h

here2:	djnz r4,here2
	djnz r3,here
	ret
