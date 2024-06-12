## TAREA 12 
### PROCESOS DE EJECUCION DE CONSULTAS REALIZAS DE LAS 30 PREGUNTAS QUE SE REALIZARAN EN SQL SERVER DE LA BASE DE DATOS: RETAIL.



## 1.- 1.	Total, de ventas en el año 2009:
### ¿Cuál es el total de ventas realizadas en el año 2009?


    DECLARE @fecha_inicio_2009 datetime = '2009-01-01';
    DECLARE @fecha_fin_2009 datetime = '2009-12-31';

    SELECT FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM [ve].[documento]
    WHERE fechaMovimiento BETWEEN @fecha_inicio_2009 AND @fecha_fin_2009;


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/9976e3e1-13f8-4a86-ad07-acbdcd94ceb6)


## 2.- 2.	Personas sin entradas registradas en la tabla personaDestino:
### ¿Cuáles son las personas que no tienen una entrada registrada en la tabla personaDestino?
 

    SELECT p.*
    FROM [ma].[persona] p
    LEFT JOIN [ma].[personaDestino] pd ON p.persona = pd.persona
    WHERE pd.persona IS NULL
    ORDER BY p.persona;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/eae7c7ea-b987-4774-96c3-4d37390436e3)

## 3.-	Promedio del monto total de transacciones de ventas:
### ¿Cuál es el promedio del monto total de todas las transacciones de ventas registradas en la base de datos, expresado en moneda local (soles peruanos)?


    SELECT FORMAT(AVG(total), 'C', 'es-PE') AS [Promedio del Monto Total en Soles]
    FROM [ve].[documento];

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/a778a98c-ec1b-4f99-8404-d04cbffefe69)


## 4.	Documentos de ventas con monto total superior al promedio:
### Obtén una lista de todos los documentos de ventas cuyo monto total supere el promedio del monto total de todos los documentos de ventas registrados en la base de datos.


    SELECT *,
       FORMAT(total, 'C', 'es-PE') AS Total_Ventas_En_Soles
    FROM [ve].[documento]
    WHERE total > (SELECT AVG(total) FROM [ve].[documento])
    ORDER BY total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/aec6f6d2-2978-4123-9e91-254855d648b2)


## 5.	Documentos de ventas pagados con una forma de pago específica:
### Listar los documentos de ventas que han sido pagados utilizando una forma de pago específica desde la tabla documentoPago.



    SELECT d.*, 
       FORMAT(d.total, 'C', 'es-PE') AS Total_Ventas_En_Soles
    FROM [ve].[documentoPago] dp
    INNER JOIN [ve].[documento] d ON dp.documento = d.documento
    INNER JOIN [pa].[pago] p ON dp.pago = p.pago
    WHERE p.formaPago = 1 
    ORDER BY d.total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/4afebd2a-a68a-4e9d-84b8-370104bf9e68)

## 6.	Detalles de documentos de ventas canjeados:
### ¿Cómo se distribuye el saldo total entre los diferentes almacenes, considerando la información de los saldos iniciales de inventario en la base de datos?




    SELECT almacen, 
       FORMAT(SUM(costoSoles), 'C', 'es-PE') AS Saldo_Total
    FROM [ma].[saldosIniciales]
    GROUP BY almacen
    ORDER BY Saldo_Total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/0e54b5a6-b36e-454f-95c4-5b2be4d65c92)

## 7.	Saldo total distribuido por almacén:
### Obtén una lista de todos los documentos de ventas cuyo monto total supere el promedio del monto total de todos los documentos de ventas registrados en la base de datos.



    SELECT *,
       FORMAT(total, 'C', 'es-PE') AS Total_Ventas_En_Soles
    FROM [ve].[documento]
    WHERE total > (SELECT AVG(total) FROM [ve].[documento])
    ORDER BY total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/2261bf84-518d-4e99-a021-ea7b70259992)


## 8.	Detalles de documentos de ventas por vendedor:
### ¿Cuáles son los detalles de los documentos de ventas asociados al vendedor con identificación número 3 en la base de datos, considerando la información detallada de cada documento en relación con sus elementos de venta?



    SELECT d.*, 
       dd.*, 
       FORMAT(d.total, 'C', 'es-PE') AS Total_Ventas_En_Soles
    FROM [ve].[documento] d
    INNER JOIN [ve].[documentoDetalle] dd ON d.documento = dd.documento
    WHERE d.vendedor = 3
    ORDER BY d.total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/eec8144f-de7d-405c-8467-a0255b58543c)


