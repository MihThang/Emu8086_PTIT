.MODEL SMALL
.STACK 100h
.DATA
    DOWN DB 10,13,'$'
    MSG1 DB 'Nhap xau ki tu : $'
    MSG2 DB 'Doi xau ve ki tu thuong : $' 
    MSG3 DB 'Doi xau ve ki tu hoa : $' 
    XAU DB  80 DUP('$')   
          
    
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
    LEA SI, XAU     
    
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h
      
     
    ;Doi ki tu trong xau ve thuong
      
LAP:
    MOVSB                    
    ;thoat neu ki tu la null
    CMP BYTE PTR [SI-1], 0
    JE THOAT                   
    ; khong thay doi ki tu
    CMP BYTE PTR [SI-1], 'A'
    JB LAP                     
    CMP BYTE PTR [SI-1], 'Z'
    JA LAP                
    ;thay doi ki tu ve thuong
    ADD BYTE PTR [SI-1], 32
    JMP LAP
    

THOAT:     
      
    ;Thong bao in xau ki tu thuong
    MOV AH, 9h
    LEA DX, MSG2
    INT 21h       
    
    ;In xau thuong
    MOV AH, 9h 
    LEA DX, XAU  
    ADD DX, 2
    INT 21H 
    
    ;Xuong dong
    MOV AH, 9h
    LEA DX, DOWN
    INT 21h
    
    ;Doi ki tu trong xau ve hoa
    LEA SI, XAU
    ADD SI, 2   
LAP1:
    MOVSB                    
    ;thoat neu ki tu la null
    CMP BYTE PTR [SI-1], 0
    JE THOAT1                   
    ; khong thay doi ki tu
    CMP BYTE PTR [SI-1], 'a'
    JB LAP1                     
    CMP BYTE PTR [SI-1], 'z'
    JA LAP1                
    ;thay doi ki tu ve hoa
    SUB BYTE PTR [SI-1], 32
    JMP LAP1
    

THOAT1:     
      
    ;Thong bao in xau ki tu thuong
    MOV AH, 9h
    LEA DX, MSG3
    INT 21h       
    
    ;In xau thuong
    MOV AH, 9h 
    LEA DX, XAU  
    ADD DX, 2
    INT 21H  
    
    
    
    ;==========Thoat chuong trinh============
    MOV AH, 4Ch
    INT 21h
end
    
    
    
    
        