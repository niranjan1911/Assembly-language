.model small
.data
   a db 05
   b db 03
   c db ?
   str1 db 'Result is:',10,13,'$'
.code
   mov ax,@data
   mov ds,ax

  

   mov dx,offset str1
   mov ah,09h
   int 21h

   mov ax,0000h
   mov al,a 
   div b

  
   add al,30h
   mov c,al

   mov dl,c 
   mov ah,02h
   int 21h

   mov ah,4ch
   int 21h
end
