;PROYECTO EFRA

;----------- PANTALLA ----------
COLOREAR MACRO COLOR, INI, FIN
    MOV AH,06H
    MOV AL,0
    MOV BH,COLOR
    MOV CX,INI
    MOV DX,FIN
    INT 10H
    
COLOREAR ENDM   

;--------------CURSOR---------------------

POSICION MACRO FIL,COL, PAG 
    
    MOV AH, 02H
    MOV BH, PAG
    MOV DH, FIL
    MOV DL, COL
    INT 10H

POSICION ENDM
;______________CADENA______________________
 
 IMPRIMIR  MACRO CADENA
        
     MOV AH, 09H
     MOV DX, OFFSET CADENA
     INT 21H
 
IMPRIMIR ENDM 
;_____________________________________ 

DATOS SEGMENT
  
   MENU1 DB 'MENU OPCIONES$' 
   OP1 DB '[1]OPERACIONES ARITMETICAS$'
   OP2 DB '[2]MAYOR DE DOS NUMEROS$'
   SALIR DB '*PARA SALIR EL NUMERO MAYOR*$'
   MSJE1 DB 03,' EL NUMERO 1 ES MAYOR ',03,'$'
   MSJE2 DB ' EL NUMERO 1 ES MENOR$'
   IGUAL DB 33,' ES IGUAL LOS DOS NUMEROS',33,'$'
   
   CADENA1 DB 'OPERACIONES BASICAS$'
   CADENA2 DB '[1]SUMA$'
   CADENA3 DB '[2]RESTA$' 
   CADENA4 DB '[3]MULTIPLICACION$'
   CADENA5 DB '[4]DIVICION$'
   REGRESAR DB '[5]REGRESAR  MENU PRINCIPAL$'
   CADENA6 DB 'SELECCIONE UNA OPCION [ ]$'
   CADENA0 DB '----------------------------$'
   
   MSJ1 DB 'INTRODUCE EL PRIMER NUMERO: $'
   MSJ2 DB 'INTRODUCE EL SEGUNDO NUMERO:$'
   MSJ3 DB 'EL RESULTADO ES: $'
   MSJ4 DB 'RESIDUO: $'
   
   NUM1 DB 0,'$'
   NUM2 DB 0,'$'


DATOS ENDS
;_________________CONTROL_________________________

CODIGO SEGMENT
    
    PRINCIPAL PROC FAR
        
        ASSUME DS:DATOS, CS:CODIGO
        
        MOV AX, DATOS
        MOV DS, AX 
        CALL STARTMENU
          
 PRINCIPAL ENDP 
 ;________________MENU PRINCIPAL OPCIONES_________________________
 
    RETORNO PROC NEAR
    
        MOV AH,05H

        MOV AL,0

        INT 10H

        

        RET 
    
RETORNO ENDP 
    
 STARTMENU PROC NEAR
       
        COLOREAR 0BAH, 0000,  184FH ;COLORES EN PANTALLA
        COLOREAR 0FH, 0510H, 1639H ;COLORES EN PANTALLA
        COLOREAR 0B0H, 0612H, 1337H ;COLORES EN PANTALLA
       
        ;------ICO---------
        POSICION 07,26,0
        IMPRIMIR CADENA0 
        
        POSICION 09,26,0
        IMPRIMIR CADENA0
        ;--------------------
        
        POSICION 08,28,0
        IMPRIMIR MENU1  
        
        POSICION 11,26,0
        IMPRIMIR OP1
        
        POSICION 12,26,0        
        IMPRIMIR OP2
        
        POSICION 18,20,0        
        IMPRIMIR SALIR
       
        
        POSICION 21,28,0
        IMPRIMIR CADENA6
        
        
        
;_______________________________________ 

       
           
