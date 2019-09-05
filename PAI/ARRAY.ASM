disp macro msg
  lea dx,msg
  mov ah,09h          ;Macro for displaying string
  int 21h
endm

output macro
      ;mov dl,al
      mov ah,02h      ;Macro for displaying single number
      int 21h
endm

.model small
.data
  count db 6
  sum db 0
  a db 14h,02h,03h,04h,11h,12h

  str2 db 'elements of array is:',10,13,'$'
  str3 db '',10,13,'$'
  str5 db 'Addition is:',10,13,'$'
.code
      mov ax,@data
      mov ds,ax
  
      disp str2

     
      lea si,a
     
  down:
      mov al,[si]
       mov cx,0204h
      mov bl,al
    up:
      rol bl,cl
      mov dl,bl
      and dl,0fh
      cmp bl,09h
      jbe down
      output
      dec ch
      jnz up

      disp str3
                         ; DISPLAYING ARRAY elements 
      inc si
      jnz down
      

      
      mov ch,count
      lea si,a
      mov al,00h
 addition:
      mov al,[si]       
      add al,sum
      daa                ;ADDITION OF ARRAY ELEMENTS
      mov sum,al
      inc si
      dec ch
      jnz addition

      disp str3
      disp str5
      
      mov bl,sum
      mov cx,0204h
    up1:
       rol bl,cl
       mov dl,bl

       and dl,0fh        ;DISPLAYING TWO DIGIT WITH ROTATING LOGIC
       cmp dl,09h
       jbe @loop
       add dl,07h
       

   @loop:
        add dl,30h

        output

        dec ch
        jnz up1
       
    
      
      mov ah,4ch        ;ITS OVER........
      int 21h
end
