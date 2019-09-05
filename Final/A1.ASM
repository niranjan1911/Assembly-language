input macro
     mov ah,01h
     int 21h
endm

output macro
     mov ah,02h
     int 21h
endm

outputstr macro str
     lea dx,str
     mov ah,09h
     int 21h
endm

.model small
.data
     msg1 db 10,13,'Enter Size of Array (Less than 10):','$'
     msg2 db 10,13,'Enter array elements:$'
     msg3 db 10,13,'Array elements are:$'
     msg4 db 10,13,'Addition is:$'
     msg5 db 10,13,'Do you want to continue (1/0)?','$'
     msg6 db 10,13,'Exiting....$'

     arr db 10 dup(0)
     sz db 0
     sum db 0
.code
     mov ax,@data
     mov ds,ax

     outputstr msg1
     input
     sub al,30h
     mov sz,al
     mov cl,sz
     lea si,arr
     up:
        outputstr msg2
        input
        mov [si],al
        inc si
        dec cl
        jnz up

     outputstr msg3
     lea si,arr
     mov cl,sz
     lop:
        mov dl,[si]
        output

        mov dl,20h   ; To give space
        output

        inc si
        dec cl
        jnz lop

     ;Adding Array Elements

     lea si,arr
     mov cl,sz
     logic:
        mov al,[si]
        sub al,30h
        add sum,al

        mov al,sum
        daa
        mov sum,al
        inc si
        dec cl
        jnz logic

     outputstr msg4
     mov al,sum
     mov bl,al
     mov cx,0204h
     next:
          rol bl,cl
          mov dl,bl
          and dl,0fh
          cmp dl,09h
          jbe down
          add dl,07h
     down:
          add dl,30h
          output
          dec ch
          jnz next

     outputstr msg5
     input
     cmp al,31h
     jne ext
     lea si,arr
     jmp up
     ext:
          outputstr msg6 
     mov ah,4ch
     int 21h
end
