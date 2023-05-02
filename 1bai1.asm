.model small
.stack 100h

.data
     ta DB 'Hello world !', 0Dh, 0Ah ,'$'
     tv DB 'Chao the gioi !$'
.code
    main proc  
        
        ;lay dia chi bat dau cua data
        MOV AX, @DATA
        MOV DS, AX
        
        ;loi chao bang tieng anh
        MOV DX, OFFSET ta
        MOV AH, 09h
        INT 21h
        
        ;loi chao bang tieng viet
        MOV DX, OFFSET tv
        MOV AH, 09h           
        INT 21h               
        
        ;ket thuc chuong trinh
        mov ah, 4ch
        int 21h
main endp

end main
