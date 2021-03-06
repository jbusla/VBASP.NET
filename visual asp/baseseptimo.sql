USE [septimo]
GO
/****** Object:  StoredProcedure [dbo].[prEstudiantes_a]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Abel David Lucas M.>
-- Create date: <Create Date,,18/06/2014 17:41>
-- Description:	<Description,, Inserta registro en la tabla estudiantes>
-- =============================================
CREATE PROCEDURE [dbo].[prEstudiantes_a] 
	-- Add the parameters for the stored procedure here
	@matricula varchar(5)
	,@apellidos varchar(30)
	,@nombres varchar(40)
	,@genero varchar(1)
	,@fechanac date
	,@id int output -- parametro de salida
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		insert into estudiantes(matricula,apellidos,nombres,genero,fechaNac)
		values(@matricula,@apellidos,@nombres,@genero,@fechanac)
		
		set @id=@@ROWCOUNT--filas afectadas en la última operacion
		--o tambien select=@@ROWCOUNT
END

GO
/****** Object:  StoredProcedure [dbo].[prEstudiantes_A2]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		jesus bustos
-- Create date: <Create Date,,>
-- Description:	agrega datos en tabla estudiantes
-- =============================================
CREATE PROCEDURE [dbo].[prEstudiantes_A2]
	-- Add the parameters for the stored procedure here
	@matricula varchar(5),
	@apellidos varchar(30),
	@nombres varchar(30),
	@genero varchar(1),
	@fechaNac date,
	@msg varchar(100) output -- parametro de salida /devuelve valor
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 if exists(select matricula from estudiantes where matricula=@matricula)
	begin
	set @msg='la matricula ya existe. Ingresa otra...'
	end

else
	begin
	insert into estudiantes(matricula,apellidos,nombres,genero,fechaNac)
	values(@matricula,@apellidos,@nombres,@genero,@fechaNac)
	  set @msg='filas agregadas '+ltrim(str(@@ROWCOUNT))
	end
  
END

GO
/****** Object:  StoredProcedure [dbo].[prEstudiantes_listado]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Jesus>
-- Create date: <Create Date,, 03/12/2014>
-- Description:	<Description,,lista los registros de la tabla estudiantes>
-- =============================================
CREATE PROCEDURE [dbo].[prEstudiantes_listado]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT matricula,apellidos,nombres,fechaNac, 
	case 
	when 
	Genero in('M','m') then 'Masculino'
	else 'Femenino'
	end as Sexo
	from estudiantes
	order by apellidos,nombres

	select matricula as [matricula], upper (apellidos + ' ' + nombres) as Estudiantes
	from estudiantes
	order by apellidos,nombres


END

GO
/****** Object:  StoredProcedure [dbo].[prEstudiantes_todos]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prEstudiantes_todos]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT matricula,upper(apellidos) as Apellidos ,upper(nombres) as Nombres ,fechaNac, 
	case 
	when 
	Genero in('M','m') then 'Masculino'
	else 'Femenino'
	end as Sexo
	from estudiantes
	order by apellidos,nombres

	
END

GO
/****** Object:  StoredProcedure [dbo].[prEstudiantes_traerporMatricula]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		jesus
-- Create date: <Create Date,,>
-- Description:	busca registro por el numero de matricula
-- =============================================
CREATE PROCEDURE [dbo].[prEstudiantes_traerporMatricula]
	-- Add the parameters for the stored procedure here
	@matricula varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT matricula,apellidos,nombres,fechaNac,genero
	from estudiantes
	where matricula=@matricula
END

GO
/****** Object:  StoredProcedure [dbo].[prListaEstudiantes]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Francsico Quinionez>
-- Create date: <Create Date,,06/08/2014 16:58>
-- Description:	<Description,,Lista los estudiantes>
-- =============================================
CREATE PROCEDURE [dbo].[prListaEstudiantes]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select distinct 
	apellidos + ' ' + nombres as Estudiante, matricula
	from estudiantes
	order by Estudiante;
END

GO
/****** Object:  StoredProcedure [dbo].[prMateria_a]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Abel David Lucas M.>
-- Create date: <Create Date,,18/06/2014 17:41>
-- Description:	<Description,, Insertar datos en tabla materias>
-- =============================================
CREATE PROCEDURE [dbo].[prMateria_a] 
	-- Add the parameters for the stored procedure here
	@codigo varchar(8)
	,@materia varchar(50)
	,@creditos int
	,@carrera varchar(50)
	,@laboratorio bit
	,@activa bit
	,@fechaCreacion date
	,@id int output -- parametro de salida
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		insert into materias(codigo,materia,creditos,carrera,laboratorio, activa, fechaCreacion)
		values (@codigo,@materia,@creditos,@carrera,@laboratorio,@activa,@fechaCreacion)
   
    set @id=@@ROWCOUNT--filas afectadas en la última operacion
		--o tambien select=@@ROWCOUNT
    
END

GO
/****** Object:  StoredProcedure [dbo].[prMaterias_A2]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prMaterias_A2]
	-- Add the parameters for the stored procedure here
	@codigo varchar(8),
	@materia varchar(50),
	@creditos int,
	@carrera varchar(50),
	@laboratorio bit,
	@activa bit,
	@fechaCreacion date,
	@msg varchar(100) output -- parametro de salida /devuelve valor
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists(select materia from materias where codigo=@codigo)
	begin
	set @msg='la materia ya existe. Ingresa otra...'
	end
else
begin
  insert into materias(codigo,materia,creditos,carrera,laboratorio,activa,fechaCreacion)
  values(@codigo,@materia,@creditos,@carrera,@laboratorio,@activa,@fechaCreacion)
  set @msg='filas agregadas '+ltrim(str(@@ROWCOUNT))
end
END

GO
/****** Object:  StoredProcedure [dbo].[prMaterias_listado]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JEsus Bustos
-- Create date: <Create Date,,>
-- Description:	lista materias
-- =============================================
CREATE PROCEDURE [dbo].[prMaterias_listado]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select materia,creditos,carrera,laboratorio,activa,fechaCreacion
	from materias
	order by materia
END

GO
/****** Object:  StoredProcedure [dbo].[prMaterias_traerporCodigo]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prMaterias_traerporCodigo]
	-- Add the parameters for the stored procedure here
		@codigo varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT materia,creditos,carrera,laboratorio,activa,fechaCreacion
	from materias
	where codigo=@codigo
END

GO
/****** Object:  StoredProcedure [dbo].[prNotas_listado]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		jesus bustos
-- Create date: <Create Date,,>
-- Description:	lsitado de notas
-- =============================================
CREATE PROCEDURE [dbo].[prNotas_listado]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select IdNotas,matricula,codigo,parciales,examen,fechaCreacion
	from notas
	order by codigo
END

GO
/****** Object:  StoredProcedure [dbo].[prUsuarios_A]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<JESUS,BUSTOS>
-- Create date: <Create Date,,>
-- Description:	<AGREGA REGISTROS A LA TABLA USUARIOS>
-- =============================================
CREATE PROCEDURE [dbo].[prUsuarios_A]
	-- Add the parameters for the stored procedure here
	@login	varchar(50),
	@clave	varchar(80),
	@apellidos	varchar(50),
	@nombres	varchar(50),
	@msg varchar(100) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select login from usuarios where login=@login)
	begin
		set @msg='El login Ya Existe...'
		return 0 --abandonar procedimiento
	end 

	insert into usuarios
		values(@login,	@clave,	@apellidos,	@nombres, GETDATE())

		if @@ROWCOUNT > 0
			set @msg='Usuario agregado con éxito'
		else
			set @msg='Error al agregar el usuario'
END

GO
/****** Object:  StoredProcedure [dbo].[prUsurios_valida]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<JESUS BUSTOS>
-- Create date: <Create Date,,>
-- Description:	<VALIDA USUARIO>
-- =============================================
CREATE PROCEDURE [dbo].[prUsurios_valida]
	-- Add the parameters for the stored procedure here
	
	@login	varchar(50),
	@clave	varchar(80),
	@msg varchar(100) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	set @msg=''
	if exists(select login from usuarios where login = @login and clave=@clave)
		set @msg='existe'
END

GO
/****** Object:  Table [dbo].[carreras]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[carreras](
	[idCarrera] [int] NOT NULL,
	[carrera] [varchar](50) NULL,
 CONSTRAINT [PK_carreras] PRIMARY KEY CLUSTERED 
(
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Docente]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Docente](
	[IdDocente] [int] NOT NULL,
	[Cedula] [int] NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Docente] PRIMARY KEY CLUSTERED 
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleados](
	[Cedula] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[Direccion] [varchar](50) NULL,
	[Cargo] [varchar](50) NULL,
	[sexo] [varchar](10) NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[Cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[estudiantes]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[estudiantes](
	[matricula] [varchar](5) NOT NULL,
	[apellidos] [varchar](30) NULL,
	[nombres] [varchar](30) NULL,
	[genero] [varchar](1) NULL,
	[fechaNac] [date] NULL,
	[idCarrera] [int] NULL,
 CONSTRAINT [PK_estudiantes] PRIMARY KEY CLUSTERED 
(
	[matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[materias]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[materias](
	[codigo] [varchar](8) NOT NULL,
	[materia] [varchar](50) NULL,
	[creditos] [int] NULL,
	[carrera] [varchar](50) NULL,
	[laboratorio] [bit] NULL,
	[activa] [bit] NULL,
	[fechaCreacion] [date] NULL,
 CONSTRAINT [PK_materias] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[notas]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[notas](
	[IdNotas] [int] IDENTITY(1,1) NOT NULL,
	[matricula] [varchar](5) NULL,
	[codigo] [varchar](8) NULL,
	[parciales] [money] NULL,
	[examen] [money] NULL,
	[fechaCreacion] [date] NULL,
 CONSTRAINT [PK_notas] PRIMARY KEY CLUSTERED 
(
	[IdNotas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Titulos]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Titulos](
	[IdTitulo] [int] NOT NULL,
	[IdDocente] [int] NOT NULL,
	[NombreTitulo] [varchar](50) NULL,
	[FechaGraduacion] [date] NULL,
	[Institucion] [varchar](50) NULL,
 CONSTRAINT [PK_Titulos] PRIMARY KEY CLUSTERED 
(
	[IdTitulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 28/01/2015 16:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuarios](
	[idlogin] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](50) NULL,
	[clave] [varchar](80) NULL,
	[apellidos] [varchar](50) NULL,
	[nombres] [varchar](50) NULL,
	[fechacreaccion] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[estudiantes] ADD  CONSTRAINT [DF_estudiantes_idCarrera]  DEFAULT ((0)) FOR [idCarrera]
GO
