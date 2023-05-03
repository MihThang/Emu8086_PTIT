.Model Small
.Stack 100H
.Data
    Msg1 db 'Nhap chuoi: $'  
    Msg2 db 10,13,'So xau con ktmt la: $'
    xau db 200 dup('$')
    so dw ? 
    Kitu db 100 dup('$')
    
.Code   
    Thongbao macro msg
        Mov Ah, 09H
        Lea Dx, msg
        Int 21H
    Endm

    Main Proc
        ;di chuyen du lieu vao ds
        Mov Ax, @Data
        Mov Ds, Ax
        
      
        Thongbao Msg1    ;thong bao nhap xau
        
        ;nhap xau
        Mov Ah, 0AH
        Lea Dx, Xau
        Int 21H
        
        Call Demxau     ; dem so xau 'ktmt'
      
        Call kituso     ; do so ve ki tu so va in ra man hinh
        
        
    
        
    ;============Dung Chuong Trinh=============
    Mov Ah, 4CH
    Int 21H
    
    Main Endp  
    
    
    demxau Proc        
        ;khoi tao
        Mov Cx, 0
        Lea Si, Xau
        Add Si, 1  ;do su dung ah = 0ah nen 2 ki tu dau la ki tu ra  
        
        Lapxau:             
            ;Dung lap neu la ki tu null
            Inc si     
            Cmp [Si], 13
            Je Thoatlapxau  
            Cmp [Si], 0
            Je Thoatlapxau
            
            Cmp [Si], 'k'
            Jne Lapxau      ;neu khac 'k' thi lap, neu dung kiem tra tiep ki tu tiep theo
            Inc Si                                                    
            Cmp [Si], 't' 
            Jne Lapxau      ;neu khac 't' thi lap, neu dung kiem tra tiep ki tu tiep theo
            Inc Si 
            Cmp [Si], 'm'
            Jne Lapxau      ;neu khac 'm' thi lap, neu dung kiem tra tiep ki tu tiep theo
            Inc Si  
            Cmp [Si], 't'   ;neu khac 't' thi lap, neu dung cong bien dem them 1; 
            Jne Lapxau
            Inc Cx
            Jmp Lapxau
            
        Thoatlapxau:     
        Mov so, cx   
        
        RET
    demxau Endp     
    
    
     kituso Proc                                    
        ;chuyen Sum ve ki tu
        Lea Si, Kitu      ; Truyen dia chi Kitusum[0] vao si
        Mov Cx, 0            ; dem so luong ki tu den in
        Mov Ax, So          ; Truyen So vao AX de chia
        Mov Bx, 10            
        
        
        Lapso:
            Cmp Ax, 0        ; Neu  Ax = 0 thi thoat
            Je Thoatso   
            Mov Dx, 0        ; gan dx = 0 de dxax = ax
            Div Bx           ; DxAx/bx , du = dx, nguyen = ax
            Add Dx, '0'      ; Chuyen ve ki tu so
            Mov [si], Dl     ; '0' <= Dx <= '9' --> dx = dl
            Inc Si
            Inc Cx 
            Jmp Lapso:
                                     
        Thoatso: 
        Thongbao Msg2 ; thong bao so ki tu 'ktmt' 
        ;in 
        MOV AH, 02H
        Lap3:      
            DEC SI
            MOV Dl, [SI]
            INT 21H
            LOOP lap3: 
        RET
    kituso Endp
       
end