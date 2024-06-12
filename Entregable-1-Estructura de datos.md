
| EXPLICACION | SE REALIZARA EN CADA FUNCION A DESARROLLAR DE LA ACTIVIDAD PROPUESTA:  |
| ----------- | ----------- |


# Entregable N° 1


## CREAR UNA BASE DE DATOS ClinicaDB

    CREATE DATABASE ClinicaBD;
    GO

    USE clinicaBD;
    GO

    CREATE TABLE Dept (
      Dept_No INT,
      DNombre NVARCHAR(50),
      Loc NVARCHAR(50)
    );
    GO

    CREATE TABLE Emp (
      Emp_No INT,
     Apellido NVARCHAR(50),
     Oficio NVARCHAR(50),
     Dir INT,
     Fecha_Alt DATE,
     Salario DECIMAL(10, 2),
     Comision DECIMAL(10, 2),
     Dept_No INT,
    );
    GO

    CREATE TABLE Enfermo (
     Inscripcion INT,
     Apellido NVARCHAR(50),
     Direccion NVARCHAR(100),
     Fecha_Nac DATE,
     S CHAR(1),
     NSS NVARCHAR(20)
    );
    GO

---

    INSERT INTO Dept (Dept_No, DNombre, Loc) VALUES 
    (03, 'Finanza', 'lurin'),
    (04, 'Marketing', 'lima'),
    (05, 'derechos', 'junin'),
    (07, 'Recursos', 'San Diego'),

    GO


    INSERT INTO Emp (Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No) VALUES
      (02, 'mila', 'investigadora', 2, '2018-06-01', 2200.00, 370.00, 04),
      (04, 'lyan', 'diseñador & marketing digital', 1, '2017-12-05', 3500.00, 150.00, 07),
      (05, 'victor', 'ing. Informatico', 2, '2015-02-17', 5000.00, 300.00, 07),
      (06, 'Wilson', 'administrador de redes', 4, '2017-04-12', 4000.00, 350.00, 08);
    GO


    INSERT INTO Enfermo (Inscripcion, Apellido, Direccion, Fecha_Nac, S, NSS) VALUES
      (2, 'Martinez', 'AV. San Francisco', '1975-06-23', 'F', '127-65-5555'),
      (4, 'Lopez', 'JR. Benavides', '1985-02-28', 'M', '200-55-6666'),
      (5, 'Gonzalez', 'JR. Lima', '1979-12-05', 'M', '250-88-9999'),
      (6, 'Ramirez', 'JR. olivos', '1990-01-15', 'M', '270-33-4444');
    GO

---


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/ef846d27-6e13-4ccb-b78c-8c135b49c3f8)


## Ejecutar operaciones básicas tipo DCL y TCL para crear procedimientos y funciones.
### Obtener todos los empleados que se dieron de alta antes del año 2018 y que pertenecen a un determinado departamento. Además, utilizando los comandos DCL.

---

| FUNCION | declara una variable para almacenar el número de un departamento específico (7) y luego selecciona todos los registros de la tabla Emp que cumplen dos condiciones: que la fecha de alta sea anterior           al 1 de enero de 2018 y que el número de departamento sea igual a 7. |
| ----------- | ----------- |

    DECLARE @DeptNo INT = 7
    SELECT *
    FROM Emp
    WHERE Fecha_Alt < '2018-01-01'
      AND Dept_No = @DeptNo;
    GO  
