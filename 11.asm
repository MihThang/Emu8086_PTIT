.Model Small
.Stack 100h
.Data     
    Msg1 Db 'Nhap so luong so can tim min max: $'
    Msg2 Db 10,13,'Nhap cac so can so sanh: $'
    Msg3 Db 10,13,'Min la: $'         
    Msg4 Db 10,13,'Max la: $'
    Min Dw ?
    Max Dw ?
    Chuso Dw ?
    So Dw ?
    Kitu db 30 dup('$')
    
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
        
        
        Thongbao Msg1       ;Thong bao nhap so luong so can tinh tong
        Call Nhap
        Mov Cx, So        ; luu so luong so vao cx de lap nhap   
              
        Thongbao Msg2     ;thong bao nhap cac so      
              
        Call Nhap         ;khoi tao min max la so dau tien
        Mov Bx, So 
        Mov Min, Bx
        Mov Max, Bx
        Dec Cx
        
        Lap1:
            Call Nhap     ;thuc hien nhap va tinh tong
            Mov Bx, So
            Cmp Bx, Max
            Jbe Next1:
            Mov Max, Bx   
            Next1:
            Cmp Bx, Min
            Jae Next2:
            Mov Min, Bx
            Next2: 
            Loop Lap1   
         
       Mov Bx, Min 
       Mov so, Bx
       Call kituso
       Thongbao Msg3    ;thong bao in min
       Call Inso
       
       Mov Bx, Max
       Mov so, Bx
       Call kituso
       Thongbao Msg4    ;thong bao in max
       Call Inso
        
          
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
    
    
    
    kituso Proc                                  
        
        ;chuyen Sum ve ki tu
        Lea Si, Kitu      ; Truyen dia chi Kitusum[0] vao si
        Mov Cx, 0            ; dem so luong ki tu den in
        Mov Ax, So          ; Truyen Sum vao AX de chia
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
                                                            
        RET   
    kituso Endp   
    
    Inso Proc
        ;in tong 
        MOV AH, 02H
        Lap3:      
            DEC SI
            MOV Dl, [SI]
            INT 21H
            LOOP lap3:    
        RET
    Inso Endp
           


end         