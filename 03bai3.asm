.MODEL SMALL
.STACK 100h
.DATA
    DOWN DB 10,13,'$'
    MSG1 DB 'Nhap xau ki tu : $'
    MSG2 DB 'Xau ki tu vua nhap la : $'  
    XAU DB 80, ?, 80 DUP('$')   
    
    
.CODE   
    ;Lay du lieu tu DATA vào DS
    MOV AX, @DATA
    MOV DS, AX;  
    
    ;Thong bao nhap xau ki tu;
    MOV AH, 9h
    LEA DX, MSG1
    INT 21h 
    
    ;Nhap xau ki tu 
    MOV AH, 0Ah    
    LEA DX, XAU
    INT 21h        
    
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h
    
    ;Thong bao in xau ki tu
    MOV AH, 9h
    LEA DX, MSG2
    INT 21h       
    
    ;In chuoi
    MOV AH, 9h 
    LEA DX, XAU  
    ADD DX, 2
    INT 21H    
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
    
    
    
    
        
