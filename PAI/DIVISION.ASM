.model small
.data
   a db 06
   b db 03
   c db ?
   str1 db 'Division is:',10,13,'$'
.code
   mov ax,@data
   mov ds,ax

  
   mov dx,offset str1
   mov ah,09h
   int 21h

   mov al,a
   mov bl,b
   div bl

   mov al,dl
   add dl,30h


   
   mov ah,02h
   int 21h

   mov ah,4ch
   int 21h
end
