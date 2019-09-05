disp macro msg
   lea dx,msg
   mov ah,09h
   int 21h
endm
  
 
.model small
.data
 count db 00h
 str2 db 'Your string is:',10,13,'$'
 str4 db '',10,13,'$'
 str10 db 'Enter the substring:',10,13,'$'
 ackn db 'String after concat:','$'
 msg1 db 'Strings are equal',10,13,'$'
 msg2 db 'Strings are not equal',10,13,'$'
 msg4 db 'No Substring',10,13,'$'
 msg3 db 'Substring',10,13,'$'
 str3 db 'Enter the another string:',10,13,'$'
 str5 db 20 dup('$')
 extrn str1:byte

.code
 mov ax,@data
 mov ds,ax
 mov es,ax

 public display1,concat,compare,substring,alpha

 display1 proc far

   disp str2
   disp str1+2

 ret
 endp

 concat proc far
   disp str4
   disp str3
   lea dx,str5
   mov ah,0ah
   int 21h

   mov ch,str1+1
   ;add ch,01h
   lea si,str1+2
 up:
    inc si
    dec ch
    jnz up

   lea di,str5+2
   mov ch,str5+1
 down:
    mov ax,[di]
    mov [si],ax
    inc si
    inc di
    dec ch
    jnz down

  disp str4
  disp str1+2

 ret
 endp

 proc compare far

   disp str4
   disp str3
   lea dx,str5       
   mov ah,0ah
   int 21h

   mov al,str1+1
   mov bl,str5+1
   cmp al,bl
   jne last

   mov cx,0000h
   mov cl,str1+1

   lea si,str1+2
   lea di,str5+2
   repe cmpsb
   jnz last
   disp msg1
   ret
 last:
   disp msg2

 ret
 endp

 proc substring far

   disp str4
   disp str10
   lea dx,str10       
   mov ah,0ah
   int 21h

   mov al,str10+1
   mov bl,str1+1
   cmp al,bl
   jg last1

   mov ch,str10+1
   mov cl,str1+1
   lea di,str10+2
   lea si,str1+2
 check:
   mov al,[si] 
   mov bl,[di]
   cmp al,bl
   jne next
   inc si
   inc di
   dec ch
   jnz check
   inc count
   disp msg3
   disp str4
   ret

 next:
      inc si
      cmp ch,str10+1
      jne last1
      dec cl
      jz last1
      jmp check
 last1:
    disp msg4


 ret
 endp

 proc alpha far

 ret
 endp




 mov ah,4ch
 int 21h

end