## 9.	Total de ventas por año y vendedor:
### ¿Cuál es el total de ventas por año y vendedor en la base de datos de ventas, considerando solo aquellos vendedores cuya suma total de ventas en un año específico sea superior a 100,000 unidades monetarias?


    SELECT vendedor, 
       YEAR(fechaMovimiento) AS Anio, 
       FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM ve.documento
    GROUP BY vendedor, YEAR(fechaMovimiento)
    HAVING SUM(total) > 100000
    ORDER BY Total_Ventas;
![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/d306b503-c81d-4687-a56d-80c002a93c5d)

## 10.	Desglose mensual de ventas por vendedor:
### ¿Cuál es el desglose mensual de las ventas por vendedor en cada año, considerando la suma total de ventas para cada mes y año específico?



    SELECT vendedor, 
       YEAR(fechaMovimiento) AS Anio, 
       MONTH(fechaMovimiento) AS Mes, 
       FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM ve.documento
    GROUP BY vendedor, YEAR(fechaMovimiento), MONTH(fechaMovimiento)
    ORDER BY Anio, Mes, Total_Ventas;
    
![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/b4efcf5d-6c5f-433e-ac68-1ce62cefcbe6)


## 11.	Clientes que compraron más de 10 veces en un año:
### ¿Cuántos clientes compraron más de 10 veces en un año?


    SELECT persona, 
       YEAR(fechaMovimiento) AS Año, 
       COUNT(*) AS Compras
    FROM ve.documento
    WHERE tipoMovimiento = 1
    GROUP BY persona, YEAR(fechaMovimiento)
    HAVING COUNT(*) > 10;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/b525cca9-c15e-41f2-90e5-e7f1eb225203)


## 12.	Total acumulado de descuentos por vendedor:
### ¿Cuál es el total acumulado de descuentos aplicados por cada vendedor en la base de datos de ventas, considerando la suma de los descuentos descto01, descto02 y descto03, y mostrando solo aquellos vendedores cuyo total de descuentos acumulados supere los 5000?


    SELECT vendedor, 
       SUM(descto01 + descto02 + descto03) AS Descuentos_Acumulados
    FROM ve.documento
    GROUP BY vendedor
    HAVING SUM(descto01 + descto02 + descto03) > 5000;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/86701c64-be21-46b2-af3f-8bec751e6abd)


## 13.	Total anual de ventas por persona:
### ¿Cuál es el total anual de ventas realizadas por cada persona en la base de datos de ventas, considerando únicamente los movimientos de tipo venta (tipoMovimiento = 1), y mostrando solo aquellas personas cuyas ventas anuales superen los 10000?


    SELECT persona, 
       YEAR(fechaMovimiento) AS Año, 
       SUM(total) AS Total_Anual
    FROM ve.documento
    WHERE tipoMovimiento = 1
    GROUP BY persona, YEAR(fechaMovimiento)
    HAVING SUM(total) > 10000;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/9fac8551-e9a6-4f9a-893c-42a40b950756)


## 14.	Recuento total de productos vendidos por vendedor:
### ¿Cuál es el recuento total de productos vendidos por cada vendedor en la base de datos de ventas?


    SELECT 
      d.vendedor, 
      COUNT(dd.documentoDetalle) AS Total_Productos_Vendidos
    FROM 
      ve.documentoDetalle dd
    JOIN 
      ve.documento d ON dd.documento = d.documento
    GROUP BY 
      d.vendedor;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/763a2158-2578-4d33-ba01-45b0314ce162)


	-- 15

	SELECT 
    YEAR(fechaMovimiento) AS Año,
    MONTH(fechaMovimiento) AS Mes,
    p.formaPago,
    SUM(total) AS Total_Ventas
    FROM 
      ve.documento d
    JOIN 
      pa.pago p ON d.vendedor = p.vendedor
    WHERE 
      YEAR(fechaMovimiento) = 2009
    GROUP BY 
      YEAR(fechaMovimiento),
      MONTH(fechaMovimiento),
      p.formaPago;


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/3ef63798-97cc-40bd-8b5b-cfcceddcc05b)


## 16.	Total de ventas en el año 2007:
### ¿Cuál es el total de ventas realizadas en el año 2007?


	  DECLARE @fecha_inicio datetime = '2007-01-01';
    DECLARE @fecha_fin datetime = '2007-12-31';

    SELECT FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM [ve].[documento]
    WHERE fechaMovimiento BETWEEN @fecha_inicio AND @fecha_fin;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/efc6a7c0-6467-476d-94a8-cf98a7ac5954)