MENU:
         
         POSICION  21,51,0
         
         MOV AH, 00H ;LEE UN CARACTER
          INT 16H
          
          CMP AL, '1' 
          JE OPC1
          
          CMP AL, '2' 
          JE OPC2
         
          
          JMP call FIN
          
 ;___________________________         
          
          OPC1: 
                CALL OPERACIONES
                JMP MENU
                
          OPC2:
                CALL CONDICIONAL 
                JMP MENU
          
       
   STARTMENU ENDP 
 
 ;------------CHECA SI EL NUMERO 1 ES MAAYOR------
 
       
 CONDICIONAL PROC NEAR 
   
        MOV AH,05H

        MOV AL,1

        INT 10H

        

        COLOREAR 1FH, 0000, 184FH

        

        POSICION 1,5,1

        IMPRIMIR OP2

        

        POSICION 5,20,1

        IMPRIMIR MSJ1

        

        MOV AH,01H

        INT 21H

        MOV NUM1,AL

        SUB NUM1,30H

        

        POSICION 7,20,1

        IMPRIMIR MSJ2

        MOV AH,01H

        INT 21H

        MOV NUM2,AL

        SUB NUM2,30H

        

        MOV AH,0

        MOV AL,NUM1

        MOV BL,NUM2
  
        CMP AL,BL
        
        JG ESMAYOR
        JL ESMENOR
        JE ESIGUAL
        
        ESMAYOR:
        POSICION 10,20,1
        IMPRIMIR MSJE1  
        JMP CALL RETORNO
        
        ESMENOR:
        POSICION 10,20,1 
        IMPRIMIR MSJE2  
        JMP CALL RETORNO
        
        ESIGUAL:
        POSICION 10,20,1
        IMPRIMIR IGUAL  
        JMP CALL RETORNO

    
 CONDICIONAL ENDP   
    
  

;_____________OPERACIONES __________________ 
  
 OPERACIONES PROC NEAR
    
    COLOREAR 0EAH, 0000,  184FH ;COLORES EN PANTALLA
        COLOREAR 0BH, 0510H, 1639H ;COLORES EN PANTALLA
        COLOREAR 0C0H, 0612H, 1437H ;COLORES EN PANTALLA
       
        ;------ICONO---------
        POSICION 07,26,0
        IMPRIMIR CADENA0 
        
        POSICION 09,26,0
        IMPRIMIR CADENA0
        ;--------------------
        
        POSICION 08,28,0
        IMPRIMIR CADENA1  
        
        POSICION 11,26,0
        IMPRIMIR CADENA2
        
        POSICION 12,26,0        
        IMPRIMIR CADENA3
        
        POSICION 13,26,0
        IMPRIMIR CADENA4
        
        POSICION 14,26,0
        IMPRIMIR CADENA5 
        
        POSICION 15,26,0
        IMPRIMIR REGRESAR
        
        POSICION 19,20,0 
        IMPRIMIR SALIR
        
        POSICION 21,30,0
        IMPRIMIR CADENA6 
        
         
        MENU2:
         
         POSICION  21,53,0
         
         MOV AH, 00H ;LEE UN CARACTER
          INT 16H
          
          CMP AL, '1' ;CMP AL,49
          JE OPCION1
          
          CMP AL, '2' 
          JE OPCION2
          
          
          CMP AL, '3' 
          JE OPCION3
          
          
          CMP AL, '4' 
          JE OPCION4
          
          CMP AL, '5' 
          JE OPCION5 
           
          
          
          JMP CALL FIN
          
 ;___________________________         
          
          OPCION1: 
                CALL SUMA
                JMP MENU2
                
          OPCION2:
                CALL RESTA
                JMP MENU2
                
          OPCION3:
                CALL MULTI
                JMP MENU2
          
          OPCION4:
                CALL DIVI
                JMP MENU2 
                
          OPCION5:
                CALL STARTMENU
                      
       
          
       
        
        OPERACIONES ENDP
 ;.----------FIN-------------
 
  FIN PROC NEAR
    
        MOV AH,4CH
        INT 21H
        
  FIN ENDP 
  
  ;-------------SUMA......
 SUMA PROC NEAR
    
    
        MOV AH,05H

        MOV AL,1

        INT 10H

        

        COLOREAR 1FH, 0000, 184FH

        POSICION 1,5,1

        IMPRIMIR CADENA2

        
        POSICION 5,20,1

        IMPRIMIR MSJ1

        

        MOV AH,01H

        INT 21H

        MOV NUM1,AL

        SUB NUM1,30H

        

        POSICION 7,20,1

        IMPRIMIR MSJ2

        MOV AH,01H

        INT 21H

        MOV NUM2,AL

        SUB NUM2,30H

        

        MOV AH,0

        MOV AL,NUM1

        MOV BL,NUM2

        ADD AL,BL

        AAA       

        

        ADD AL,30H

        ADD AH,30H

        MOV NUM1,AH

        MOV NUM2,AL

        

        POSICION 10,20,1

        IMPRIMIR MSJ3

        IMPRIMIR NUM1

        IMPRIMIR NUM2

        

        MOV AH,05H

        MOV AL,0

        INT 10H

        

        RET    

    SUMA ENDP
    
 ;_________________________
 
 RESTA PROC NEAR

        MOV AH,05H

        MOV AL,1

        INT 10H

        

        COLOREAR 1FH, 0000, 184FH

        

        POSICION 1,5,1

        IMPRIMIR CADENA3

        

        POSICION 5,20,1

        IMPRIMIR MSJ1

        

        MOV AH,01H

        INT 21H

        MOV NUM1,AL

        SUB NUM1,30H

        

        POSICION 7,20,1

        IMPRIMIR MSJ2

        MOV AH,01H

        INT 21H

        MOV NUM2,AL

        SUB NUM2,30H

        

        MOV AH,0

        MOV AL,NUM1

        MOV BL,NUM2

        SUB AL,BL

        AAS       

        

        ADD AL,30H

        ADD AH,30H

        MOV NUM1,AH

        MOV NUM2,AL

        

        POSICION 10,20,1

        IMPRIMIR MSJ3

        IMPRIMIR NUM1

        IMPRIMIR NUM2

        

        MOV AH,05H

        MOV AL,0

        INT 10H

        

        RET

    

    RESTA ENDP
    
