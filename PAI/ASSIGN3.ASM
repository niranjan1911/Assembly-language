;------------------------------------------------------------- 
                ;NAME:Kalpit Choudhari
                ;ROLL NO:23375
                ;CLASS:SE IT
                ;BATCH:H11
;-------------------------------------------------------------

input macro
  mov ah,01h    ;MACRO FOR TAKING INPUT AS A SINGLE VALUE
  int 21h
endm

disp macro msg
  lea dx,msg
  mov ah,09h    ;MACRO FOR DISPLYAING THE STRING MESSAGE
  int 21h
endm

.model small

.data
   str1 db 15 dup('$')
   res db 25 dup('$')
   str2 db 10,13,'1.INPUT', 10,13,'2.DISPLAY',10,13,'3.LENGTH',10,13,'4.REVERSE',10,13,'5.PALINDROME',10,13,'6.EXIT',10,13,,'Enter your choice$'
   str3 db 10,13,'Wrong choice...!$'
   str4 db '',10,13,'$'
   str5 db 'Enter the string',10,13,'$'
   str6 db 'Your string is:',10,13,'$'
   str7 db 'length is:',10,13,'$'
   str8 db 'Reverse string is:',10,13,'$'
   str9 db ' string is palindrome',10,13,'$'
   str10 db ' string is not palindrome',10,13,'$'
   emp db  'Empty string...',10,13,'$'
.code
   mov ax,@data
   mov ds,ax       ;INITIALIZING DATA SEGMENT

 main:
   disp str2
   input
  
    cmp al,31h
    jne next1
    call get
    jmp main
   next1:
    cmp al,32h
    jne next2
    call put
    jmp main
   next2:
    cmp al,33h
    jne next3
    call len
    jmp main
  next3:
    cmp al,34h
    jne next4
    call reverse
    jmp main
  next4:
    cmp al,35h
    jne next5
    call palin
    jmp main
 next5:
    cmp al,36h
    jne next6
    mov ah,4ch
    int 21h
 next6:
     disp str3
     jmp main
    
    mov dx,0000h
    get proc near

    disp str4
    disp str5             ;GET PROCEDURE TO TAKE A STRING FROM USER
   
    mov dx,offset str1
    mov ah,0ah   ;taking string input
    int 21h

    ret
    get endp

    put proc near

   ; disp str4

    ;cmp str1+2,'$'
    ;jne put1
   ; disp emp
   ; ret

   put1:
    disp str4
    disp str6            ;FOR DISPLAYING STRING
    mov dx,offset str1+2
    mov ah,09h
    int 21h

    ret
    put endp

    len proc near

    ;disp str4

    ;cmp str1+2,'$'
    ;jne len1
    ;disp emp
    ;ret
  len1:
    disp str4
    disp str7
    mov dl,str1+1    ;FOR FINDING THE LENGTH OF STRING

    mov al,dl
    daa
    mov bl,al

    mov cx,0204h
    ;mov bl,dl
  uper:
    rol bl,cl
    mov dl,bl
    and dl,0fh
    cmp dl,09h           ;display 
    jbe @print
    add dl,07h
  @print:
     add dl,30h
     mov ah,02h
     int 21h

     dec ch
     jnz uper

    
    ret
    len endp

    reverse proc near

   ; disp str4

   ; cmp str1+2,'$'
    ;jne reverse1
    ;disp emp
   ; ret

  reverse1:
    disp str4
    disp str8
    mov cx,0000h
    mov dx,0000h
    mov cl,str1+1
    sub cl,01h
   

     lea si,str1+2
     lea di,res+2
     rep movsb

    mov ch,str1+1
    lea di,res+2

  yes:
    mov dx,[si]
    mov [di],dx
    mov ah,02h
    int 21h
    dec si
    inc di
    dec ch
    jnz yes
    


    ret
    reverse endp

    palin proc near

    ;disp str4

    ;cmp str1+2,'$'
    ;jne palin1
    ;disp emp
    ;ret
 palin1:
    call reverse
    disp str4
    lea si,str1+2
    lea di,res+2
    mov ch,str1+1
   no:
    mov al,[si]
    mov bl,[di]
    cmp al,bl
    jne over
    inc si
    inc di
    dec ch
    jnz no
    disp str9
    jmp ab
   over:
    disp str10
    jmp main
    ab:
    jmp main

    ret
    palin endp 
   


   mov ah,4ch
   int 21h
end


