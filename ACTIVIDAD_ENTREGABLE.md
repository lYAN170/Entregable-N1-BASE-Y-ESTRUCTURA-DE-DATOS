## ACTIVIDAD ENTREGABLE N° 2


VENTASBD

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/771e99c4-c0ad-434f-b064-3d7a3534240c)



### 1.-Consultar proveedores por código de distrito

    SELECT * FROM PROVEEDOR WHERE COD_DIS = 'D02';

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/4584389b-fb59-483a-a306-ed2f589e9dbe)


### 2.-obtener un reporte estadístico de ventas agrupado por distrito, tipo de cliente y calculando la cantidad de ventas y el total de ventas (incluyendo el IGV) para cada combinación de distrito y tipo de cliente

      SELECT D.COD_DIS, D.NOM_DIS, C.TIP_CLI, COUNT(*) AS CANTIDAD_VENTAS, SUM(F.POR_IGV) AS TOTAL_VENTAS
      FROM FACTURA F
      JOIN CLIENTE C ON F.COD_CLI = C.COD_CLI
      JOIN DISTRITO D ON C.COD_DIS = D.COD_DIS
      GROUP BY D.COD_DIS, D.NOM_DIS, C.TIP_CLI
      ORDER BY D.COD_DIS, C.TIP_CLI;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/4e4789bd-2cd3-43bd-a961-0cc58db99622)


### 3.-obtener un reporte que muestra la cantidad vendida y el total vendido de productos agrupados

    SELECT P.LIN_PRO, P.DES_PRO, COUNT(DF.COD_PRO) AS CANTIDAD_VENDIDA, SUM(DF.CAN_VEN) AS TOTAL_VENDIDO
    FROM DETALLE_FACTURA DF
    JOIN PRODUCTO P ON DF.COD_PRO = P.COD_PRO
    GROUP BY P.LIN_PRO, P.DES_PRO
    ORDER BY CANTIDAD_VENDIDA DESC;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/b34e8dc7-c7e5-40a2-ba1c-e174be5705f2)


### 4.-obtener el número para todas las facturas que contienen el producto con la descripción LAPICERO NEGRO

    SELECT F.NUM_FAC AS TOTAL
    FROM FACTURA F
    JOIN DETALLE_FACTURA DF ON F.NUM_FAC = DF.NUM_FAC
    JOIN PRODUCTO P ON DF.COD_PRO = P.COD_PRO
    WHERE P.DES_PRO = 'LAPICERO NEGRO';

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/5544aed5-4d83-4d3c-9635-bfeaef9d6f45)


### 5.-la consulta es identificar los productos cuyo stock actual es menor que su stock mínimo.

    SELECT P.COD_PRO, P.DES_PRO, P.SAC_PRO
    FROM PRODUCTO P
    WHERE P.SAC_PRO < P.SMI_PRO
    ORDER BY P.SAC_PRO ASC;


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/6a24595d-5b40-4b4d-b72f-5813b0f9fc30)

### 6.-la creación del índice y la ejecución de la consulta están diseñadas para mejorar la eficiencia y el rendimiento al buscar clientes por su código de distrito en la tabla CLIENTE dentro de la base de datos.

    CREATE INDEX idx_cliente_cod_distrito ON CLIENTE (COD_DIS);

    EXEC sp_helpindex 'CLIENTE';

    SELECT * FROM CLIENTE WHERE COD_DIS = 'D01';

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/c47d60a7-5891-4aa9-a973-14a154858931)

## Procedimiento de almacenamiento


    CREATE PROCEDURE InsertarCliente
        @COD_CLI CHAR(10),
        @RSO_CLI CHAR(30),
        @DIR_CLI VARCHAR(100),
        @TLF_CLI CHAR(10),
        @RUC_CLI CHAR(10),
        @COD_DIS CHAR(5),
        @FEC_REG DATE,
        @TIP_CLI VARCHAR(10),
        @CON_CLI VARCHAR(30)
    AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO CLIENTE (COD_CLI, RSO_CLI, DIR_CLI, TLF_CLI, RUC_CLI, COD_DIS, FEC_REG, TIP_CLI, CON_CLI)
        VALUES (@COD_CLI, @RSO_CLI, @DIR_CLI, @TLF_CLI, @RUC_CLI, @COD_DIS, @FEC_REG, @TIP_CLI, @CON_CLI);
    END
    GO

---

### Procedimiento de almacenamiento

    EXEC InsertarCliente @COD_CLI = 'C022', @RSO_CLI = 'Landuus', @DIR_CLI = 'av laykakota', @TLF_CLI = '916359619', @RUC_CLI = '1070972986', @COD_DIS = 'D05', @FEC_REG = '2024-06-22', 
    @TIP_CLI = '1', @CON_CLI = 'YAM CARLOS';

### Consulta para verificar si se inserto correctamente.

    SELECT *
    FROM CLIENTE
    WHERE COD_CLI = 'C022';

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/c3d86277-8b22-49bf-9def-66a2c6f6c423)



### este trigger es una herramienta poderosa para automatizar y mantener la consistencia en el estado de las facturas dentro de tu sistema de base de datos


### actualizar automáticamente el estado de las facturas que se insertan en la tabla FACTURA.



    USE VENTASBD;
    GO


    CREATE TRIGGER trg_ActualizarEstadoFactura
    ON FACTURA
    AFTER INSERT
    AS
    BEGIN
        UPDATE FACTURA
        SET EST_FAC = 'PENDIENTE'
        WHERE NUM_FAC IN (SELECT NUM_FAC FROM inserted);
    END;



![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/3192911a-28c2-4b39-a2f5-1e9a57cbb2cd)


