.Model Small
.Stack 100H
.Data
    Msg db 'nhap so muon tin luu thua nho hon 9: $'
    Msg1 db 10,13,'Giai thua cua so tren la: $'
    Kituso db 30 dup('$')
    Num dw ?
    
    
.Code
    Main Proc
        ;di chuyen du lieu vao ds
        Mov Ax, @Data
        Mov Ds, Ax
           
        ;thong bao nhap du lieu
        Mov Ah, 09H
        Lea Dx, Msg
        Int 21H
        
        Mov Ah, 01H
        Int 21h
        Mov Ah, 0     ;al = ax  
        Sub Al, '0'   ;Do vua nhap ki tu so nen phai chuyen ve so
        Mov Num, Ax   ;luu so vua nhap vao num
        
        ;tinh giai thua
        Mov Cx, Num
        Mov Ax, 1
        
        Lap:
            Mul Cx           ;ket qua duoc luu vao DxAx nhung vi nho nen Dx=0-> dxax= ax
            Loop Lap
        Mov Num, Ax          ;luu giao thua vao num         
        
        
        
        ;chuyen so al ascii ve ki tu so  
        Lea Si, KituSo 
        Mov Bx, 10
        Mov Ax, Num  
        MOv Cx, 0     ;dem so ki tu so de dung cho viec in ra man hinh
        Lap1:
            Mov Dx, 0 ; tra dx ve 0 de ty nua luu phan du
            Cmp Ax, 0
            Je Thoat1 ;Thoat khi ax = 0 (khong con so nao
            
            Div Bx  ; lay dxax chia bx(vi dx = 0 nen la Ax.Bx)  , du dx, nguyen la ax
            Add Dx, '0'   ; du luu vao dx, chuyen dx ve ki tu so      
            Mov [Si], Dl  ; vi du tu 1-9 len Dh = 0 -> Dx = Dl
            Inc Si
            Inc Cx
            Jmp Lap1  
        
        Thoat1:
        
        ;Thong bao in gia thua
        Mov Ah, 09H
        Lea Dx, Msg1
        Int 21h
        
        ;in so  
        ;In so ki tu   
        MOV Ah, 02H
        Lap2:      
            Dec Si
            Mov Dl, [Si]
            Int 21H
            Loop lap2:  
        
        
        
    Main Endp   
    
   
    ;=============Thoat chuong trinh=================
    Mov Ah, 4CH
    INt 21H
end