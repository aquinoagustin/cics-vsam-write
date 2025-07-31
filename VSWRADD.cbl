       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAMWRIT.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
          01 WS-REGISTRO.
             05 WS-CLAVE        PIC 9(2) VALUE ZERO.
             05 WS-DATOS        PIC X(25).
          01 WS-RESP            PIC S9(8) COMP.
          01 WS-CONSTANTES.
             05 WS-MENSAJE-OK   PIC X(16)
                                  VALUE 'Registro escrito'.
             05 WS-MENSAJE-ERR  PIC X(18)
                                  VALUE 'Error desconocido:'.
             05 WS-MENSAJE-DUP  PIC X(15)
                                  VALUE 'Clave duplicada'.
             05 WS-MENSAJE-END  PIC    X(21)
                                  VALUE 'TRANSACCION TERMINADA'.
          01 WS-MENSAJE-LEN     PIC S9(4) USAGE IS BINARY.
          01 WS-COUNT           PIC 9(2)  VALUE ZERO.
          77 WS-LIMIT           PIC 9(2)  VALUE 10.
       PROCEDURE DIVISION.
       MAIN-PROCESS.
           MOVE 'CAMPO ESCRITO DESDE COBOL' TO WS-DATOS.
           PERFORM WRITE-REGISTRO UNTIL WS-COUNT = WS-LIMIT.
           PERFORM TERMINAR-TRANSACCION.
           EXEC CICS RETURN END-EXEC.
       WRITE-REGISTRO.
           EXEC CICS WRITE
                     FILE('COBTESN1')
                     FROM(WS-REGISTRO)
                     RIDFLD(WS-CLAVE)
                     RESP(WS-RESP)
           END-EXEC
           EVALUATE WS-RESP
               WHEN DFHRESP(NORMAL)
                  DISPLAY WS-MENSAJE-OK
               WHEN DFHRESP(DUPREC)
                  DISPLAY WS-MENSAJE-DUP
               WHEN OTHER
                   DISPLAY WS-MENSAJE-ERR WS-RESP
           END-EVALUATE
           ADD 1 TO WS-CLAVE.
           ADD 1 TO WS-COUNT.
       TERMINAR-TRANSACCION.
           MOVE LENGTH WS-MENSAJE-END TO WS-MENSAJE-LEN.
           EXEC CICS SEND
                     FROM(WS-MENSAJE-END)
                     LENGTH(WS-MENSAJE-LEN)
                     ERASE
           END-EXEC.
