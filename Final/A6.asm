org 0000h

mov r0,#40h
mov r1,#5h
clr a
	mov 40h,#0ffh
	mov 41h,#0ffh
	mov 42h,#0ffh
	mov 43h,#0ffh
	mov 44h,#0ffh
back:
	add a,@r0
	jnc down
	inc r7
down:
	inc r0
	mov r6,a
	dec r1
	cmp r1,00h
	jnz back
here:
	sjmp here
end

