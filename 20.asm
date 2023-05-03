.Model Small
.Stack 100H
.Data             
    Msg1 Db 'Nhap xau.a: $'
    Msg2 Db 10,13,'Nhap xau.b: $'  
    Msg3 Db 10,13,'So luong xau.b co trong xau.a la: $' 
    xau1 Db 1000 dup ('$') 
    xau2 Db 1000 dup ('$') 
    kitu Db 30 dup ('$')    
    So dw ?


.Code    
    Nhapxau Macro xau
        Mov Ah, 0AH
        Lea Dx, xau
        Int 21H  
    Endm
    
    Thongbao Macro msg
        Mov Ah, 09H
        Lea Dx, msg
        Int 21H
     Endm

    Main Proc
        ;di chuyen du lieu vao ds
        Mov Ax, @Data 
        Mov Ds, Ax
        
        Thongbao Msg1
        Nhapxau xau1 
        
        Thongbao Msg2
        Nhapxau xau2  
        
        Lea Si, xau1       ;gan chuyen dia chi xau vao si de so sanh
        Add Si, 1 
        Mov Cx, 0  
        
        Lap:   
            Lea Di, xau2
            Add Di, 2
            Inc Si      
            
            
            ;neu [si] = Null dung lap           
            Cmp [Si], 0 
            Je Dunglap 
            Cmp [Si], 13
            Je Dunglap            
            
            Lap1:   
               
                Mov Al, [Di]                
                Cmp [Si], Al
                Jne Lap            ;neu [si] != [Di] kiem thi kiem ra lai tu dau di voi si tiep  theo
                
                Cmp [Di+1], 13      ;neu [di+1] == enter tuc la xau2 la con xau1, dat trang thai check la 1
                Je Next:           ;neu [di+1] != enter tiep tuc kiem tra [si+1] vs [di+1]
                InC Si
                Inc Di    
                Jmp Lap1     
                Next: 
                    Inc Cx 
                    Jmp Lap
            
        Dunglap:      
        
        Mov So,cx 
        Thongbao Msg3
        Call Kituxau
        

    ;===============Dung Chuong Trinh=================
    Mov Ah, 4Ch
    Int 21H  
    
    Main Endp    
    
    
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