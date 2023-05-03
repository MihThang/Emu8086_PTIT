                                            .Model Small
.Stack 100h
.Data     
    Msg1 Db 'Nhap so thu nhat: $'
    Msg2 Db 10,13,'Nhap so thu hai: $'
    Msg3 Db 10,13,'Tong 2 so tren la: $' 
    Chuso Dw ?
    So Dw ?
    Kitu db 30 dup('$')   
    Num Dw 0   
    
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
        
        
        Thongbao Msg1       ;Thong bao nhap so thu nhat
        Call Nhap       
        Mov Bx, So
        Mov Num, Bx
        
        Thongbao Msg2       ;Thong bao nhap so thu hai
        Call Nhap       
        Mov Bx, So
   
        
        Add Bx, Num         ;luu tong 2 so vao bx                          
        Mov So, Bx   
        
        Call kituxau         
                     
        
           
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
    
    
     kituxau Proc                                    
        ;chuyen Sum ve ki tu
        Lea Si, Kitu      ; Truyen dia chi Kitusum[0] vao si
        Mov Cx, 0            ; dem so luong ki tu den in
        Mov Ax, So          ; Truyen So vao AX de chia
        Mov Bx, 10            
        
        
        Lapxau:
            Cmp Ax, 0        ; Neu  Ax = 0 thi thoat
            Je Thoatxau   
            Mov Dx, 0        ; gan dx = 0 de dxax = ax
            Div Bx           ; DxAx/bx , du = dx, nguyen = ax
            Add Dx, '0'      ; Chuyen ve ki tu so
            Mov [si], Dl     ; '0' <= Dx <= '9' --> dx = dl
            Inc Si
            Inc Cx 
            Jmp Lapxau:
                                     
        Thoatxau: 
        Thongbao Msg3 ; thong bao in tong 
        ;in 
        MOV AH, 02H
        Lap3:      
            DEC SI
            MOV Dl, [SI]
            INT 21H
            LOOP lap3: 
        RET
    kituxau Endp
     
     
     
                                                   

end         