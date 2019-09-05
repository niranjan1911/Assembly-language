disp macro str1
   lea dx,str1
   mov ah,09h
   int 21h
endm

.model small
.data
   a db 06
   b db 03
   c db ?
   str1 db 'Result is:',10,13,'$'
   str2 db ' ',10,13,'$'
.code
   mov ax,@data
   mov ds,ax

   disp str2
   disp str1
   mov al,a
   add al,b

  
   add al,30h
   mov c,al

   mov dl,c 
   mov ah,02h
   int 21h

   disp str2
   disp str1
   mov al,a
   sub al,b

  
   add al,30h
   mov c,al

   mov dl,c 
   mov ah,02h
   int 21h

   mov ah,4ch
   int 21h
end