## 17.	Personas sin entradas registradas en la tabla personaDestino en el año 2008:
### ¿Cuáles son las personas que no tienen una entrada registrada en la tabla personaDestino en el año 2008?


    DECLARE @fecha_inicio datetime = '2007-01-01';
    DECLARE @fecha_fin datetime = '2007-12-31';

    SELECT FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM [ve].[documento]
    WHERE fechaMovimiento BETWEEN @fecha_inicio AND @fecha_fin;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/8a27c27f-2875-405e-8e2a-e87bdcf0db44)


## 18.	Promedio del monto total de transacciones de ventas en el año 2009:
### ¿Cuál es el promedio del monto total de todas las transacciones de ventas registradas en la base de datos en el año 2009, expresado en moneda local (soles peruanos)?


    DECLARE @fecha_inicio datetime = '2009-01-01';
    DECLARE @fecha_fin datetime = '2009-12-31';

    SELECT FORMAT(AVG(total), 'C', 'es-PE') AS [Promedio del Monto Total en Soles]
    FROM [ve].[documento]
    WHERE fechaMovimiento BETWEEN @fecha_inicio AND @fecha_fin;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/ea420cb2-5b5d-4741-af4c-6e72a1569124)


## 19.	Documentos de ventas con monto total superior al promedio en el año 2005:
### Obtén una lista de todos los documentos de ventas cuyo monto total supere el promedio del monto total de todos los documentos de ventas registrados en la base de datos en el año 2005.


    DECLARE @promedio MONEY;

    SELECT @promedio = AVG(total) FROM [ve].[documento] WHERE YEAR(fechaMovimiento) = 2005;
    SELECT *
    FROM [ve].[documento]
    WHERE total > @promedio AND YEAR(fechaMovimiento) = 2005;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/671e59ce-81b7-47e7-992b-b03cfb6c4053)


## 20.	Documentos de ventas pagados con una forma de pago específica en el año 2006:
### Listar los documentos de ventas que han sido pagados utilizando una forma de pago específica desde la tabla documentoPago en el año 2006.


    SELECT d.*
    FROM [ve].[documentoPago] dp
    INNER JOIN [ve].[documento] d ON dp.documento = d.documento
    INNER JOIN [pa].[pago] p ON dp.pago = p.pago
    WHERE YEAR(d.fechaMovimiento) = 2006
      ORDER BY d.total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/d20ee8be-05b2-4cfa-b97b-ece56f901103)


## 21.	Detalles de documentos de ventas canjeados en el año 2007:
### ¿Cómo se distribuye el saldo total entre los diferentes almacenes, considerando la información de los saldos iniciales de inventario en la base de datos en el año 2007?


    DECLARE @fecha_inicio_2007 DATETIME = '2007-01-01';

    SELECT almacen, FORMAT(SUM(costoSoles), 'C', 'es-PE') AS Saldo_Total
    FROM [ma].[saldosIniciales]
    WHERE YEAR(@fecha_inicio_2007) = 2007 GROUP BY almacen
    ORDER BY almacen

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/04e54174-d851-4dd4-9cd9-3c57801f2790)



## 22.	Saldo total distribuido por almacén en el año 2008:
### Obtén una lista de todos los documentos de ventas cuyo monto total supere el promedio del monto total de todos los documentos de ventas registrados en la base de datos en el año 2008.


    DECLARE @promedio MONEY;

    SELECT @promedio = AVG(total) FROM [ve].[documento] WHERE YEAR(fechaMovimiento) = 2008;

    SELECT *
    FROM [ve].[documento]
    WHERE total > (SELECT @promedio) AND YEAR(fechaMovimiento) = 2008;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/4a0c6f4d-d83b-4f63-9431-046cbe8244a5)

## 23.	Detalles de documentos de ventas por vendedor en el año 2009:
### ¿Cuáles son los detalles de los documentos de ventas asociados al vendedor con identificación número 3 en la base de datos en el año 2009, considerando la información detallada de cada documento en relación con sus elementos de venta?


    SELECT d.*, 
       dd.*, 
       FORMAT(d.total, 'C', 'es-PE') AS Total_Ventas_En_Soles
    FROM [ve].[documento] d
    INNER JOIN [ve].[documentoDetalle] dd ON d.documento = dd.documento
    WHERE d.vendedor = 3 AND YEAR(d.fechaMovimiento) = 2009
    ORDER BY d.total;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/7688e0ad-55d8-496f-8572-8de80ea0fee0)


