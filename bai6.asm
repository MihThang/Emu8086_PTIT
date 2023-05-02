.MODEL SMALL
.STACK 100h
.DATA                          
    DOWN DB 10,13,'$'
    MSG1 DB 'Nhap xau ki tu: $'   
    MSG2 DB 'Xau ki tu nguoc la: $'       
    XAU DB 100 DUP('$')  
  
.CODE   
    ;Lay du lieu tu DATA vào DS
    MOV AX, @DATA
    MOV DS, AX  
    
    ;Thong bao nhap xau ki tu;
    MOV AH, 9h
    LEA DX, MSG1
    INT 21h 
    
    ;Nhap xau ki tu den khi gap ki tu # 
    ;Chuan bi
    MOV CX, 0     
    LEA SI, XAU
    MOV AH, 1H
    ;Nhap
LAP:
    INT 21h
    MOV [SI], AL
    INC SI
    INC CX
    CMP AL, '#'   
    JE THOAT
    JMP LAP 
          
THOAT:  
    ;Giam SI di 1 do cong thua 1 trong vong lap de khong in ki tu #
    DEC SI
      
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h  
    
    ;Thong bao in xau ki tu thuong
    MOV AH, 9h
    LEA DX, MSG2
    INT 21h       
    
    ;In xau nguoc
    MOV AH, 2h   
    SUB CX, 1
LAP2:        
    DEC SI
    MOV DL, [SI]  
    INT 21H            
    LOOP LAP2
    
     ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end