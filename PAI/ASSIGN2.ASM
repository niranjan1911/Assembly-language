
;------------------ASSIGNMENT 2----------------------
;NAME : Kalpit Choudhari
;ROLL NO : 23375
;----------------------------------------------------

disp macro msg
    mov dx,offset msg        ;MACRO FOR DISPLAY STRING
    mov ah,09h
    int 21h
endm

input macro
    mov ah,01h         ;MACRO FOR TAKING INPUT
    int 21h
endm

.model small

.data
    menu db '1.BCD TO HEX',10,13,'2.HEX TO BCD',10,13,'3.EXIT',10,13,'$'
    str1 db 'You are in bcd to hex converter$',10,13
    str2 db 'You are in hex to bcd converter$',10,13
    str3 db 'Wrong Choice',10,13,'$'
    str4 db '',10,13,'$'
    str5 db 'Enter the number',10,13,'$'
    str10 db 'Enter the number VALID:0-9,a-f,A-F',10,13,'$'
    str6 db 'BCD Number:',10,13,'$'
    str7 db 'HEX Number:',10,13,'$'
    str11 db 'result is:',10,13,'$'
    str8 db 'The first number should not greater than 6...',10,13,'$'
    cha db 01h
    array dw 10000,1000,100,10,1
    res dw 0000h
    a db 5 dup(?)
    count db 0000h

.code
    mov ax,@data
    mov ds,ax           ;INITIALIZE THE DATA SEGMENT 
                        ;IN CODE SEGMENT


  m1:
    disp str4
    disp menu
    input
    cmp al,31h
    jne next1
    call bcdhex
    jmp m1

 next1:
    cmp al,32h             ;TAKING USER INPUT
    jne next2
    call hexbcd
    jmp m1

 next2:
    cmp al,33h
    jne loop@
    mov ah,4ch
    int 21h

 loop@:
   disp str3


    bcdhex proc near

    disp str4
    disp str1
    disp str4

   

    
    mov ch,05h
    lea si,array
    lea di,a
    mov res,0000h
    disp str4   
    disp str5

  up:
   
    input
   
    sub al,30h
    cmp al,06h
    jbe addi
     disp str4
     disp str8
     jmp up

 addi:
    dec cha
    mov [di],al
    mov ah,00h
    mov dx,[si]
    mul dx
    add res,ax
    inc si
    inc si
    inc di
    dec ch
    jnz up

    disp str4
    disp str6
    mov ch,05h
    lea di,a
  display1:
    mov dl,[di]
    add dl,30h

    mov ah,02h
    int 21h

    inc di
    dec ch
    jnz display1






    
    disp str4
    disp str7
    mov cx,0404h
    mov bx,res
  down:
    rol bx,cl
    mov dx,bx

    and dl,0fh
    cmp dl,09h
    jbe add1
    add dl,07h

  add1:
      add dl,30h

      mov ah,02h
      int 21h

      dec ch
      jnz down



    ret
    bcdhex endp

    hexbcd proc near

      disp str4
     disp str2
      disp str4
    mov bx,0000h
    mov cx,0404h
    disp str5

  main:
    
    disp str4
    disp str10
     disp str4
    
    mov ch,04h
  up1:
    input
    cmp al,30h
    jb main
    cmp al,39h
    jg up2
    sub al,30h
    jmp up4
 up2:
    cmp al,41h
    jb main
    cmp al,46h
    jg up3
    sub al,37h
    jmp up4
  up3:
     cmp al,61h
     jb main
     cmp al,66h
     jg main    
     sub al,57h
     jmp up4
  up4:
    mov ah,00h
    rol bx,cl
    add bx,ax
    dec ch
    jnz up1


    mov count,0000h
    mov ax,bx
    mov bx,000ah
    mov dx,0000h
  down1:
    div bx 
    push dx
    inc count
    mov dx,0000h
    cmp ax,0000h
    jne down1

   disp str4
   disp str11
  mov ch,count
 down2:
    pop ax

   mov dx,ax
   add dx,0030h
   mov ah,02h
   int 21h
   dec ch
   jnz down2
   
  
    ret
  hexbcd endp

end