## 24.	Total de ventas por año y vendedor en el año 2008:
### ¿Cuál es el total de ventas por año y vendedor en la base de datos de ventas, considerando solo aquellos vendedores cuya suma total de ventas en el año 2008 sea superior a 100,000 unidades monetarias?


    SELECT vendedor, 
       YEAR(fechaMovimiento) AS Anio, 
       FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM ve.documento
    WHERE YEAR(fechaMovimiento) = 2008
    GROUP BY vendedor, YEAR(fechaMovimiento)
    HAVING SUM(total) > 100000
    ORDER BY Total_Ventas;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/d91cefac-3c23-4fc1-8899-8be7fb46d13d)



## 25.	Desglose mensual de ventas por vendedor en el año 2009:
### ¿Cuál es el desglose mensual de las ventas por vendedor en cada año, considerando la suma total de ventas para cada mes y año específico en el año 2009?


    SELECT vendedor, 
       YEAR(fechaMovimiento) AS Anio, 
       MONTH(fechaMovimiento) AS Mes, 
       FORMAT(SUM(total), 'C', 'es-PE') AS Total_Ventas
    FROM ve.documento
    WHERE YEAR(fechaMovimiento) = 2009
    GROUP BY vendedor, YEAR(fechaMovimiento), MONTH(fechaMovimiento)
    ORDER BY Anio, Mes, Total_Ventas;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/11b5b59f-2789-4766-ad63-0bf1170a643d)


## 26.	Clientes que compraron más de 10 veces en un año en el año 2005:
### ¿Cuántos clientes compraron más de 10 veces en un año en el año 2005?


    SELECT persona, 
       YEAR(fechaMovimiento) AS Año, 
       COUNT(*) AS Compras
    FROM ve.documento
    WHERE tipoMovimiento = 1 AND YEAR(fechaMovimiento) = 2005
    GROUP BY persona, YEAR(fechaMovimiento)
  HAVING COUNT(*) > 10;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/9e099b62-92ff-4e78-a75f-3999a637d073)


## 27.	Total acumulado de descuentos por vendedor en el año 2006:
### ¿Cuál es el total acumulado de descuentos aplicados por cada vendedor en la base de datos de ventas, considerando la suma de los descuentos descto01, descto02 y descto03, y mostrando solo aquellos vendedores cuyo total de descuentos acumulados supere los 5000 en el año 2005?


    SELECT vendedor, 
       SUM(descto01 + descto02 + descto03) AS Descuentos_Acumulados
    FROM ve.documento
    WHERE YEAR(fechaMovimiento) = 2005
    GROUP BY vendedor
    HAVING SUM(descto01 + descto02 + descto03) > 5000;

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/dba647f9-3393-4bc0-a10d-e14fe2e99150)

## 28.- Total anual de ventas por persona en el año 2007:
### ¿Cuál es el total anual de ventas realizadas por cada persona en la base de datos de ventas, considerando únicamente los movimientos de tipo venta (tipoMovimiento = 1), y mostrando solo aquellas personas cuyas ventas anuales superen los 10000 en el año 2007?

    SELECT vendedor, 
       SUM(descto01 + descto02 + descto03) AS Descuentos_Acumulados
    FROM ve.documento
    WHERE YEAR(fechaMovimiento) = 2005
    GROUP BY vendedor
    HAVING SUM(descto01 + descto02 + descto03) > 5000;


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/8c3a2361-a454-4ef2-aab9-4963f0558bbf)


## 29.- Recuento total de productos vendidos por vendedor en el año 2008:
### ¿Cuál es el recuento total de productos vendidos por cada vendedor en la base de datos de ventas en el año 2008?


    SELECT 
       d.vendedor, 
      COUNT(dd.documentoDetalle) AS Total_Productos_Vendidos
    FROM 
        ve.documentoDetalle dd
    JOIN 
        ve.documento d ON dd.documento = d.documento
    WHERE 
        YEAR(d.fechaMovimiento) = 2008
    GROUP BY 
        d.vendedor;


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/2fdf8755-8e9c-42e5-8e00-221521ce3460)

## 30.	Ventas mensuales desglosadas por tipo de pago en el año 2009:
### ¿Cuánto se vendió cada mes del año 2009, desglosado por tipo de pago?


    	SELECT 
        YEAR(fechaMovimiento) AS Año,
        MONTH(fechaMovimiento) AS Mes,
        p.formaPago,
        SUM(total) AS Total_Ventas
    FROM 
        ve.documento d
    JOIN 
        pa.pago p ON d.vendedor = p.vendedor
    WHERE 
        YEAR(fechaMovimiento) = 2009
    GROUP BY 
        YEAR(fechaMovimiento),
        MONTH(fechaMovimiento),
        p.formaPago;


 ![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/8708d8e5-6fc3-4f44-b8cd-6e475dd07558)

