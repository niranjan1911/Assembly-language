org 0000h
;Full Step Stepper Motor Sequence
MAIN:
	mov a,#06h
	mov p0,a
	acall delay

	mov a,#0ah
	mov p0,a
	acall delay

	mov a,09h
	mov p0,a
	acall dealy

	mov a,05h
	mov p0,a
	acall delay

delay: mov r3,#01h

here:  mov r4,#01h

here2: djnz r4,here2
       djnz r3,here
ret		
		
