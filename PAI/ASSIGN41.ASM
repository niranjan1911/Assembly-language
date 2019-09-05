disp macro msg
  lea dx,msg
  mov ah,09h
  int 21h
endm

input macro 
  mov ah,01h
  int 21h
endm


.model small
.data
  str1 db 25 dup('$')
  str4 db 'Enter the string:',10,13,'$'
  menu db 10,13,'1.Display',10,13,'2.Concat',10,13,'3.Compare',10,13,'4.Substring',10,13,'5.Aplhabets & Symbols',10,13,'6.Exit',10,13,'$'
  msg1 db 'Wrong choice....!',10,13,'$'
  public str1

.code
 

  mov ax,@data
  mov ds,ax
  mov es,ax

  disp str4

  lea dx,str1
  mov ah,0ah
  int 21h

  extrn display1:far
  extrn concat:far
  extrn compare:far
  extrn substring:far
  extrn alpha:far
 main:
     disp menu
     input
     cmp al,31h
     jne next
     call display1
     jmp main
 next:
     cmp al,32h
     jne next1
     call concat
     jmp main
 next1:
     cmp al,33h
     jne next2
     call compare
     jmp main
 next2:
     cmp al,34h
     jne next3
     call substring
     jmp main
 next3:
     cmp al,35h
     jne next4
     call alpha
     jmp main
 next4:
     cmp al,36h
     jne next5
     mov ah,4ch
     int 21h
 next5:
     disp msg1
     jmp main
     
    
end
