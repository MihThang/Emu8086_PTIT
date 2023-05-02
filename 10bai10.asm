.Model Small   
.Stack 100H
.Data                    
    DOWN db 10,13,'$' 
    MSG db 'Nhap xau ki tu: ', 10, 13,'$'   
    MSG1 db 'So ki tu cua xau vua nhap la : $'
    Xau db 80 dup('$')      
    KituSo db 10 dup('$')
    So db ?
      
    
.Code
    Main Proc
        Mov Ax, @data
        Mov Ds, Ax   
        
        ;Thong bao nhap xau
        MOV AH, 09H
        LEA DX, MSG    
        INT 21H
        
        ;Nhap xau ki tu  
        LEA SI, Xau
        MOV AH, 01h 
        MOV BL, 0   
        Lap:
            INT 21h
            CMP Al, 13
            JE Thoat
            MOV So, BL
            INC SI  
            INC Bl
            JMP Lap
             
        Thoat: 
        MOV So,Bl

        ;Xuong dong
        MOV AH, 09H
        LEA DX,DOWN
        INT 21H                    
        
        ;chuyen so al ascii ve ki tu so  
        LEA SI, KituSo 
        MOV Bl, 10  
        MOV Al, So 
        MOV CX,0
        
        Lap1:       
            MOV AH, 0
            CMP Al,0
            JE Thoat1:
            DIV Bl        ;lay ax/10(vi ah = 0 -> ax = al)phan nguyen luu vao al, du luu vao ah
            ADD AH, '0'
            MOV [SI], AH   
            INC SI 
            INC CX
            JMP Lap1                    
        
        Thoat1: 
        ;Thong bao in so ki tu xau
        MOV AH, 09H
        LEA DX, MSG1    
        INT 21H       
        
        ;In so ki tu   
        MOV AH, 02H
        Lap2:      
            DEC SI
            MOV Dl, [SI]
            INT 21H
            LOOP lap2:
   
        
    Main Endp
    ;===============Thoat Chuong Trinh=================
    Mov Ah, 4Ch
    Int 21h
end
