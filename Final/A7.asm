org 0000h

mov r0,#20h
mov r1,#30h
mov r2,#05h

here:
	mov a,@r0
	mov @r1,a
	inc r0
	inc r1
	djnz r2,here
label:
	sjmp label
end
