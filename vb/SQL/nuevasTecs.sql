create database NUEVASTECS

use NUEVASTECS

use master
drop database NUEVASTECS

CREATE TABLE estudiantes
(
	matricula int identity(1,1) unique not null,
	apellidos varchar(50) not null,
	nombres varchar(50) not null,
	genero char(1) not null,
	fechaNac date not null,
	primary key(matricula)
);


CREATE TABLE materia
(
	codigo int identity(1,1) not null,
	materia varchar(50) not null,
	creditos int not null,
	carrera varchar(50) not null,
	laboratorio bit,
	activa bit,
	fechaCreacion date
	primary key(codigo)
);


CREATE TABLE notas
(
	idNotas int identity(1,1)not null,
	matricula int not null,
	codmat varchar(8) not null,
	parciales money,
	examen money,
	fechaCreacion date,
	primary key(idNotas)
);


create table usuarios 
(
	idUsuario int identity(1, 1) unique not null,
	nombreUsuario varchar(50), 
	clave varchar(150),
	apellidos varchar(50),
	nombres varchar(30),
	fechaCreacion datetime default getdate(),
	primary key(idUsuario)
);


insert into estudiantes(apellidos, nombres, genero, fechaNac)
				values('Salazar Bone', 'Juan', 'm', '1990-7-12'),
					  ('Quiñonez Angulo', 'Federico', 'm', '1998-4-12'),
					  ('Olmedo Sucre', 'Ana', 'f', '1999-12-25')

insert into materia(materia, creditos, carrera, laboratorio, activa, fechaCreacion)
			values( 'Software 2', 5, 'Sistemas', 0, 1, '1999-2-20'),
				  ('Finanzas', 5, 'Contabilidad', 0, 0, '2008-5-25')


insert into notas(matricula, codmat, parciales, examen, fechaCreacion)
			values(2, 1, 1, 20, '2010-10-20'),
				  (2, 2, 1, 17, '2010-11-20'),
				  (3, 2, 1, 11, '2010-9-25')

insert into usuarios(nombreUsuario, clave, apellidos, nombres)
				values('admin', '208512264222772174181102151942010236531331277169151', 'Aministrador', 'Gancoce')


--Procedimientos almacenados

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_listadoEstudiantes
AS
BEGIN
	SET NOCOUNT ON;
	SELECT matricula, apellidos, nombres, fechaNac,
	case 
		when genero in ('M', 'm') then 'Masculino'
	else
		'Femenino'
	end
	as Sexo		
	from estudiantes
	order by apellidos, nombres  

	select matricula as [Matricula], UPPER (apellidos + ' ' + nombres) as Estudiante
	from estudiantes  
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_listadoMaterias
AS
BEGIN
	SET NOCOUNT ON;
	select * from materia
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_listadoNotas
AS
BEGIN
	SET NOCOUNT ON;
	select * from notas 
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_insertarEstudiantes
@apellidos varchar(50),
@nombres varchar(50),
@genero char(1),
@fechaNac date,
@msg varchar(50) output
AS
BEGIN
	
	if exists(select nombres  
			  from estudiantes
			  where nombres=@nombres )
		begin 
			set @msg='El nombre ya existe. Ingrese otro'
		end
	else
		begin 
			insert into estudiantes(apellidos, nombres, genero, fechaNac)
						values(@apellidos, @nombres, @genero, @fechaNac)

			set @msg='Filas afectadas: '+ ltrim(str(@@ROWCOUNT))
		end
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_listadoEstudiantesTodos
AS
BEGIN
	SET NOCOUNT ON;
	SELECT matricula, 
	UPPER(apellidos) as Apellidos, 
	upper(nombres) as Nombres,
	fechaNac,
	case 
		when genero in ('M', 'm') then 'Masculino'
	else
		'Femenino'
	end
	as Sexo		
	from estudiantes
	order by apellidos, nombres   
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_materiasTodas
@creditos int
AS
BEGIN
	select * from materia 
	where creditos=@creditos
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_estudiantesFiltro
@nombres varchar(50)
AS
BEGIN
	select * from estudiantes 
	where nombres like '%'+@nombres+'%'
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE pa_insertarMaterias
@materia varchar(50),
@creditos int,
@carrera varchar(50),
@laboratorio bit,
@activa bit,
@fechaCreacion date,
@msg varchar(50) output
AS
BEGIN
	SET NOCOUNT ON;
	if exists(select creditos  
			  from materia 
			  where creditos=@creditos )
		begin 
			set @msg='El credito ya existe. Ingrese otro'
		end
	else
		begin 
			insert into materia(materia, creditos, carrera, laboratorio, activa, fechaCreacion)
				values(@materia, @creditos, @carrera, @laboratorio, @activa, @fechaCreacion)
	
			set @msg='Filas afectadas: '+ ltrim(str(@@ROWCOUNT))
		end
END
GO

create table carrera
(
	idCarrera int identity(1,1) unique not null,
	carrera varchar(50),
	primary key(idCarrera)
);




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Autor:			Gabriel Cobeña
-- Fecha Creacion:	19/01/2015
-- Descripcion:		Proc. Insertar Usuario
-- =============================================
CREATE PROCEDURE pa_insertarUsuario
@nombreUsuario varchar(50), 
@clave varchar(150),
@apellidos varchar(50),
@nombres varchar(30),
@msg varchar(100) output
AS
BEGIN
	if exists(select nombreUsuario from usuarios
				where nombreUsuario=@nombreUsuario)
				begin
					set @msg='El nombre de usuario ya existe. Pruebe otro'
					return 0		--Abandona procedimiento
				end

	insert into usuarios(nombreUsuario, clave, apellidos, nombres)
				values(@nombreUsuario, @clave, @apellidos, @nombres)

	if @@ROWCOUNT>0
		set @msg='Usuario '+ @nombreUsuario +' agregado con exito'
	else
		set @msg='Error al agregar usuario '+ @nombreUsuario
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Autor:			Gabriel Cobeña
-- Fecha Creacion:	19/01/2015
-- Descripcion:		Proc. Validar Usuario
-- =============================================
CREATE PROCEDURE pa_validarUsuario
@nombreUsuario varchar(50), 
@clave varchar(150),
@msg varchar(100) output
AS
BEGIN
	if exists(select nombreUsuario from usuarios
				where nombreUsuario=@nombreUsuario and
					clave=@clave)
				begin
					set @msg='El nombre de usuario ya existe. Pruebe otro'
				end
END
GO

select nombreUsuario, clave, nombres from usuarios