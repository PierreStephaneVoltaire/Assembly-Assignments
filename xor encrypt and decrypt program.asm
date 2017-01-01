      include emu8086.inc
ORG 100h
mov ax,1000
mov ds,ax
call pthis
db "encrypt. ",0
putc 0dh
putc 0ah
begin:
mov ax,7000h
mov ds,ax
mov di,0000
call pthis       


db "Enter a number; ",0
mov dx,10 ; size of the string
call GET_STRING
mov cx,dx
putc 0dh
putc 0ah  

 


 StringProcess: mov bl,[di]
  cmp bl,00h
       jne x     
  cmp bl, 00h
       
  Loop StringProcess 
      
      putc 0dh
putc 0ah 
mov di ,0000
     call pthis
db "decrypt: ",0
 

 
  StringThing: mov bl,[di]
  cmp bl,00h
       jne y     
  cmp bl, 00h
    je stop   
  Loop StringThing 
  

    
  stop:
  hlt
  
  
  x: xor bl,key 
     call print_prc 
     mov [DI],bl
     add DI,1
     cmp Dx, 0
     jnz StringProcess
 
     y: xor bl,key 
     call print_prc 
     mov [DI],bl
     add DI,1
     cmp Dx, 0
     jnz StringThing


ret  
  


print_prc PROC
call pthis
db "", 0
putc bl
RET

key EQU 37
print_prc ENDP
DEFINE_PTHIS
DEFINE_GET_STRING
end       