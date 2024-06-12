-------------------Entregable 1--------------

INSERT INTO Dept (Dept_No, DNombre, Loc) VALUES
(03, 'Finanza', 'lurin'),
(04, 'Marketing', 'lima'),
(05, 'derechos', 'junin'),
(07, 'Recursos', 'San Diego'),
(07, 'clinica', 'san isidro'),
(08, 'Administrador', 'la oroya');
GO
select *
from Dept;   select * from Emp;   delete Emp; delete Dept;

delete Emp
INSERT INTO Emp (Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No) VALUES
(01, 'danny', 'Analista', 1, '2019-11-11', 3800.00, 400.00, 03),
(02, 'mila', 'investigadora', 2, '2018-06-01', 2200.00, 370.00, 04),
(03, 'neitor', 'psicologo', 3, '2017-07-19', 1700.00, 200.00, 05),
(04, 'lyan', 'diseñador & marketing digital', 1, '2017-12-05', 3500.00, 150.00, 07),
(05, 'victor', 'ing. Informatico', 2, '2015-02-17', 5000.00, 300.00, 07),
(06, 'Wilson', 'administrador de redes', 4, '2017-04-12', 4000.00, 350.00, 08);
GO


INSERT INTO Enfermo (Inscripcion, Apellido, Direccion, Fecha_Nac, S, NSS) VALUES
(1, 'Torres', 'AV. Los libertadores', '1980-04-12', 'F', '123-45-2222'),
(2, 'Martinez', 'AV. San Francisco', '1975-06-23', 'F', '127-65-5555'),
(3, 'Rodriguez', 'JR. Santiago', '1988-09-11', 'M', '130-22-3333'),
(4, 'Lopez', 'JR. Benavides', '1985-02-28', 'M', '200-55-6666'),
(5, 'Gonzalez', 'JR. Lima', '1979-12-05', 'M', '250-88-9999'),
(6, 'Ramirez', 'JR. olivos', '1990-01-15', 'M', '270-33-4444');
GO


DECLARE @DeptNo INT = 7
SELECT *
FROM Emp
WHERE Fecha_Alt < '2018-01-01'
  AND Dept_No = @DeptNo;
GO  

---------


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


--------------------------------------------------------------------------------------------------

BEGIN TRANSACTION;
INSERT INTO Dept (Dept_No, DNombre, Loc) VALUES (9, 'DISEÑO', 'Juliaca');
SAVE TRANSACTION Savepoint1;




INSERT INTO Dept (Dept_No, DNombre, Loc) VALUES (10, 'Finance', 'LONDON');
ROLLBACK TRANSACTION Savepoint1;

COMMIT;

SELECT * FROM Dept;

------------------------------------------------------------------------------

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


EXEC InsertEmp @Emp_No = 7, @Apellido = 'Jones', 
    @Oficio = 'Salesman', 
    @Dir = 3, 
    @Fecha_Alt = '2024-06-11', 
    @Salario = 4500.00, 
    @Comision = 500.00, 
    @Dept_No = 004;

-----------------------------------------------------------------------------------------------------------------------------------------

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


EXEC UpdateEmp @Emp_No = 9, @Apellido = 'Jhonathan', 
    @Oficio = 'arqui', 
    @Dir = 7, 
    @Fecha_Alt = '2021-01-11', 
    @Salario = 4300.00, 
    @Comision = 700.00, 
    @Dept_No = 009;

Select * from Emp;

BEGIN TRANSACTION
ROLLBACK;

-------------------------------------------------------------
-------------------------------------------------------------

ALTER PROCEDURE DeleteEmp
    @Apellido NVARCHAR(50)
AS
BEGIN
    UPDATE Emp
    SET Apellido = NULL
    WHERE Apellido = @Apellido;
END;



EXEC DeleteEmp @Apellido = 'Jones';






-------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


ALTER TABLE [dbo].[Emp] ADD CONSTRAINT UQ_Emp_Emp_No UNIQUE (Emp_No)

ALTER TABLE [dbo].[Dept] ADD CONSTRAINT UQ_Dept_Dept_No UNIQUE (Dept_No)

ALTER TABLE [dbo].[Enfermo] ADD CONSTRAINT UQ_Enfermo_Inscripcion UNIQUE (Inscripcion)











---------------------------------------------------------------------
-----------------------------------------------------------------