;__________________________

MULTI PROC NEAR

        MOV AH,05H

        MOV AL,1

        INT 10H

        

        COLOREAR 1FH, 0000, 184FH

        

        POSICION 1,5,1

        IMPRIMIR CADENA4

        

        POSICION 5,20,1

        IMPRIMIR MSJ1

        

        MOV AH,01H

        INT 21H

        MOV NUM1,AL

        SUB NUM1,30H

        

        POSICION 7,20,1

        IMPRIMIR MSJ2

        MOV AH,01H

        INT 21H

        MOV NUM2,AL

        SUB NUM2,30H

        

        MOV AH,0

        MOV AL,NUM1

        MOV BL,NUM2

        MUL BL

        AAM       

        

        ADD AL,30H

        ADD AH,30H

        MOV NUM1,AH

        MOV NUM2,AL

        

        POSICION 10,20,1

        IMPRIMIR MSJ3

        IMPRIMIR NUM1

        IMPRIMIR NUM2

        

        MOV AH,05H

        MOV AL,0

        INT 10H

        

        RET

    

    MULTI ENDP

;________________________________________

DIVI PROC NEAR

        MOV AH,05H

        MOV AL,1

        INT 10H

        

        COLOREAR 1FH, 0000, 184FH

        

        POSICION 1,5,1

        IMPRIMIR CADENA5

        

        POSICION 5,20,1

        IMPRIMIR MSJ1

        

        MOV AH,01H

        INT 21H

        MOV NUM1,AL

        SUB NUM1,30H

        

        POSICION 7,20,1

        IMPRIMIR MSJ2

        MOV AH,01H

        INT 21H

        MOV NUM2,AL

        SUB NUM2,30H

        

        MOV AH,0

        MOV AL,NUM1

        MOV BL,NUM2

        DIV BL       

        

        ADD AL,30H

        ADD AH,30H

        MOV NUM1,AH

        MOV NUM2,AL

        

        POSICION 10,20,1

        IMPRIMIR MSJ3

        IMPRIMIR NUM2

        

        POSICION 11,28,1

        IMPRIMIR MSJ4

        IMPRIMIR NUM1

        

        MOV AH,05H

        MOV AL,0

        INT 10H

        

        RET

    

    DIVI ENDP
 ;_________________________________       
    
CODIGO ENDS
    END PRINCIPAL