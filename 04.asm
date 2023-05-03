.MODEL SMALL
.STACK 100h
.DATA
    DOWN DB 10,13,'$'
    MSG1 DB 'Nhap 1 ki thuong : $'
    MSG2 DB 'Ki tu viet hoa chinh la: $'
    KITU DB ?

.CODE
    ;Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    ;Thong bao nhap 1 ki tu
    MOV AH, 9h
    LEA DX, MSG1
    INT 21h
    
    ;Nhap ki tu
    MOV AH, 1h
    INT 21h
    MOV KITU, AL
    
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h
    
    ;Thong bao in ki tu hoa
    MOV AH, 9h
    LEA DX, MSG2
    INT 21h
    
    ;In ki tu hoa;
    MOV AH, 2H
    MOV DL, KITU
    SUB DL, 32
    INT 21H
    
    ;============THOAT CHUONG TRINH===========
    MOV AH, 4Ch
    INT 21h
    
end