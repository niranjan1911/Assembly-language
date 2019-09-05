.model small
.stack 64h
.data
        first dw 215
        second dw 125
        res dw ?
.code
        mov ax,@data
        mov ds,ax

        mov ax,first
        add ax,second
        mov res,ax

        mov ah,4ch
        int 21h

       

end
