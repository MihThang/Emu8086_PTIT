                                                       .model small
.Stack 100h
.Data 
    down db 10,13,'$'
    msg1 db 'nhap so: $'
    msg2 db 'Co so hexa la: $'
    so dw 0    
    socu dw 0 
    xau db 80 dup('$') 
    
.Code

    MAIN Proc    
        ;lay du lieu tu data vao ds
        mov Ax, @Data
        mov Ds, Ax                 
        
        call nhapSo   
        call Hexa  
        call inxau 
    
    MAIN Endp
    
    
    nhapSo Proc
        ;thong bao nhap so
        Mov Ah, 9h
        Lea Dx, msg1
        Int 21h  
        
        ;khoi tao
        Mov Bx, 10
        
        ;nhap so den khi gap ki tu xuong dong
        lap:
            Mov Ah, 1h
            Int 21h 
            
            Cmp Al, 13 ; kiem tra ki tu co phai la xuong dong , neu co ket thuc nhap
            Je thoat                                                                
            
            Sub Al, '0' 
            Mov Ah, 0
            Mov so, Ax   ; gan so vua nhap vao so moi
            
            Mov Ax, socu    ; gan so cu vao ax de nhan
            Mul Bx          ; dxax = ax * 10 -> o day nhan so be len cac bit dx = 0 nen dxax = ax
            Add Ax, so       
            Mov socu , Ax   ; cap nhat so cu  
            Jmp lap
        thoat: 
          
        ;xuong dong
        Mov Ah, 9h
        Lea Dx, down
        Int 21h     
    nhapSo Endp     
                         
        
    Hexa proc    
        Mov Ax, socu, ; gan so vua nhap vao ax de dich phai
        Lea Si, xau   
        Mov Cx, 0 ; dung cho viec in xau
                         
        ;thuc hien dich va luu cac bit dich vao xau 
        lap1:  
                    
            Cmp ax, 0 ; thoat neu ax = 0;
            Je Thoat1
           
            Inc Si  
            Inc Cx
            Mov Bx,Ax ; Luu gia tri cu vao Bx
            Shr Ax,4    ; dich phai 4 bit == chia 16 
            Shl Ax,4    ; dich trai 4 bit == nhan 16 vd: (17/16=1)*16= 16
            Sub Bx, Ax  ; gan phan du vao bx;
            Shr Ax,4    ; dich phai lai 4 bit cho vong lap tiep theo     
            Add Bx, '0' ; doi so sang ki tu so
            
            Cmp Bx, '9'
            Jbe Next    ; neu Bx <='9' khi khong phai sua lai bx,nguoc lai doi ve chu     
            Add Bx, 7   ; chuyen ve chu neu lon hon 9     
            Next:
            Mov [si], Bx; luu ki tu vao xau
            Jmp lap1                             
        
        Thoat1:
        
    Hexa Endp  
    
    inxau Proc
        ;thong bao in xau
        Mov Ah, 9h
        Lea Dx, msg2
        Int 21h
       
        ;In xau nguoc
        Mov Ah, 2h   
    lap2:        
        Mov Dl, [si]
        Int 21h  
        Dec Si          
        Loop lap2
        
        Mov Dl, 'h'
        Int 21h                 
    inxau Endp
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
