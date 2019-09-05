input macro
        mov ah,01h
        int 21h
endm

output macro str
        mov ah,09h
        lea dx,str
        int 21h
endm


strip macro str
        lea dx,str
        mov ah,0ah
        int 21h
endm

strop macro str
        mov ah,09h
        lea dx,str+2
        int 21h
endm

.model small
.data
        men  db 10,13,'-----------MENU-----------$'
        msg1 db 10,13,'1.Find Length',10,13,'2.Display',10,13,'3.Reverse',10,13,'4.Palindrome',10,13,'5.Exit$'
        emen db 10,13,'--------------------------$'
        msg2 db 10,13,'Enter your choice:$'
        msg3 db 10,13,'Length:$'
        msg4 db 10,13,'Entered String:$'
        msg5 db 10,13,'Reverse:$'
        msg6 db 10,13,'String is Palindrome.$'
        msg7 db 10,13,'String is Not Palindrome.$'
        msg8 db 10,13,'Enter string:$'
        spc  db 10,13,'$'
        str1 db 25 dup('$')
        str2 db 25 dup('$')
.code
        mov ax,@data
        mov ds,ax

        main:
                output men
                output msg1
                output emen
                output msg2
                
                input
                cmp al,31h
                jne next1
                call len
                jmp main
        next1:
                cmp al,32h
                jne next2
                call disp
                jmp main
        next2:
                cmp al,33h
                jne next3
                call strrev
                jmp main
        next3:
                cmp al,34h
                jne next4
                call palin
                jmp main
        next4:
                mov ah,4ch
                int 21h

        len proc near
                output msg8
                strip str1
                output msg3
                lea si,str1
                mov dl,[si+1]
                add dl,30h
                mov ah,02h
                int 21h
                ret
        len endp

        disp proc near
                output msg8
                strip str1
                output msg4
                strop str1
        ret
        disp endp

        strrev proc near
                output msg8
                strip str1
                output msg4
                strop str1
                output msg5

                ;mov cl,str1+1
                lea si,str1+1
                rep movsb
               
                lea di,str2+2
                mov cl,str1+1
                lop:
                        mov dl,[si]
                        mov [di],dl
                        inc di
                        dec si
                        dec cl
                jnz lop
                strop str2
        ret
        strrev endp

        palin proc near
                call strrev
                lea si,str1+2
                lea di,str2+2

                mov cl,str1+1
              down:
                mov al,[si]
                mov bl,[di]
                cmp al,bl
                jne fin
				inc si
				inc di
                dec cl
                jnz down
                jmp equl
              fin:
                        output msg7 
                        ret
              equl:
                        output msg6
        ret
        palin endp
end
