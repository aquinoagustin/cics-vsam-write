# COBOL + CICS - Escritura en VSAM (VSAMWRIT)

Este proyecto contiene un ejemplo de programa COBOL que se ejecuta bajo CICS y escribe múltiples registros en un archivo VSAM tipo KSDS.

---

## 🖥️ Descripción

- **Programa:** `VSAMWRIT`  
- **Archivo VSAM:** `COBTESN1` (KSDS con clave de 2 bytes)  
- **Transacción CICS:** definida por el usuario  
- **Terminal de pruebas:** 3270  

El objetivo del programa es demostrar:
- Escritura de registros en un archivo VSAM mediante `EXEC CICS WRITE`.
- Control de errores con códigos de respuesta (RESP).
- Uso de mensajes constantes y envío de mensaje final a la terminal.
