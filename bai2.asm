.MODEL SMALL
.STACK 100h
.DATA
    DOWN DB 10,13,'$'
    MSG1 DB 'Nhap 1 ki tu : $'
    MSG2 DB 'Ki tu vua nhap la : $'  
    KITU DB ?
.CODE
    ;Lay du lieu tu DATA vào DS
    MOV AX, @DATA
    MOV DS, AX
    
    ;Thong bao yeu cau nhap 1 ki tu
    MOV AH, 9h
    LEA DX, MSG1
    INT 21h     
    
    ;Nhap 1 ki tu tu ban phim
    MOV AH, 1h
    INT 21h            
    MOV KITU, AL
    
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h
    
    ;Xuat thong bao in ki tu :     
    MOV AH, 9h
    LEA DX, MSG2
    INT 21h     
    
    ;In ki tu vua nhap;
    MOV AH, 2h
    MOV DL, KITU
    INT 21h            
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
    