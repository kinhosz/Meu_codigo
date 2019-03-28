org 0x8600
jmp 0x0000:main

data:
score db ' SCORE ',13
pontos db ' 00000 ',13
bilau db '            ',13

prints:

	.loop:
		lodsb
		cmp al,13
		je .fimloop
		call set_cursor
		call putchar
		inc dl
		jmp .loop
	
	.fimloop:
	ret

set_cursor:

	mov ah,02h
	mov bh,0
	int 10h
	ret

putchar:

	mov ah,0ah
	mov bl,4
	mov bh,0
	mov cx,1
	int 10h
	ret
	
_init:

	mov ah,4fh
	mov al,02h
	mov bx,10h
	int 10h
	ret

draw_pixel:

	mov ah,0ch
	mov bh,0
	int 10h
	ret
	
draw_background:

	mov cx,0
	mov dx,0
	dec dx
	
	;; printa o plano de fundo
	.for1:
		mov cx,0
		dec cx
		inc dx
		cmp dx,350
		je .fimfor1
		.for2:
			inc cx
			cmp cx,640
			je .for1
			mov al,9
			call draw_pixel
			jmp .for2
	.fimfor1:
	; para printar o campo de jogo no centro
	; coluna 110 ~ 510
	; linha 5 ~ 345
	mov dx,5
	.for3:
		mov cx,110
		inc dx
		cmp dx,345
		je .fimfor3
			.for4:
			inc cx
			cmp cx,511
			je .for3
			mov al,0
			call draw_pixel
			jmp .for4
	.fimfor3:
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov dh,1 ;posicao inicial do cursor
	mov dl,3
	mov si,score
	call prints
	call print_pontos

	mov dh,2
	.for5:
		inc dh
		cmp dh,9
		je .fimfor5
		mov dl,66
		mov si,bilau
		call prints
		jmp .for5
	.fimfor5:
	
	ret
	
print_pontos:

	mov dh,3
	mov dl,3
	mov si,pontos
	call prints
	ret
	
main:

	xor ax,ax
	mov ds,ax
	mov es,ax
	
	call _init
	call draw_background


end:
times 510-($-$$) db 0
dw 0xaa55
