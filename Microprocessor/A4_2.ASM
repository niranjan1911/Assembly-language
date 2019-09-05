output macro str
        lea dx,str
        mov ah,09h
        int 21h
endm

ipstr macro str
        lea dx,str
        mov ah,0ah
        int 21h
endm

opstr macro str
        lea dx,str+2
        mov ah,09h
        int 21h
endm
.model small
.data
        extrn str1:byte
        extrn str2:byte

        con  db 10,13,'Concatenated String :$'
        subs db 10,13,'Substring is :$'
        equl db 10,13,'Both are Equal$'
        nequ db 10,13,'Not Equal$'
        spe  db 10,13,'Special Characters:$'
        nl   db 10,13,'$'
        u    db 10,13,'Upper case:$'
        l    db 10,13,'Lower Case:$'
        s    db 10,13,'Special Symbol:$'
        d    db 10,13,'Digit:$'
        su   db 10,13,'Substring Found!$'
        nsu  db 10,13,'Not Substring$'
        upr  db 0
        lwr  db 0
        sep  db 0
        dig  db 0
.code
        mov ax,@data
        mov ds,ax
        mov es,ax

        public concat
        public substr1
        public compar
        public spec
      
        concat proc far
                output nl
                mov cl,str1+1
                lea si,str1+1
                l1:
                   inc si
                   dec cl
                   jnz l1

                mov cl,str2+1
                lea di,str2+2
                output nl
                output con
                c1:
                        mov ax,[di]
                        mov [si],ax
                        inc si
                        inc di
                        dec cl
                jnz c1
                opstr str1
        ret
        concat endp

        compar proc far
                output nl
                mov cl,str1+1
                mov bl,str2+1

                lea si,str1+2
                lea di,str2+2

                cmp cl,bl
                je down
                jmp fin
             down:
                mov ax,[si]
                cmp ax,[di]
                jne fin
                inc si
                inc di
                dec cl
                jnz down
                jmp sfin
             fin:
                output nequ
                ret
             sfin:
                output equl
             ret
        compar endp

        spec proc far
                lea si,str1+2
                mov cl,str1+1
                main:
                        dec cl
                        jz finexit
                l0:
                        mov al,[si]
                        inc si
                        cmp al,31h
                        jl l2
                        cmp al,39h
                        jg l3
                        inc dig
                        jmp main
                l2:
                        inc sep
                        jmp main
                l3:
                        cmp al,41h
                        jl l2
                        cmp al,5Ah
                        jg l4
                        inc upr
                        jmp main
                l4:
                        cmp al,61h
                        jl l2
                        cmp al,7ah
                        jg l2
                        inc lwr
                        jmp main
               finexit:
                        output u
                        mov dl,upr
                        add dl,30h
                        mov ah,02h
                        int 21h

                        output l
                        mov dl,lwr
                        add dl,30h
                        mov ah,02h
                        int 21h

                        output s
                        mov dl,sep
                        add dl,30h
                        mov ah,02h
                        int 21h

                        output d
                        mov dl,dig
                        add dl,30h
                        mov ah,02h
                        int 21h
        ret
        spec endp

        substr1 proc far
                lea si,str1+2
                lea di,str2+2
                mov cl,str2+1
                mov ch,str1+1

                mn:
                        mov al,[si]
                        cmp al,[di]
                        jne dwn
                        inc si
                        inc di
                        dec ch
                        dec cl
                        jnz mn
                        jmp get
                dwn:
                        inc si
                        lea di,str2+2
                        mov cl,str2+1
                        dec ch
                        jnz mn
                        jmp notget
               get:
                        output su
                        ret
               notget:
                        output nsu
        ret
        substr1 endp
end                          
