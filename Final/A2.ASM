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
     msg1 db 10,13,'-------MENU--------$'
     msg2 db 10,13,'1.HEX to BCD',10,13,'2.BCD to HEX',10,13,'3.Exit$'
     msg3 db 10,13,'-------------------$'
     msg4 db 10,13,'Enter your choice:$'
     msg5 db 10,13,'BCD :$'
     msg6 db 10,13,'HEX :$'
     msg7 db 10,13,'Exiting...$'
     msg8 db 10,13,'Enter 4 digit HEX Number (1-9, A-Z, a-z):$'
     msg9 db 10,13,'Enter 5 digit BCD Number:$'
     msg11 db 10,13,'Array elements are:$'

     cnt db 0
     a db 10 dup(0)
     arr dw 10000,1000,100,10,1
     res dw 0h
.code
     mov ax,@data
     mov ds,ax

     up:
         outputstr msg1
         outputstr msg2
         outputstr msg3
         outputstr msg4

         input
         cmp al,31h
         jg c1
		 jb up
         call HtoB
         jmp up

         c1:
            cmp al,32h
            jg c2
            call BtoH
         jmp up

         c2:
            outputstr msg7
            mov ah,4ch
            int 21h

     proc BtoH near
            outputstr msg9
            mov res,0000h
            mov ch,05h
            lea di,a
            lea si,arr
            ip:
                input
                sub al,30h
                mov ah,00h
                mov [di],al
                
                inc di
                mov dx,[si]
                mul dx
                add ax,res
                mov res,ax
                inc si
                inc si
                dec ch
            jnz ip
           
            lea di,a
            mov ch,05h
            outputstr msg11
            op:
               mov dl,[di]
               add dl,30h
               output
               mov dl,20h
               output
               inc di
               dec ch
            jnz op

            outputstr msg6
            mov cx,0404h
            mov ax,res
            mov bx,ax
            rot:
                rol bx,cl
                mov dl,bl
                and dl,0fh
                cmp dl,09h
                jbe rot2
                add dl,07h
           rot2:
                add dl,30h
                output
                dec ch
           jnz rot
           mov res,0000h
     ret
     endp BtoH

     proc HtoB near
            outputstr msg8
            mov cx,0404h
            mov bx,0000h
            main:
                input
                cmp al,30h
                jb main

                cmp al,39h
                jg up1

                sub al,30h
                jmp down
            up1:
                cmp al,41h
                jb main

                cmp al,46h
                jg up2

                sub al,37h
                jmp down
            up2:
                cmp al,61h
                jb main

                cmp al,66h
                jg main

                sub al,57h
                jmp down
            down:
                mov ah,00h
                rol bx,cl
                add bx,ax
                dec ch
            jnz main

            mov ax,bx
            mov bx,000Ah  ;Divide by 10
            mov cx,0404h
            mov dx,0000h

            logicH:
                div bx
                push dx
                inc cnt
                mov dx,0000h
                cmp ax,0000h
            jne logicH

            outputstr msg5
            mov cx,0404h
            mov dx,0000h
            down2:
                pop ax
                rol dx,cl
                add dl,al
                dec ch
            jnz down2

            mov cl,04h
            mov ch,cnt
            mov bx,dx
            mov dx,0000h
            loop@:
                rol bx,cl
                mov dl,bl
                and dl,0fh
                cmp dl,09h
                jb loop2
                add dl,07h
           loop2:
                add dl,30h 
                output
                dec ch
                jnz loop@
      ret
      endp HtoB
end
