.Model small
.Stack 100h
.Data 
    msg1 db 'nhap so nhi phan khong qua 8 Bit: $'
    msg2 db 10,13,'So hexa la: $'     
    msg3 db 10,13,'so khong hop le, hay nhap so nhi phan moi: '
    so dw 0    
    socu dw 0 
    xau db 80 dup('$')    
    
    
.Code

    MAIN Proc    
        ;lay du lieu tu data vao ds
        Mov Ax, @Data
        Mov Ds, Ax                 
        
        call Nhap 
        call Hexa    
                
        Mov Ah, 02h
        Mov Dl, 'h'
        Int 21H 
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h    
    MAIN Endp
    
    Nhap Proc       ;nhap du lieu dau vao
        ;Thong bao nhap du lieu;
        Mov Ah, 09h
        Lea Dx, msg1
        Int 21H
        
        nhaplai:
        Mov Cx, 8   
        Mov Ah, 01h   
        Mov Bh, 1000_0000b
        Mov Bl, 0
        Lap:       
            Int 21H
            Cmp Al ,'#'
            Je Dungnhap   ;neu bang # dung thuc nhap 
            Cmp Al, '0'
            Je Dich     ;neu khac khong kiem tra xem co bang 1 khong, neu bang khong thi bl khong thay doi
            Cmp Al, '1'
            Jne ketthuc     ;neu khac 1, khac 0 thi dung chuong trinh
            Or Bl, Bh       ;bang 1 thi them 1 vao , vd bl dang la 0100_0000 bh 0010_0000 -> bl 0110_0000
            
            
        Dich:
            Shr Bh, 1       ;vi du dang la 0100_0000 thi se la 0010_0000  de nhap bit tiep theo
            Loop Lap
            Jmp Dungnhap
            
        ketthuc:
            ;thong bao nhap lai so khac    
            Mov Ah, 09h
            Lea Dx, msg3
            Int 21H   
            Jmp nhaplai             ; nhap lai so khac
            
        Dungnhap: 
        Cmp Cx, 0
        Je Dung 
        Lap1:
            Shr Bl,1    
            Loop Lap1
        Dung:
        RET
    Nhap Endp  
     
     
    Hexa Proc             ; chuyen sang so hexa
        ;Thong bao in lieu;
        Mov Ah, 09h
        Lea Dx, msg2
        Int 21H 
        
        Mov Bh, Bl    ; Luu Bl vao Bh   
        And Bh, 1111_0000b  ;lay 4 bit dau   
        Shr Bh, 4
         
           
        Add Bh, '0'
        Cmp Bh, '9'   ;chuyen ve so
        Jbe boqua
        Add Bh, 7     ; chuyen ve chu
        
        boqua:
        And Bl, 0000_1111b  ;lay 4 bit cuoi       
        
        Add Bl, '0'
        Cmp Bl, '9'   ;chuyen ve so
        Jbe boqua1
        Add Bl, 7     ; chuyen ve chu     
       
        boqua1:
         
        ;in du lieu
        Mov Ah, 2h
        Mov Dl, Bh
        Int 21h
        Mov Dl, Bl
        Int 21h
        
        RET
    Hexa Endp
       
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
