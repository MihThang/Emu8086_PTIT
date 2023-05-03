                             .Model Small
.Stack 100h
.Data     
    Msg2 Db 'Nhap 10 so co 2 chu so: $'
    Msg3 Db 10,13,'Tong cac so chia het cho 7 la: $'
    Sum Dw 0
    Chuso Dw ?
    So Dw ?
    Kitusum db 30 dup('$')
    
.Code   
    Thongbao Macro msg
        Mov Ah, 9H
        Lea Dx, msg
        Int 21H
    Endm
        
        
    MAIN Proc     
        ;di chuyen di luu vao ds
        Mov Ax, @Data
        Mov Ds, Ax 
         
        Thongbao Msg2     ;thong bao nhap cac so
        Mov Cx, 10   
                
        Lap1:
            Call Nhap     ;thuc hien nhap va tinh tong neu chia het cho 7  
            Mov Bx, 7    
            Mov Dx, 0     ;DxAx = Ax
            Mov Ax, So  
            Div Bx        ;DxAx/Bx  ; du Dx, nguyen Ax
            Cmp Dx, 0
            Jne Next
            Mov Ax, So
            Add Sum, Ax  
            Next:
                Loop Lap1
                      
        Call Insum
           
    ;============Thoat Chuong Trinh================
    Mov Ah, 4Ch
    Int 21h     
        
    MAIN Endp    
       
       
           
    Nhap Proc       
        Mov Bx, 10
        Mov So, 0
        Mov Chuso, 0
        
        Lapnhap:
            Mov Ah, 01H
            Int 21h
            
            ; kiem tra nhap xong chua, nhap khong neu gap spa hoac enter
            Cmp Al, 13
            Je Thoatnhap
            Cmp Al, 32
            Je Thoatnhap
              
            ;thuc hieu luu so :so = So* 10 + Chuso
            Sub Al , '0'     ;  chuyen so ve dang ascii
            Mov Ah, 0        ; Al = AX
            Mov ChuSo, Ax    ; luu so vua nhap
            Mov Ax, So       ; luu so cu vao ax de nhan Bx(10)      
            Mul Bx           ; DxAx = Ax * 10, Ax va Bx be nen Dx = 0; -> DxAx = Ax
            Add Ax, Chuso
            Mov So, Ax       ; luu so vua tinh xong
            Jmp Lapnhap
            
        Thoatnhap:
        RET              
    Nhap Endp
    
    
    
    Insum Proc                                  
        
        ;chuyen Sum ve ki tu
        Lea Si, Kitusum      ; Truyen dia chi Kitusum[0] vao si
        Mov Cx, 0            ; dem so luong ki tu den in
        Mov Ax, Sum          ; Truyen Sum vao AX de chia
        Mov Bx, 10            
        
        
        Lap2:
            Cmp Ax, 0        ; Neu  Ax = 0 thi thoat
            Je Thoatlap2   
            Mov Dx, 0        ; gan dx = 0 de dxax = ax
            Div Bx           ; DxAx/bx , du = dx, nguyen = ax
            Add Dx, '0'      ; Chuyen ve ki tu so
            Mov [si], Dl     ; '0' <= Dx <= '9' --> dx = dl
            Inc Si
            Inc Cx 
            Jmp Lap2:
                                     
        Thoatlap2:
        
        Thongbao Msg3        ; Thong bao in tong     
        
        ;in tong 
        MOV AH, 02H
        Lap3:      
            DEC SI
            MOV Dl, [SI]
            INT 21H
            LOOP lap3:
        
        RET   
    Insum Endp    
           


end         