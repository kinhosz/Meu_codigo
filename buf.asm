org 0x7c00
jmp 0x0000:main

set_cursor:

	mov ah,02h
	mov bh,0
	mov dh,150
	mov dl,150
	int 10h
	ret

putchar:

	mov ah,0ah
	mov bl,4
	mov bh,0
	mov cx,1
	int 10h
	ret

getchar:

	mov ah,00h
	int 16h
	ret

_init:

	mov ah,4fh
	mov al,02h
	mov bx,10h
	int 10h
	ret
	
color:

	mov ah,0ch
	mov bh,0
	mov cx,0
	mov dx,0
	
	.for1:
		mov cx,0
		inc dx
		cmp dx,100
		je .fimfor1
		.for2:
			inc cx
			cmp cx,100
			je .for1
			push ax
			int 10h
			pop ax
			jmp .for2
	.fimfor1:
	ret


leitor:

	mov ah,01h 
	int 16h
	jz fim
	
	mov ah,00h
	int 16h
	

	fim:
	ret

main:

	xor ax,ax
	mov ds,ax
	mov es,ax
	
	call _init
	mov dx,0
	mov al,0
	loop1:
		push ax
		push dx
		;;;;;;;;;;;;;;;;
		call leitor
		
		;;;;;;;;;;;;;;;;
		pop dx
		pop ax
		inc dx
		cmp dx,1000
		jne loop1
		mov dx,0
		cmp al,16
		jne if
		mov al,0
		if:
		inc al
		push ax
		call color
		pop ax
		mov dx,0
	jmp loop1

end:
times 510-($-$$) db 0
dw 0xaa55