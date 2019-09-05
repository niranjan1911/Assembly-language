.model small


.data
          
STRING db 10,13, "Enter Array No : $"
PROMPTMSG db, 10, 13, "Enter How Many Numbers : $"
SPACE db " + $"
EQUAL db " = $"

ARRAY db 10 DUP(0)



.code


mov AX, @data
mov DS, AX

LEA DX, PROMPTMSG
mov AH, 09h                                                   
int 21h           ;prompt user to input number of inputs

mov AH, 01h
int 21h           ;take input

xor CX, CX        ;clear cx register
xor BX, BX        ;clear bx register
mov BL, AL        ;store input in register BL
sub BL, 30h       ;bring it in range for taking proper input

mov CL, BL        ;initialise register CX for looping


LEA DX, STRING    ;prompt message for input
mov AH, 09h
int 21h


LEA SI, ARRAY     ;load address of array in SI
LEA DX, SPACE     ;load address for spacing string


loop1:            ;LOOP START

 mov ah, 01h      ;input character
 int 21h

 mov [SI], al     ;store in array

 mov ah, 09h      ;give space
 int 21h

 inc SI           ;increment address of ARRAY by 1
 dec cx           ;decrease count by 1

 cmp cx, 0        ;compare if register CX is zero?

 jnz loop1        ;LOOP END


LEA SI, ARRAY     ;load address of array in SI again

xor cx, cx       ;clear register cx
mov cl, bl       ;move no of inputs to register CX
xor ax, ax       ;clear register ax

add al, [SI]     ;add array number to al
sub ax, 30h      ;subtract it from 30h to bring it in range
inc si           ;increase address location by 1
dec cx           ;decrease count


loop2:           ;LOOP START

 add al, [SI]    ;continue adding number of array to al
 sub ax, 30h     ;bring it in range

 inc si          ;increase location by 1 
 dec cx          ;decrease count

 cmp cx, 0

 jnz loop2       ;LOOP END

mov cl, 10D      ;mov decimal 10 to cl
div cl           ;divide by decimal 10, Q = AH, R = AL

mov cx, ax       ;copy result to register CX

add cx, 3030h    ;bring it in range

LEA dx, EQUAL
mov ah, 09h
int 21h

mov dl, cl       ;send first number for printing
mov ah, 02h
int 21h

mov dl, ch       ;send second number for printing
mov ah, 02h
int 21h


mov ah, 4ch      ;END PROGRAM
int 21h

END





      
      


        

 


