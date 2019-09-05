input macro
        mov ah,01h
        int 21h
endm

output macro str
        lea dx,str
        mov ah,09h
        int 21h
endm

strip macro str
        lea dx,str
        mov ah,0ah
        int 21h
endm

strop macro str
        lea dx,str+2
        mov ah,09h
        int 21h
endm
.model small
.data
        msg1 db 10,13,'----------MENU----------',10,13,'1.Concatenation',10,13,'2.Find Substring',10,13,'3.Comparison',10,13,'4.Number of occurances',10,13,'5.Exit',10,13,'------------------------$'
        msg2 db 10,13,'Enter your choice:$'
        msg3 db 10,13,'Enter String:$'
        msg4 db 10,13,'Enter Second String:$'
        msg5 db 10,13,'Enter String for Comparison:$'
        msg6 db 10,13,'Enter Substring:$'
        str1 db 25 dup('$')
        str2 db 25 dup('$')
        public str1, str2
.code
        mov ax,@data
        mov ds,ax
        mov es,ax

        extrn concat  :far
        extrn substr1 :far
        extrn compar  :far
        extrn spec    :far

        main:
                output msg1
                output msg2
                input

                cmp al,31h
                jb main
                jg next
                output msg3
                strip str1

                output msg4
                strip str2
                call concat
                jmp main
       next:
                cmp al,32h
                jne next2
                output msg3
                strip str1


                output msg6
                strip str2
                call substr1
                jmp main
       next2:
                cmp al,33h
                jne next3
                output msg3
                strip str1

                output msg5
                strip str2
                call compar
                jmp main
       next3:
                cmp al,34h
                jne next4

                output msg3
                strip str1
                call spec
                jmp main
       next4:
                mov ah,4ch
                int 21h
end