![image](https://github.com/lYAN170/TAREA11/assets/169726463/e3b5119d-19a1-4fb5-acd1-e5187bfd2f61)

---
### Crear un procedimiento almacenado que permita insertar un nuevo departamento.


    CREATE PROCEDURE InsertDept
    @Dept_No INT,
    @DNombre NVARCHAR(50),
    @Loc NVARCHAR(50)
      AS
      BEGIN
    INSERT INTO Dept (Dept_No, DNombre, Loc)
    VALUES (@Dept_No, @DNombre, @Loc);
    END;
    GO


    EXEC InsertDept @Dept_No = 1, @DNombre = 'RR', @Loc = 'Nuevo Imperial';


---
### Crear un procedimiento para devolver el apellido, oficio y salario, pasándole como parámetro el número del empleado.

| FUNCION | define un procedimiento almacenado llamado InsertEmp que inserta un nuevo empleado en la tabla Emp. Luego, se ejecuta este procedimiento para insertar un registro con los datos proporcionados:  |
| ----------- | ----------- |

    CREATE PROCEDURE InsertEmp
    @Emp_No INT,
    @Apellido NVARCHAR(50),
    @Oficio NVARCHAR(50),
    @Dir INT,
    @Fecha_Alt DATE,
    @Salario DECIMAL(10, 2),
    @Comision DECIMAL(10, 2),
    @Dept_No INT
      AS
      BEGIN
    INSERT INTO Emp (Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No)
    VALUES (@Emp_No, @Apellido, @Oficio, @Dir, @Fecha_Alt, @Salario, @Comision, @Dept_No);
    END;
    GO

    EXEC InsertEmp @Emp_No = 7, @Apellido = 'Jones', @Oficio = 'Salesman', @Dir = 3, @Fecha_Alt = '2024-06-11', @Salario = 4500.00, @Comision = 500.00, @Dept_No = 004;


---

| FUNCION |un procedimiento almacenado llamado UpdateEmp que inserta un nuevo empleado en la tabla Emp. Luego, se ejecuta este procedimiento para insertar un registro con los datos proporcionados.  |
| ----------- | ----------- |

    CREATE PROCEDURE UpdateEmp
        @Emp_No INT,
    @Apellido NVARCHAR(50),
    @Oficio NVARCHAR(50),
    @Dir INT,
    @Fecha_Alt DATE,
    @Salario DECIMAL(10, 2),
    @Comision DECIMAL(10, 2),
    @Dept_No INT
      AS
      BEGIN
    INSERT INTO Emp (Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No)
    VALUES (@Emp_No, @Apellido, @Oficio, @Dir, @Fecha_Alt, @Salario, @Comision, @Dept_No);
    END;
    GO

    EXEC UpdateEmp @Emp_No = 9, @Apellido = 'Jhonathan', @Oficio = 'arqui', @Dir = 7, @Fecha_Alt = '2021-01-11', @Salario = 4300.00, @Comision = 700.00, @Dept_No = 009;


---

| FUNCION | proporciona una estructura básica para manejar transacciones en SQL. Se inicia una transacción con BEGIN TRANSACTION y luego se deshace con ROLLBACK, revirtiendo cualquier cambio hecho durante la transacción, y para manejar errores de manera controlada. |
| ----------- | ----------- |

    BEGIN TRANSACTION
    ROLLBACK;

    Select * from Emp;

---

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/ae6878a1-5f30-4fbe-8bf9-cbf7bbef7033)


---

### Crear un procedimiento almacenado para dar de baja a un empleado pasándole como parámetro su apellido.

| FUNCION | modifica el almacenado, Primero elimina el valor(apellido) de la columna y luego establece el valor de la columna Apellido a NULL para todos los empleados cuyo apellido coincida con el valor proporcionado. |
| ----------- | ----------- |
    ALTER PROCEDURE DeleteEmp
    @Apellido NVARCHAR(50)
      AS
        BEGIN
    UPDATE Emp
    SET Apellido = NULL
    WHERE Apellido = @Apellido;
    END;

---

    EXEC DeleteEmp @Apellido = 'Jones';


![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/556bdcc1-f312-40c4-962b-372b570faf16)

----

## Crear restricciones al modelo de BD, para asegurar la calidad de la información.
### Se procede a crear restricciones para los datos almacenados en la base de datos.

| FUNCION | añade restricciones de unicidad a las tablas Emp, Dept y Enfermo en la base de datos. Estas restricciones garantizan que los valores en las columnas sean únicos, evitando duplicados en estas columnas. Las restricciones ayudan a mantener la integridad de los datos en la base de datos.|
| ----------- | ----------- |

    ALTER TABLE [dbo].[Emp] ADD CONSTRAINT UQ_Emp_Emp_No UNIQUE (Emp_No)

    ALTER TABLE [dbo].[Dept] ADD CONSTRAINT UQ_Dept_Dept_No UNIQUE (Dept_No)

    ALTER TABLE [dbo].[Enfermo] ADD CONSTRAINT UQ_Enfermo_Inscripcion UNIQUE (Inscripcion)

| EXPLICACIÓN | Al momento de insertar nuevos datos, no se permitiran ya que esta restringido para mantener la integridad de la base de datos.|
| ----------- | ----------- |

![image](https://github.com/lYAN170/Entregable-N1-BASE-Y-ESTRUCTURA-DE-DATOS/assets/169726463/ee55039e-2f95-43a0-b510-5301d7e4498f)

---

