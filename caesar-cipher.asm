
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

include 'emu8086.inc'
org 100h

mov dx, offset msg3
mov ah, 09
int 21h

printn ""
printn ""

mov dx,offset msg1
mov ah, 09
int 21h


lea dx, secret
mov ah, 0ah
int 21h

printn ""

mov dx,offset msg2
mov ah, 09
int 21h

mov ah, 01h ; here i take the shift value from the keyboard  (it gets saved into AL!!!!)
int 21h
sub al, '0' ; convert ASCII to numeric value
mov bl, al  ; save the shift value in BL
                                    
lea si, secret + 2 ; (i added 2 because i need SI to point from the actual input buffer)
lea di, encrypted

encryption:
    mov al, [si]
    cmp al, 0Dh ; here i verify if i reach the end of the string (0Dh = 13 which is carriage return in ASCII)
    je done
    
    cmp al, 'A' ; i verify if current character is not a letter
    jl number
    cmp al, 'Z' ; i verify if cyrrent character is a letter (uppercase)
    jbe uppercase
    
    cmp al, 'a' ; i verify if current character is not a letter
    jl number  
    cmp al, 'z' ; i verify if current character is a letter (lowercase>
    jbe lowercase 
    
    
number:
    mov [di], al
    jmp continue
    
uppercase:
    sub al, 'A' ; bring the value of the character in the 0-25 range
    add al, bl ; apply the shift that was saved in BL
    cmp al, 26
    jl dont_wrap_up  ; if this is < 26, it means that it doesnot have to wrap around (start from 0)
    sub al, 26
dont_wrap_up:
    add al, 'A'   ; back to ASCII
    mov [di], al
    jmp continue
    
lowercase:
    sub al, 'a'
    add al, bl
    cmp al, 26
    jl dont_wrap_low
    sub al, 26
dont_wrap_low:
    add al, 'a'
    mov [di], al
    jmp continue

continue:
    inc si ; go to the next character in secret
    inc di ; go to the next character in the encrypted message
    jmp encryption            

done:
    printn ""
    mov dx, offset msg4
    mov ah, 09
    int 21h
    mov [di], '$'
    lea dx, encrypted
    mov ah, 09h
    int 21h
    ret                                         


DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS

msg1 db "Enter what do you want to encrypt : $"
msg2 db "Shift (0-25): $" 
secret db 64 dup('$')
encrypted db 64 dup('$')
msg3 db "              CAESAR CIPHER $"
msg4 db "Encrypted message: $"