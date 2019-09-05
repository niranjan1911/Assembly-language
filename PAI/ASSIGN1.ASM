disp macro msg
  lea dx,msg
  mov ah,09h          ;Macro for displaying string
  int 21h
endm

input macro
    mov ah,01h        ;Macro for inputing single number from user
    int 21h
endm

output macro
      ;mov dl,al
      mov ah,02h      ;Macro for displaying single number
      int 21h
endm

.model small
.data
  count db ?
  sum db 0
  a db 10 dup(?)
  str1 db 'Enter the elements:',10,13,'$'
  msg db 'Enter the number of elements in array:',10,13,'$'
  str2 db 'elements of array is:',10,13,'$'
  str4 db 'Number:',10,13,'$'
  str3 db '',10,13,'$'
  str5 db 'Addition is:',10,13,'$'
.code
      mov ax,@data
      mov ds,ax

      disp msg
      input
      disp str3           ;TAKING HOW MANY NUMBERS IN YOUR ARRAY
      sub al,30h
      mov count,al

      disp str1

      mov ch,count
      lea si,a

  up:
      disp str4
      input
      disp str3          ;TAKING ACRTUAL ELEMENTS OF YOUR ARRAY
      mov [si],al
      inc si
      dec ch
      jnz up

  
      disp str2

      mov ch,count
      lea si,a
  down:
      mov al,[si]
      mov dl,al
      output
      mov al,20h         ; DISPLAYING ARRAY ELEMENTS
      mov dl,al
      output
      inc si
      dec ch
      jnz down

      
      mov ch,count
      lea si,a
      mov al,00h
 addition:
      mov al,[si]
      sub al,30h        
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

       and dl,0fh        ;DISPLAYING TWO DIGIT ADDITION WITH ROTATING LOGIC
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
