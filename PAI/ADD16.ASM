.model small
.data
   a db 13h
   b db 11h
   c db ?
   str db 'Result is:',10,13,'$'
.code
   mov ax,@data
   mov ds,ax

  
   mov dx,offset str
   mov ah,09h
   int 21h

   mov al,a
   add al,b

  
   add al,30h
   mov c,al

   mov dl,c 
   mov ah,02h
   int 21h

   mov ah,4ch
   int 21h
end
