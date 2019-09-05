.model small
.data
   a db 06
   b db 08
   
 
   
.code
   mov ax,@data
   mov ds,ax 
   
   mov al,a
   add al,b

   daa

   mov bl,al
   mov cx,0204h

   

   
 up:
   rol bl,cl
   mov dl,bl

   and dl,0fh
   cmp dl,09h
   jbe @loop
   add dl,07h

 @loop:

     add dl,30h
  
     mov ah,02h
     int 21h

     dec ch
     jnz up
    
   
     mov ah,4ch
     int 21h
   
   
end
