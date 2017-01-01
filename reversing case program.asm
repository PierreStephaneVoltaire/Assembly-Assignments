include emu8086.inc
ORG 100h
mov ax,1000
mov ds,ax
call pthis
db "inputs letters   ",0
putc 0dh
putc 0ah
begin:
mov ax,7000h
mov ds,ax
mov di,0000
call pthis
db "Enter a letter; Enter to end: ",0
mov dx,10 ; size of the string
call GET_STRING
mov cx,dx         
  

StringChecker: mov bl,[di] 
 
cmp bl, 00
jle String  

add si ,1   
add di  , 1 

cmp bl, 00  
jne thing 



String:
sub si, 1
putc 0dh
putc 0ah
  


StringProcess: mov bl,[si]
cmp bl,00h
jle stop  
cmp bl,1fh
  jl Not_A_Letter
  cmp bl,20h
  je space 
         
         
 cmp bl, 30h
 jl Not_A_letter
 cmp bl, 39h
 jle  is_a_number    
  cmp bl,5fh
  je underscore        
         
         
         
         
      
cmp bl,41h	; D-1
jl Not_A_Letter
cmp bl,5Ah	;D-2 

jle convert_to_lower
cmp bl,61h	;D-3
jl Not_A_Letter
cmp bl,7ah	;D-4
jle convert_to_upper
Loop StringProcess 

  
  
space:
putc 20h
sub SI, 1
cmp dx, 0
jnz StringProcess  
  
 
 underscore: 
 putc 5fh
sub SI, 1
cmp dx, 0
jnz StringProcess  
 
 
Not_A_Letter:
putc 0dh
putc 0ah
putc 0dh
putc 0ah
sub SI, 1
cmp Dx, 0
jnz StringProcess 


thing:

 cmp Dx, 0
jnz StringChecker
             
             
             

convert_to_lower: add bl,20h
putc bl
sub si, 1
cmp Dx, 0
jnz StringProcess

  
  is_a_number: 
  
  putc bl
 sub si, 1
  cmp Dx,0
  jnz StringProcess


convert_to_upper: sub bl,20h
putc bl
sub si, 1
cmp Dx, 0
jnz StringProcess
stop:
call pthis
db " Goodbye: ", 0
putc 0dh
putc 0ah
ret 


DEFINE_PTHIS
DEFINE_GET_STRING
end