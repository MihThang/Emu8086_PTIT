.model small
.stack 100h
.data 
    down db 10,13,'$'
    msg1 db 'nhap so: $'
    msg2 db 'Co so 2 la: $'
    so dw 0    
    socu dw 0 
    xau db 80 dup('$') 
    
.code

    MAIN Proc    
        ;lay du lieu tu data vao ds
        mov ax, @data
        mov ds, ax                 
        
        call nhapSo   
        call nhiPhan 
        call inxau
    
    MAIN Endp
    
    
    nhapSo Proc
        ;thong bao nhap so
        mov ah, 9h
        lea dx, msg1
        int 21h  
        
        ;khoi tao
        mov bx, 10
        
        ;nhap so den khi gap ki tu xuong dong
        lap:
            mov ah, 1h
            int 21h 
            
            cmp al, 13 ; kiem tra ki tu co phai la xuong dong , neu co ket thuc nhap
            je thoat                                                                
            
            sub al, '0' 
            mov ah, 0
            mov so, ax   ; gan so vua nhap vao so moi
            
            mov ax, socu    ; gan so cu vao ax de nhan
            mul bx          ; dxax = ax * 10 -> o day nhan so be len cac bit dx = 0 nen dxax = ax
            add ax, so       
            mov socu , ax   ; cap nhat so cu  
            jmp lap
        thoat: 
          
        ;xuong dong
        mov ah, 9h
        lea dx, down
        int 21h     
    nhapSo Endp     
                         
        
    nhiPhan Proc             
        mov ax, socu  ; gan ax = socu de dich phai  
        lea si, xau   
        mov cx, 0
                                     
        ;thuc hien dich va luu cac bit dich vao xau 
        lap1:  
                    
            cmp ax, 0 ; thoat neu ax = 0;
            je thoat1
           
            inc si
            inc cx 
            mov [si], '1'
            shr ax,1
            jc lap1
            mov [si], '0'
            jmp lap1                             
        
        thoat1:        
    nhiPhan Endp     
                   
                   
    inxau Proc
        ;thong bao in xau
        mov ah, 9h
        lea dx, msg2
        int 21h
       
        ;In xau nguoc
        mov ah, 2h   
    lap2:        
        mov dl, [si]
        int 21h  
        dec si          
        loop lap2                 
    inxau Endp 
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
