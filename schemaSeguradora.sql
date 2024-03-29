USE [p8g11]
GO
/****** Object:  User [p8g11]    Script Date: 06/06/2019 23:49:02 ******/
CREATE USER [p8g11] FOR LOGIN [p8g11] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p8g11]
GO
/****** Object:  Schema [SeguradoraSaude]    Script Date: 06/06/2019 23:49:02 ******/
CREATE SCHEMA [SeguradoraSaude]
GO
/****** Object:  Table [SeguradoraSaude].[Pessoa]    Script Date: 06/06/2019 23:49:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Pessoa](
	[Nome] [varchar](50) NOT NULL,
	[NIF] [int] NOT NULL,
	[Morada] [varchar](50) NULL,
	[Idade] [int] NULL,
	[Sexo] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[NIF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Cliente]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Cliente](
	[NIFCliente] [int] NOT NULL,
	[NumCliente] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NIFCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [SeguradoraSaude].[GetClientInfo]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SeguradoraSaude].[GetClientInfo] (@clientID INT)
RETURNS TABLE
AS
    RETURN
    (
        SELECT P.Nome, P.Morada, P.Idade, P.Sexo, C.NumCliente
        FROM [SeguradoraSaude].Pessoa AS P
        JOIN [SeguradoraSaude].Cliente AS C
        ON P.NIF=C.NIFCliente
        WHERE P.NIF=@clientID
    );
 
-- Gets Doctor info (checked)
GO
/****** Object:  Table [SeguradoraSaude].[Medico]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Medico](
	[NIFMedico] [int] NOT NULL,
	[NumMedico] [int] IDENTITY(1,1) NOT NULL,
	[Ordenado] [int] NULL,
	[Especializacao] [varchar](30) NOT NULL,
	[NumClinica] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NIFMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [SeguradoraSaude].[GetDoctorInfo]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SeguradoraSaude].[GetDoctorInfo] (@doctorID INT)
RETURNS TABLE
AS
    RETURN
    (
        SELECT P.Nome, P.Morada, P.Idade, P.Sexo, M.NumMedico, M.Ordenado, M.Especializacao, M.NumClinica
        FROM [SeguradoraSaude].Pessoa AS P
        JOIN [SeguradoraSaude].Medico AS M
        ON P.NIF=M.NIFMedico
        WHERE P.NIF=@doctorID
    );
 
-- Gets Secretary info (checked)
GO
/****** Object:  Table [SeguradoraSaude].[Secretaria]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Secretaria](
	[NIFSecretaria] [int] NOT NULL,
	[NumFuncionaria] [int] IDENTITY(1,1) NOT NULL,
	[Ordenado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NIFSecretaria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [SeguradoraSaude].[GetSecretaryInfo]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SeguradoraSaude].[GetSecretaryInfo] (@secretaryID INT)
RETURNS TABLE
AS
    RETURN
    (
        SELECT P.Nome, P.Morada, P.Idade, P.Sexo, S.NumFuncionaria, S.Ordenado
        FROM [SeguradoraSaude].Pessoa AS P
        JOIN [SeguradoraSaude].Secretaria AS S
        ON P.NIF=S.NIFSecretaria
        WHERE P.NIF=@secretaryID
    );
GO
/****** Object:  Table [SeguradoraSaude].[ClienteTemSeguro]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[ClienteTemSeguro](
	[NIFCliente] [int] NOT NULL,
	[ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NIFCliente] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[ClinicaHospitalar]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[ClinicaHospitalar](
	[NumClinica] [int] IDENTITY(1,1) NOT NULL,
	[NomeClinica] [nvarchar](50) NOT NULL,
	[Localizacao] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[NumClinica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Consulta]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Consulta](
	[NumConsulta] [int] IDENTITY(1,1) NOT NULL,
	[dataConsulta] [date] NOT NULL,
	[hora] [time](7) NOT NULL,
	[NIFCliente] [int] NOT NULL,
	[NIFMedico] [int] NOT NULL,
	[NumClinica] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Ficha]    Script Date: 06/06/2019 23:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Ficha](
	[NumFicha] [int] IDENTITY(1,1) NOT NULL,
	[RelatorioDiagnostico] [char](1) NOT NULL,
	[ConsultaInternamento] [char](1) NOT NULL,
	[NumConsulta] [int] NOT NULL,
	[NIFCliente] [int] NOT NULL,
	[RefPagamento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumFicha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[FichaDoencas]    Script Date: 06/06/2019 23:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[FichaDoencas](
	[ID] [int] NOT NULL,
	[NIFCliente] [int] NOT NULL,
	[TipoDoenca] [varchar](30) NOT NULL,
	[Estado] [bit] NOT NULL,
	[DataDiagnostico] [date] NOT NULL,
	[NumFicha] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Login]    Script Date: 06/06/2019 23:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Login](
	[ID] [int] NOT NULL,
	[PessoaNIF] [int] NULL,
	[username] [varchar](15) NOT NULL,
	[userpass] [varchar](32) NOT NULL,
	[type] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Pagamento]    Script Date: 06/06/2019 23:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Pagamento](
	[RefPagamento] [int] NOT NULL,
	[MetodoPagamento] [varchar](20) NULL,
	[Codigo] [int] NOT NULL,
	[Valor] [int] NOT NULL,
	[DataPagamento] [date] NULL,
	[NIFSecretaria] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RefPagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SeguradoraSaude].[Seguro]    Script Date: 06/06/2019 23:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SeguradoraSaude].[Seguro](
	[ID] [int] NOT NULL,
	[Tipo] [varchar](25) NOT NULL,
	[Cota] [int] NOT NULL,
	[Carencia] [varchar](30) NOT NULL,
	[DataSeguro] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [SeguradoraSaude].[Cliente] ON 

INSERT [SeguradoraSaude].[Cliente] ([NIFCliente], [NumCliente]) VALUES (15174922, 1)
SET IDENTITY_INSERT [SeguradoraSaude].[Cliente] OFF
INSERT [SeguradoraSaude].[ClienteTemSeguro] ([NIFCliente], [ID]) VALUES (15174922, 1)
SET IDENTITY_INSERT [SeguradoraSaude].[ClinicaHospitalar] ON 

INSERT [SeguradoraSaude].[ClinicaHospitalar] ([NumClinica], [NomeClinica], [Localizacao]) VALUES (1, N'Clinica da Boa Saude', N'Porto')
SET IDENTITY_INSERT [SeguradoraSaude].[ClinicaHospitalar] OFF
SET IDENTITY_INSERT [SeguradoraSaude].[Consulta] ON 

INSERT [SeguradoraSaude].[Consulta] ([NumConsulta], [dataConsulta], [hora], [NIFCliente], [NIFMedico], [NumClinica]) VALUES (1, CAST(N'2019-05-02' AS Date), CAST(N'19:00:00' AS Time), 15174922, 11922355, 1)
SET IDENTITY_INSERT [SeguradoraSaude].[Consulta] OFF
SET IDENTITY_INSERT [SeguradoraSaude].[Medico] ON 

INSERT [SeguradoraSaude].[Medico] ([NIFMedico], [NumMedico], [Ordenado], [Especializacao], [NumClinica]) VALUES (11922355, 1, 2500, N'Cardiologia', 1)
SET IDENTITY_INSERT [SeguradoraSaude].[Medico] OFF
INSERT [SeguradoraSaude].[Pessoa] ([Nome], [NIF], [Morada], [Idade], [Sexo]) VALUES (N'Manuel Augusto', 11922355, N'Rua Tivoli', 61, N'M')
INSERT [SeguradoraSaude].[Pessoa] ([Nome], [NIF], [Morada], [Idade], [Sexo]) VALUES (N'Alexandre Lourenco', 15174922, N'Rua Sao Tiago', 22, N'M')
INSERT [SeguradoraSaude].[Pessoa] ([Nome], [NIF], [Morada], [Idade], [Sexo]) VALUES (N'Ana Lopes', 34762323, N'Avenida da Liberdade', 26, N'F')
SET IDENTITY_INSERT [SeguradoraSaude].[Secretaria] ON 

INSERT [SeguradoraSaude].[Secretaria] ([NIFSecretaria], [NumFuncionaria], [Ordenado]) VALUES (34762323, 1, 700)
SET IDENTITY_INSERT [SeguradoraSaude].[Secretaria] OFF
INSERT [SeguradoraSaude].[Seguro] ([ID], [Tipo], [Cota], [Carencia], [DataSeguro]) VALUES (1, N'Individual', 25, N'12', CAST(N'2019-03-01' AS Date))
/****** Object:  Index [UQ__Cliente__42E0FD55F8205441]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Cliente] ADD UNIQUE NONCLUSTERED 
(
	[NIFCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ClienteT__3214EC262EF532BC]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ClienteT__42E0FD55E04700EC]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro] ADD UNIQUE NONCLUSTERED 
(
	[NIFCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IxCLL]    Script Date: 06/06/2019 23:49:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IxCLL] ON [SeguradoraSaude].[ClinicaHospitalar]
(
	[Localizacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__FichaDoe__3214EC26050FE14B]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[FichaDoencas] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__FichaDoe__883BA5C8E3ABDE73]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[FichaDoencas] ADD UNIQUE NONCLUSTERED 
(
	[NumFicha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Medico__26E5DAFF809B1E0C]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Medico] ADD UNIQUE NONCLUSTERED 
(
	[NIFMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Pagament__06370DAC6D55DC8A]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Pagamento] ADD UNIQUE NONCLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Pagament__5BA301D5822E1C9B]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Pagamento] ADD UNIQUE NONCLUSTERED 
(
	[RefPagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Pessoa__C7DEC330F4A942AD]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Pessoa] ADD UNIQUE NONCLUSTERED 
(
	[NIF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IxPMor]    Script Date: 06/06/2019 23:49:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IxPMor] ON [SeguradoraSaude].[Pessoa]
(
	[Morada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IxPNome]    Script Date: 06/06/2019 23:49:05 ******/
CREATE NONCLUSTERED INDEX [IxPNome] ON [SeguradoraSaude].[Pessoa]
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Secretar__EDE892EE35AD1FBA]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Secretaria] ADD UNIQUE NONCLUSTERED 
(
	[NIFSecretaria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Seguro__3214EC2654FD0463]    Script Date: 06/06/2019 23:49:05 ******/
ALTER TABLE [SeguradoraSaude].[Seguro] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [SeguradoraSaude].[Cliente]  WITH CHECK ADD FOREIGN KEY([NIFCliente])
REFERENCES [SeguradoraSaude].[Pessoa] ([NIF])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro]  WITH CHECK ADD FOREIGN KEY([NIFCliente])
REFERENCES [SeguradoraSaude].[Cliente] ([NIFCliente])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [SeguradoraSaude].[Seguro] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD FOREIGN KEY([NIFCliente])
REFERENCES [SeguradoraSaude].[Cliente] ([NIFCliente])
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD FOREIGN KEY([NIFMedico])
REFERENCES [SeguradoraSaude].[Medico] ([NIFMedico])
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD FOREIGN KEY([NumClinica])
REFERENCES [SeguradoraSaude].[ClinicaHospitalar] ([NumClinica])
GO
ALTER TABLE [SeguradoraSaude].[Ficha]  WITH CHECK ADD FOREIGN KEY([NIFCliente])
REFERENCES [SeguradoraSaude].[Cliente] ([NIFCliente])
GO
ALTER TABLE [SeguradoraSaude].[Ficha]  WITH CHECK ADD FOREIGN KEY([NumConsulta])
REFERENCES [SeguradoraSaude].[Consulta] ([NumConsulta])
GO
ALTER TABLE [SeguradoraSaude].[Ficha]  WITH CHECK ADD FOREIGN KEY([RefPagamento])
REFERENCES [SeguradoraSaude].[Pagamento] ([RefPagamento])
GO
ALTER TABLE [SeguradoraSaude].[FichaDoencas]  WITH CHECK ADD FOREIGN KEY([NIFCliente])
REFERENCES [SeguradoraSaude].[Cliente] ([NIFCliente])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[FichaDoencas]  WITH CHECK ADD FOREIGN KEY([NumFicha])
REFERENCES [SeguradoraSaude].[Ficha] ([NumFicha])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Login]  WITH CHECK ADD FOREIGN KEY([PessoaNIF])
REFERENCES [SeguradoraSaude].[Pessoa] ([NIF])
GO
ALTER TABLE [SeguradoraSaude].[Medico]  WITH CHECK ADD FOREIGN KEY([NIFMedico])
REFERENCES [SeguradoraSaude].[Pessoa] ([NIF])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Medico]  WITH CHECK ADD FOREIGN KEY([NumClinica])
REFERENCES [SeguradoraSaude].[ClinicaHospitalar] ([NumClinica])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Pagamento]  WITH CHECK ADD FOREIGN KEY([NIFSecretaria])
REFERENCES [SeguradoraSaude].[Secretaria] ([NIFSecretaria])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Secretaria]  WITH CHECK ADD FOREIGN KEY([NIFSecretaria])
REFERENCES [SeguradoraSaude].[Pessoa] ([NIF])
ON DELETE CASCADE
GO
ALTER TABLE [SeguradoraSaude].[Cliente]  WITH CHECK ADD CHECK  (([NIFCliente]>=(0) AND [NIFCliente]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro]  WITH CHECK ADD CHECK  (([NIFCliente]>=(0) AND [NIFCliente]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[ClienteTemSeguro]  WITH CHECK ADD CHECK  (([ID]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD CHECK  (([NIFCliente]>=(0) AND [NIFCliente]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD CHECK  (([NIFMedico]>=(0) AND [NIFMedico]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Consulta]  WITH CHECK ADD CHECK  (([NumClinica]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Ficha]  WITH CHECK ADD CHECK  (([NIFCliente]>=(0) AND [NIFCliente]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Ficha]  WITH CHECK ADD CHECK  (([NumConsulta]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[FichaDoencas]  WITH CHECK ADD CHECK  (([NIFCliente]>=(0) AND [NIFCliente]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[FichaDoencas]  WITH CHECK ADD CHECK  (([NumFicha]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[FichaDoencas]  WITH CHECK ADD CHECK  (([ID]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Medico]  WITH CHECK ADD CHECK  (([NIFMedico]>=(0) AND [NIFMedico]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Medico]  WITH CHECK ADD CHECK  (([Ordenado]>(600)))
GO
ALTER TABLE [SeguradoraSaude].[Pagamento]  WITH CHECK ADD CHECK  (([Codigo]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Pagamento]  WITH CHECK ADD CHECK  (([NIFSecretaria]>=(0) AND [NIFSecretaria]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Pagamento]  WITH CHECK ADD CHECK  (([Valor]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Pessoa]  WITH CHECK ADD CHECK  (([Idade]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Pessoa]  WITH CHECK ADD CHECK  (([NIF]>=(0) AND [NIF]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Secretaria]  WITH CHECK ADD CHECK  (([NIFSecretaria]>=(0) AND [NIFSecretaria]<=(999999999)))
GO
ALTER TABLE [SeguradoraSaude].[Secretaria]  WITH CHECK ADD CHECK  (([Ordenado]>(600)))
GO
ALTER TABLE [SeguradoraSaude].[Seguro]  WITH CHECK ADD CHECK  (([Cota]>(0)))
GO
ALTER TABLE [SeguradoraSaude].[Seguro]  WITH CHECK ADD CHECK  (([ID]>(0)))
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteAppointment]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteAppointment] @numAppoint INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Consulta WHERE NumConsulta=@numAppoint)
    BEGIN
        DELETE FROM [SeguradoraSaude].Consulta
        WHERE NumConsulta=@numAppoint;
    END
    
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Ficha WHERE NumConsulta=@numAppoint)
    BEGIN
        DELETE FROM [SeguradoraSaude].Ficha
        WHERE NumConsulta=@numAppoint;
    END

-- Delete File
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteClinic]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteClinic] @ClinicNum INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].ClinicaHospitalar WHERE NumClinica=@ClinicNum)
    BEGIN
        DELETE FROM [SeguradoraSaude].ClinicaHospitalar 
        WHERE NumClinica=@ClinicNum;
    END

--------------------------------LISTS---------------------------------
----------------------------------------------------------------------

-- Get users list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteDisease]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteDisease] @idD INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE ID=@idD)
    BEGIN
        DELETE FROM [SeguradoraSaude].FichaDoencas
        WHERE ID=@idD;
    END

-- Delete payment (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteFile]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteFile] @numFile INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Ficha WHERE NumFicha=@numFile)
    BEGIN
        DELETE FROM [SeguradoraSaude].Ficha
        WHERE NumFicha=@numFile;
    END
    
    IF EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE NumFicha=@numFile)
    BEGIN
        DELETE FROM [SeguradoraSaude].FichaDoencas
        WHERE NumFicha=@numFile;
    END

-- Delete Disease
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteInsurence]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteInsurence] @InsID INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Seguro WHERE ID=@InsID)
    BEGIN
        DELETE FROM [SeguradoraSaude].Seguro 
        WHERE ID=@InsID;
    END

-- Delete Clinic (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeletePayment]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeletePayment] @PayRef INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Pagamento WHERE RefPagamento=@PayRef)
    BEGIN
        DELETE FROM [SeguradoraSaude].Pagamento 
        WHERE RefPagamento=@PayRef;
    END

-- Delete Insurence (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[DeleteUser]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[DeleteUser] @userNIF INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Consulta WHERE NIFCliente=@userNIF OR NIFMedico=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Consulta
        WHERE NIFCliente=@userNIF;
        DELETE FROM [SeguradoraSaude].Consulta
        WHERE NIFMedico=@userNIF;
    END
    
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Pessoa
        WHERE NIF=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].Cliente WHERE NIFCliente=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Cliente
        WHERE NIFCliente=@userNIF;
    END
    
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Medico WHERE NIFMedico=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Medico
        WHERE NIFMedico=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].Secretaria WHERE NIFSecretaria=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Secretaria
        WHERE NIFSecretaria=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].Pagamento WHERE NIFSecretaria=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Pagamento
        WHERE NIFSecretaria=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].Ficha WHERE NIFCliente=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].Ficha
        WHERE NIFCliente=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE NIFCliente=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].FichaDoencas
        WHERE NIFCliente=@userNIF;
    END

    IF EXISTS(SELECT * FROM [SeguradoraSaude].ClienteTemSeguro WHERE NIFCliente=@userNIF)
    BEGIN
        DELETE FROM [SeguradoraSaude].ClienteTemSeguro
        WHERE NIFCliente=@userNIF;
    END

-- Delete Appointment
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetAppointmentInfoID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetAppointmentInfoID] (@appointmentID INT)
AS
    SELECT dataConsulta, hora, P1.Nome, P2.Nome, CH.NomeClinica
    FROM [SeguradoraSaude].Consulta AS CST
    JOIN [SeguradoraSaude].Cliente AS C
    ON CST.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Medico AS M
    ON CST.NIFMedico=M.NIFMedico
    JOIN [SeguradoraSaude].ClinicaHospitalar AS CH
    ON CST.NumClinica=CH.NumClinica
    JOIN [SeguradoraSaude].Pessoa AS P1
    ON CST.NIFMedico=P1.NIF
    JOIN [SeguradoraSaude].Pessoa AS P2
    ON  CST.NIFCliente=P2.NIF
    WHERE CST.NumConsulta=@appointmentID;

-- Get appointment info by NIF (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetAppointmentInfoNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetAppointmentInfoNIF] (@appointmentNIF INT)
AS
    SELECT dataConsulta, hora, P1.Nome, P2.Nome, CH.NomeClinica
    FROM [SeguradoraSaude].Consulta AS CST
    JOIN [SeguradoraSaude].Cliente AS C
    ON CST.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Medico AS M
    ON CST.NIFMedico=M.NIFMedico
    JOIN [SeguradoraSaude].ClinicaHospitalar AS CH
    ON CST.NumClinica=CH.NumClinica
    JOIN [SeguradoraSaude].Pessoa AS P1
    ON CST.NIFMedico=P1.NIF
    JOIN [SeguradoraSaude].Pessoa AS P2
    ON  CST.NIFCliente=P2.NIF
    WHERE CST.NIFCliente=@appointmentNIF;


-- Get disease file info by ID (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetAppointmentList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetAppointmentList]
AS
    SET NOCOUNT ON;
    SELECT C.NumConsulta, C.dataConsulta, C.hora, P.Nome
    FROM [SeguradoraSaude].Consulta AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF;

-- Get insurences list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetAppointNum]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetAppointNum] (@appointNum INT)
AS
    SELECT C.dataConsulta, C.hora, C.NIFCliente, C.NIFMedico, C.NumClinica, C.NumConsulta, PC.Nome, PM.Nome
    FROM [SeguradoraSaude].Consulta AS C
    JOIN [SeguradoraSaude].Pessoa AS PC
    ON C.NIFCliente=PC.NIF
    JOIN [SeguradoraSaude].Pessoa AS PM
    ON C.NIFMedico=PM.NIF
    WHERE C.NumConsulta=@appointNum;

-- Get a file (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetClientList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetClientList]
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Cliente AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF;

-- Get Doctors list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetClientNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetClientNIF] (@clientNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, C.NumCliente
    FROM [SeguradoraSaude].Cliente AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE C.NIFCliente=@clientNIF;

-- Get a doctor (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetClinic]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetClinic] (@clinicNum INT)
AS
    SELECT CH.NomeClinica
    FROM [SeguradoraSaude].ClinicaHospitalar AS CH
    WHERE CH.NumClinica=@clinicNum;
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetClinicList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetClinicList]
AS
    SET NOCOUNT ON;
    SELECT NomeClinica, NumClinica
    FROM [SeguradoraSaude].ClinicaHospitalar;

-- Get appointments list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetClinicNum]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetClinicNum] (@clinicNum INT)
AS
    SELECT CL.NomeClinica, CL.Localizacao, CL.NumClinica
    FROM [SeguradoraSaude].ClinicaHospitalar AS CL
    WHERE CL.NumClinica=@clinicNum;

-- Get a appointment (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDiseaseID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDiseaseID] (@diseaseID INT)
AS
    SELECT FD.NIFCliente, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico, FD.NumFicha, FD.ID
    FROM [SeguradoraSaude].FichaDoencas AS FD
    WHERE FD.ID=@diseaseID;

-- Get a insurence (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDiseaseInfoID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDiseaseInfoID] (@diseaseID INT)
AS
    SELECT P.Nome, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico
    FROM [SeguradoraSaude].FichaDoencas AS FD
    JOIN [SeguradoraSaude].Cliente AS C
    ON FD.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE FD.ID=@diseaseID;

-- Get disease file info client by NIF (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDiseaseInfoNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDiseaseInfoNIF] (@diseaseNIF INT)
AS
    SELECT P.Nome, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico
    FROM [SeguradoraSaude].FichaDoencas AS FD
    JOIN [SeguradoraSaude].Cliente AS C
    ON FD.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE FD.NIFCliente=@diseaseNIF;

-- Get insurance info by ID (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDiseasesList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDiseasesList]
AS
    SET NOCOUNT ON;
    SELECT FD.ID, FD.NIFCliente, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico, FD.NumFicha, P.Nome
    FROM [SeguradoraSaude].FichaDoencas AS FD
    JOIN [SeguradoraSaude].Pessoa AS P
    ON FD.NIFCliente=P.NIF
    
-- Get payments list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDoctorClinicNF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDoctorClinicNF] (@clinicDoctorNum INT)
AS
    SELECT CH.NomeClinica, CH.Localizacao
    FROM [SeguradoraSaude].ClinicaHospitalar AS CH
    JOIN [SeguradoraSaude].Medico AS M
    ON CH.NumClinica=M.NumClinica
    WHERE M.NumMedico=@clinicDoctorNum;

-- Get a clinic name when its given it's number (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDoctorList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDoctorList]
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Medico AS M
    JOIN [SeguradoraSaude].Pessoa AS P
    ON M.NIFMedico=P.NIF;

-- Get Secretary list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetDoctorNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetDoctorNIF] (@doctorNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, M.Ordenado, M.Especializacao, M.NumClinica, M.NumMedico
    FROM [SeguradoraSaude].Medico AS M
    JOIN [SeguradoraSaude].Pessoa AS P
    ON M.NIFMedico=P.NIF
    WHERE M.NIFMedico=@doctorNIF;

-- Get a secretary (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetFileList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetFileList]
AS
    SET NOCOUNT ON;
    SELECT NumFicha, RelatorioDiagnostico, ConsultaInternamento, NumConsulta, NIFCliente, RefPagamento
    FROM [SeguradoraSaude].Ficha

-- Get diseases list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetFileNum]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetFileNum] (@fileNum INT)
AS
    SELECT F.RelatorioDiagnostico, F.ConsultaInternamento, F.NumConsulta, F.NIFCliente, F.RefPagamento, F.NumFicha
    FROM [SeguradoraSaude].Ficha AS F
    WHERE F.NumFicha=@fileNum;

-- Get a diseases file (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetInsurenceID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetInsurenceID] (@insurenceID INT)
AS
    SELECT S.Tipo, S.Cota, S.Carencia, S.DataSeguro, TS.NIFCliente, S.ID
    FROM [SeguradoraSaude].Seguro AS S
    JOIN [SeguradoraSaude].ClienteTemSeguro AS TS
    ON S.ID=TS.ID
    WHERE S.ID=@insurenceID;

-- Get a payment (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetInsurenceInfoID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetInsurenceInfoID] (@insurenceID INT)
AS
    SELECT P.Nome, S.Tipo, S.Cota, S.Carencia, S.DataSeguro
    FROM [SeguradoraSaude].Seguro AS S
    JOIN [SeguradoraSaude].ClienteTemSeguro AS TS
    ON S.ID=TS.ID
    JOIN [SeguradoraSaude].Cliente AS C
    ON TS.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE S.ID=@insurenceID;

-- Get insurance info by NIF (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetInsurenceInfoNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetInsurenceInfoNIF] (@insurenceNIF INT)
AS
    SELECT P.Nome, S.Tipo, S.Cota, S.Carencia, S.DataSeguro
    FROM [SeguradoraSaude].Seguro AS S
    JOIN [SeguradoraSaude].ClienteTemSeguro AS TS
    ON S.ID=TS.ID
    JOIN [SeguradoraSaude].Cliente AS C
    ON TS.NIFCliente=C.NIFCliente
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE TS.NIFCliente=@insurenceNIF;

-- Get payment info by NIF (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetInsurenceList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetInsurenceList]
AS
    SET NOCOUNT ON;
    SELECT S.Tipo, S.Cota, S.Carencia, S.DataSeguro, TS.NIFCliente, S.ID, P.Nome
    FROM [SeguradoraSaude].Seguro AS S
    JOIN [SeguradoraSaude].ClienteTemSeguro AS TS
    ON S.ID=TS.ID 
    JOIN [SeguradoraSaude].Pessoa AS P
    ON TS.NIFCliente=P.NIF

-- Get files list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetLogin]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetLogin] @username VARCHAR(15), @password VARCHAR(32)
AS
    SET NOCOUNT ON;
    SELECT * 
    FROM [SeguradoraSaude].Login 
    WHERE username=@username and userpass=@password


------------------------DATABASE (MORE) INFO--------------------------
----------------------------------------------------------------------

-- Get appointment info by ID (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetLoginType]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetLoginType] @userName VARCHAR(15)
AS
    SET NOCOUNT ON;
    SELECT type 
    FROM [SeguradoraSaude].Login 
    WHERE username=@userName
 
 
-- Get person ID (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPaymentInfoNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPaymentInfoNIF] (@paymentNIF INT)
AS
    SELECT P.RefPagamento, P.MetodoPagamento, P.Codigo, P.Valor, P.DataPagamento
    FROM [SeguradoraSaude].Pagamento AS P
    JOIN [SeguradoraSaude].Ficha AS F
    ON P.RefPagamento=F.RefPagamento
    JOIN [SeguradoraSaude].Cliente AS C
    ON F.NIFCliente=C.NIFCliente
    WHERE F.NIFCliente=@paymentNIF;

-- Get secretary that processed the payment by NIF (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPaymentInfoSec]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPaymentInfoSec] (@paymentSecretaryNIF INT)
AS
    SELECT PS.Nome, S.NumFuncionaria, P.DataPagamento
    FROM [SeguradoraSaude].Pagamento AS P
    JOIN [SeguradoraSaude].Secretaria AS S
    ON P.NIFSecretaria=S.NIFSecretaria
    JOIN [SeguradoraSaude].Pessoa AS PS
    ON S.NIFSecretaria=PS.NIF
    WHERE P.NIFSecretaria=@paymentSecretaryNIF;

-- Get clinic where a doctor works using NumFunc (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPaymentList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPaymentList]
AS
    SET NOCOUNT ON;
    SELECT RefPagamento, MetodoPagamento, Codigo, Valor, DataPagamento
    FROM [SeguradoraSaude].Pagamento

--------------------------------GET DATA------------------------------
----------------------------------------------------------------------

-- Get a client (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPayRef]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPayRef] (@payRef INT)
AS
    SELECT P.MetodoPagamento, P.Codigo, P.Valor, P.DataPagamento, P.NIFSecretaria, P.RefPagamento
    FROM [SeguradoraSaude].Pagamento AS P
    WHERE P.RefPagamento=@payRef;
    
---------------------------------LOGIN--------------------------------
----------------------------------------------------------------------

-- Get type [Client, Doctor or Secretary] for login (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPersonID]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPersonID] @userName VARCHAR(15)
AS
    SET NOCOUNT ON;
    SELECT PessoaNIF 
    FROM [SeguradoraSaude].Login 
    WHERE username=@userName
 
-- Get Login (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetPersonType]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetPersonType] @userID INT, @output VARCHAR(15) OUTPUT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Cliente WHERE NIFCliente=@userID)
    BEGIN
        SET @output = 'client';
    END
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Medico WHERE NIFMedico=@userID)
    BEGIN
        SET @output = 'doctor';
    END
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Secretaria WHERE NIFSecretaria=@userID)
    BEGIN
        SET @output = 'secretary';
    END

-- Get Login type (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetSecretaryList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetSecretaryList]
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Secretaria AS S
    JOIN [SeguradoraSaude].Pessoa AS P
    ON S.NIFSecretaria=P.NIF;

-- Get clinics list (name and number) (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetSecretaryNIF]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetSecretaryNIF] (@secretaryNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, S.Ordenado, S.NumFuncionaria
    FROM [SeguradoraSaude].Secretaria AS S
    JOIN [SeguradoraSaude].Pessoa AS P
    ON S.NIFSecretaria=P.NIF
    WHERE S.NIFSecretaria=@secretaryNIF;

-- Get a clinic (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[GetUserList]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[GetUserList]
AS
    SET NOCOUNT ON;
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Pessoa

-- Get clients list (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewAppointment]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewAppointment]
    @doctorNIF INT,
    @clientNIF INT,
    @salary VARCHAR(15), 
    @specialization VARCHAR(30), 
    @clinicNumber INT, 
    @clinicName NVARCHAR(50), 
    @clinicLocalization VARCHAR(50), 
    @nameClient VARCHAR(30), 
    @nameDoctor VARCHAR(30), 
    @addressClient VARCHAR(30),
    @addressDoctor VARCHAR(30), 
    @yearsOldClient INT,
    @yearsOldDoctor INT, 
    @sexClient CHAR(1),
    @sexDoctor CHAR(1),
    @dateAppoint   CHAR(10), 
    @hourAppoint   VARCHAR(15)
AS
BEGIN
    IF(@salary < 700)
    BEGIN
        SET @salary = 700
    END
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@nameClient, @clientNIF, @addressClient, @yearsOldClient, @sexClient);
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@nameDoctor, @doctorNIF, @addressDoctor, @yearsOldDoctor, @sexDoctor);
    INSERT INTO [SeguradoraSaude].Cliente VALUES(@clientNIF);
    INSERT INTO [SeguradoraSaude].ClinicaHospitalar VALUES(@clinicName, @clinicLocalization);
    INSERT INTO [SeguradoraSaude].Medico VALUES(@doctorNIF, CAST(@salary AS INT), @specialization, @clinicNumber);
    INSERT INTO [SeguradoraSaude].Consulta ([dataConsulta], [hora], [NIFCliente], [NIFMedico], [NumClinica])
        VALUES(CONVERT(date, @dateAppoint, 105), CAST(@hourAppoint AS TIME), @clientNIF, @doctorNIF, @clinicNumber);
END
-- Create new insurance (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewClient]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewClient] 
    @clientNIF INT,
    @name VARCHAR(30), 
    @address VARCHAR(30), 
    @yearsOld INT, 
    @sex CHAR(1)
AS
BEGIN
    -- how to insert a serial number by default for NumClient? [SOLVED]
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@name, @clientNIF, @address, @yearsOld, @sex);
    INSERT INTO [SeguradoraSaude].Cliente VALUES(@clientNIF);
END
-- Create new doctor (doctor) (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewClinic]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewClinic]
    @clinicName VARCHAR(30),
    @localization VARCHAR(30)
AS
BEGIN
    INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
    VALUES (@clinicName, @localization);
END
-- Create File
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewDiseasesFile]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewDiseasesFile]
    @clientNIF INT,
    @name VARCHAR(30), 
    @address VARCHAR(30),
    @yearsOld INT,
    @sex CHAR(1),
    @idDiseaseFile INT,
    @type VARCHAR(30),
    @state BIT,
    @dateD CHAR(10),
    @numFile INT,
    @rD CHAR(1),
    @cI CHAR(1),
    @numAppoint INT,
    @dateAppoint CHAR(10),
    @hourAppoint VARCHAR(15),
    @doctorNIF INT,
    @nameDoctor VARCHAR(30),
    @addressDoctor VARCHAR(30),
    @yearsOldDoctor INT,
    @sexDoctor CHAR(1),
    @doctorNum INT,
    @salary VARCHAR(15),
    @specialization VARCHAR(30), 
    @clinicNum INT,
    @clinicName NVARCHAR(50), 
    @clinicLocalization VARCHAR(50), 
    @refPay INT,
    @metPay VARCHAR(20),
    @codPay INT,
    @amountPay INT,
    @datePay CHAR(10),
    @secretaryNIF INT,
    @nameSecretary VARCHAR(30),
    @addressSecretary VARCHAR(30),
    @yearsOldSecretary INT,
    @sexSecretary CHAR(1)
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Cliente WHERE NIFCliente=@clientNIF)
    BEGIN
        INSERT INTO SeguradoraSaude.Cliente ([NIFCliente]) 
		VALUES(@clientNIF);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Ficha WHERE NumFicha=@numFile)
    BEGIN
        INSERT INTO SeguradoraSaude.Ficha ([RelatorioDiagnostico], [ConsultaInternamento], [NumConsulta], [NIFCliente], [RefPagamento]) 
		VALUES(@rD, @cI, @numAppoint, @clientNIF, @refPay);
    END
    
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@clientNIF)
    BEGIN
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@name, @clientNIF, @address, @yearsOld, @sex);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Consulta WHERE NumConsulta=@numAppoint)
    BEGIN
        INSERT INTO SeguradoraSaude.Consulta  ([dataConsulta], [hora], [NIFCliente], [NIFMedico], [NumClinica])
		VALUES(CONVERT(date, @dateAppoint, 105), CAST(@hourAppoint AS TIME), @clientNIF, @doctorNIF, @clinicNum);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pagamento WHERE RefPagamento=@refPay)
    BEGIN -- pagamento
        INSERT INTO SeguradoraSaude.Pagamento VALUES(@refPay, @metPay, @codPay, @amountPay, @datePay, @secretaryNIF);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Secretaria WHERE NIFSecretaria=@secretaryNIF)
    BEGIN -- pagamento:secretaria
        INSERT INTO SeguradoraSaude.Secretaria ([NIFSecretaria], [Ordenado])
		VALUES(@secretaryNIF, @salary);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@secretaryNIF)
    BEGIN -- pagamento:secretaria:pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@nameSecretary, @secretaryNIF, @addressSecretary, @yearsOldSecretary, @sexSecretary);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Medico WHERE NIFMedico=@doctorNIF)
    BEGIN -- consulta:medico
        INSERT INTO SeguradoraSaude.Medico ([NIFMedico], [Ordenado], [Especializacao]) 
        VALUES(@doctorNIF, @salary, @specialization);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.ClinicaHospitalar WHERE NumClinica=@clinicNum)
    BEGIN -- consulta:clinica
        INSERT INTO SeguradoraSaude.ClinicaHospitalar VALUES(@clinicName, @clinicLocalization);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@doctorNIF)
    BEGIN -- consulta:medico:pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@nameDoctor, @doctorNIF, @addressDoctor, @yearsOldDoctor, @sexDoctor);
    END

    INSERT INTO SeguradoraSaude.FichaDoencas VALUES(@idDiseaseFile, @clientNIF, @type, @state, @dateD, @numFile);

END
-- Create Clinic
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewDoctor]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewDoctor]
    @doctorNIF INT,
    @salary VARCHAR(15), 
    @specialization VARCHAR(30), 
    @clinicNumber INT, 
    @clinicName NVARCHAR(50), 
    @clinicLocalization VARCHAR(50), 
    @name VARCHAR(30), 
    @address VARCHAR(30), 
    @yearsOld INT, 
    @sex CHAR(1)
AS
BEGIN
    IF(@salary < 700)
    BEGIN
        SET @salary = 700
    END
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@name, @doctorNIF, @address, @yearsOld, @sex);
    INSERT INTO [SeguradoraSaude].Medico VALUES(@doctorNIF, CAST(@salary AS INT), @specialization, @clinicNumber);
    INSERT INTO [SeguradoraSaude].ClinicaHospitalar VALUES(@clinicName, @clinicLocalization);
END
-- Create new secretary (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewFile]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewFile]
    @Rd CHAR(1),
    @Ci CHAR(1),
    @appointmentNumber INT,
    @clientNIF INT,
    @refPay INT,
    @name VARCHAR(30), 
    @address VARCHAR(30),
    @yearsOld INT,
    @sex CHAR(1),
    @dateAppoint CHAR(10),
    @hourAppoint VARCHAR(15),
    @doctorNIF INT,
    @nameDoctor VARCHAR(30),
    @addressDoctor VARCHAR(30),
    @yearsOldDoctor INT,
    @sexDoctor CHAR(1),
    @doctorNum INT,
    @salary VARCHAR(15),
    @specialization VARCHAR(30), 
    @clinicNum INT,
    @clinicName NVARCHAR(50), 
    @clinicLocalization VARCHAR(50),
    @metPay VARCHAR(20),
    @codPay INT,
    @amountPay INT,
    @datePay CHAR(10),
    @secretaryNIF INT,
    @nameSecretary VARCHAR(30),
    @addressSecretary VARCHAR(30),
    @yearsOldSecretary INT,
    @sexSecretary CHAR(1)
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Cliente WHERE NIFCliente=@clientNIF)
    BEGIN -- client
        INSERT INTO SeguradoraSaude.Cliente ([NIFCliente]) 
		VALUES(@clientNIF);
    END
    
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@clientNIF)
    BEGIN -- client:Pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@name, @clientNIF, @address, @yearsOld, @sex);
    END
    
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Consulta WHERE NumConsulta=@appointmentNumber)
    BEGIN -- consulta
        INSERT INTO SeguradoraSaude.Consulta ([dataConsulta], [hora], [NIFCliente], [NIFMedico], [NumClinica])
        VALUES(@dateAppoint, @hourAppoint, @clientNIF, @doctorNIF, @clinicNum);
    END
    
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Cliente WHERE NIFCliente=@clientNIF)
    BEGIN -- doctor
        INSERT INTO SeguradoraSaude.Medico ([NIFMedico], [Ordenado], [Especializacao], [NumClinica]) 
		VALUES(@doctorNIF, @salary, @specialization, @clinicNum);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@doctorNIF)
    BEGIN -- doctor:Pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@nameDoctor, @doctorNIF, @addressDoctor, @yearsOldDoctor, @sexDoctor);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.ClinicaHospitalar WHERE NumClinica=@clinicNum)
    BEGIN -- consulta:clinica
        INSERT INTO SeguradoraSaude.ClinicaHospitalar VALUES(@clinicName, @clinicLocalization);
    END

    INSERT INTO [SeguradoraSaude].Ficha ([RelatorioDiagnostico], [ConsultaInternamento], [NumConsulta], [NIFCliente], [RefPagamento])
    VALUES (@Rd, @Ci, @appointmentNumber, @clientNIF, @refPay);
END
-- Create Payment
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewInsurance]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewInsurance]
    @clientNIF INT,
    @name VARCHAR(30), 
    @address VARCHAR(30),
    @yearsOld INT,
    @sex CHAR(1),
    @idInsurance INT,
    @type VARCHAR(25),
    @fee INT,
    @lack VARCHAR(30),
    @insurenceDate CHAR(10)
AS
BEGIN
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@name, @clientNIF, @address, @yearsOld, @sex);
    INSERT INTO [SeguradoraSaude].Cliente VALUES(@clientNIF);
    INSERT INTO [SeguradoraSaude].Seguro VALUES(@idInsurance, @type, @fee, @lack, CONVERT(date, @insurenceDate, 105));
    INSERT INTO [SeguradoraSaude].ClienteTemSeguro VALUES(@clientNIF, @idInsurance);
END
-- Create new diseases file (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewPayment]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewPayment]
    @salary VARCHAR(15),
    @refPay INT,
    @metPay VARCHAR(20),
    @codPay INT,
    @amountPay INT,
    @datePay CHAR(10),
    @secretaryNIF INT,
    @nameSecretary VARCHAR(30),
    @addressSecretary VARCHAR(30),
    @yearsOldSecretary INT,
    @sexSecretary CHAR(1)
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Secretaria WHERE NIFSecretaria=@secretaryNIF)
    BEGIN -- pagamento:secretaria
        INSERT INTO SeguradoraSaude.Secretaria ([NIFSecretaria], [Ordenado])
		VALUES(@secretaryNIF, @salary);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@secretaryNIF)
    BEGIN -- pagamento:secretaria:pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@nameSecretary, @secretaryNIF, @addressSecretary, @yearsOldSecretary, @sexSecretary);
    END
    
    INSERT INTO SeguradoraSaude.Pagamento ([RefPagamento], [MetodoPagamento], [Codigo], [Valor], [DataPagamento], [NIFSecretaria])
    VALUES(@refPay, @metPay, @codPay, @amountPay, @datePay, @secretaryNIF);
END
--------------------------------UPDATE--------------------------------
----------------------------------------------------------------------

-- Update Client -- Update Doctor -- Update Secretary [correct BD]
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[NewSecretary]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[NewSecretary]
    @secretaryNIF INT,
    @salary VARCHAR(15), 
    @name VARCHAR(30), 
    @address VARCHAR(30), 
    @yearsOld INT, 
    @sex CHAR(1)
AS
BEGIN
    IF(@salary < 700)
    BEGIN
        SET @salary = 700
    END
    INSERT INTO [SeguradoraSaude].Pessoa VALUES (@name, @secretaryNIF, @address, @yearsOld, @sex);
    INSERT INTO [SeguradoraSaude].Secretaria VALUES(@secretaryNIF, CAST(@salary AS INT));
END
-- Create new appointment (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateAppointment]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateAppointment]
    @nameClinic     VARCHAR(30),
    @numClinic      INT,
    @localization   VARCHAR(30),
    @doctorNIF      INT,
    @nameDoctor     VARCHAR(30),
    @addressDoctor  VARCHAR(30),
    @yearsOldDoctor INT,
    @sexDoctor      CHAR(1),
    @clientNIF      INT, 
    @clientNumber   INT,
    @nameClient     VARCHAR(30), 
    @addressClient  VARCHAR(30),
    @yearsOldClient INT,
    @sexClient      CHAR(1),
    @salary VARCHAR(15),
    @specialization VARCHAR(30),
    @numAppointment INT,
    @dateAppoint    CHAR(10),
    @hourAppoint    VARCHAR(15)
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Consulta WHERE NumClinica=@numClinic AND NumConsulta=@numAppointment AND NIFCliente=@clientNIF AND NIFMedico=@doctorNIF)
    BEGIN
        UPDATE [SeguradoraSaude].Consulta
        SET
            dataConsulta = @dateAppoint,
            hora = @hourAppoint,
            NIFCliente = @clientNIF,
            NIFMedico = @doctorNIF,
            NumClinica = @numClinic
        WHERE NumClinica=@numClinic;
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Cliente WHERE NIFCliente=@clientNIF)
    BEGIN -- cliente
        INSERT INTO [SeguradoraSaude].Cliente ([NIFCliente])
        VALUES(@clientNIF);
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@clientNIF)
    BEGIN -- cliente:pessoa
        INSERT INTO [SeguradoraSaude].Pessoa ([Nome], [NIF], [Morada], [Idade], [Sexo])
        VALUES(@nameClient, @clientNIF, @addressClient, @yearsOldClient, @sexClient);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Medico WHERE NIFMedico=@doctorNIF)
    BEGIN -- doctor
        INSERT INTO [SeguradoraSaude].Medico ([NIFMedico], [Ordenado], [Especializacao], [NumClinica])
        VALUES(@doctorNIF, @salary, @specialization, @numClinic);
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@doctorNIF)
    BEGIN -- doctor:pessoa
        INSERT INTO [SeguradoraSaude].Pessoa ([Nome], [NIF], [Morada], [Idade], [Sexo])
        VALUES(@nameDoctor, @doctorNIF, @addressDoctor, @yearsOldDoctor, @sexDoctor);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].ClinicaHospitalar WHERE NumClinica=@numClinic)
    BEGIN -- clinica
        INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
        VALUES(@nameClinic, @localization);
    END

-- Update File
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateClinic]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateClinic]
    @nameClinic     VARCHAR(30),
    @numClinic      INT,
    @localization   VARCHAR(30)
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].ClinicaHospitalar WHERE NumClinica=@numClinic)
    BEGIN
        UPDATE [SeguradoraSaude].ClinicaHospitalar
        SET
            NomeClinica = @nameClinic,
            Localizacao = @localization
        WHERE NumClinica=@numClinic;
    END
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].ClinicaHospitalar WHERE NumClinica=@numClinic)
    BEGIN
        INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
        VALUES(@nameClinic, @localization);
    END

-- Update Appointment
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateDiseaseInfo]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateDiseaseInfo]
    @idFile         INT,
    @clientNIF      INT,
    @type           VARCHAR(30),
    @state          BIT,
    @dateD          VARCHAR(10),
    @fileNum        INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE ID=@idFile AND NIFCliente=@clientNIF AND NumFicha=@fileNum)
    BEGIN
        UPDATE [SeguradoraSaude].FichaDoencas
        SET
            TipoDoenca = @type,
            Estado = @state,
            DataDiagnostico = CONVERT(date, @dateD, 105)
        WHERE ID=@idFile AND NIFCliente=@clientNIF AND NumFicha=@fileNum;
    END
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE ID=@idFile AND NIFCliente=@clientNIF AND NumFicha=@fileNum)
    BEGIN
        INSERT INTO [SeguradoraSaude].FichaDoencas
        VALUES(@idFile, @clientNIF, @type, @state, @dateD, @fileNum);
    END

--------------------------------DELETE--------------------------------
----------------------------------------------------------------------

-- Delete Client -- Delete Doctor -- Delete Secretary
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateFile]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateFile]
    @nameClinic     VARCHAR(30),
    @numClinic      INT,
    @localization   VARCHAR(30),
    @doctorNIF      INT,
    @nameDoctor     VARCHAR(30),
    @addressDoctor  VARCHAR(30),
    @yearsOldDoctor INT,
    @sexDoctor      CHAR(1),
    @clientNIF      INT, 
    @clientNumber   INT,
    @nameClient     VARCHAR(30), 
    @addressClient  VARCHAR(30),
    @yearsOldClient INT,
    @sexClient      CHAR(1),
    @salary         VARCHAR(15),
    @specialization VARCHAR(30),
    @numAppointment INT,
    @dateAppoint    CHAR(10),
    @hourAppoint    VARCHAR(15),
    @rD             CHAR(1),
    @cI             CHAR(1),
    @refPay         INT,
    @metPay         VARCHAR(20),
    @codPay         INT,
    @amountPay      INT,
    @datePay        CHAR(10),
    @numFile        INT,
    @secretaryNIF INT,
    @secretaryNum INT,
    @nameSecretary VARCHAR(30),
    @addressSecretary VARCHAR(30),
    @yearsOldSecretary INT,
    @sexSecretary CHAR(1)
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Ficha WHERE NumFicha=@numFile AND NumConsulta=@numAppointment AND NIFCliente=@clientNIF AND RefPagamento=@refPay)
    BEGIN
        UPDATE [SeguradoraSaude].Ficha
        SET
            RelatorioDiagnostico = @rD,
            ConsultaInternamento = @cI,
            NumConsulta = @numAppointment,
            NIFCliente = @clientNIF,
            RefPagamento = @refPay
        WHERE NumFicha=@numFile;
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Cliente WHERE NIFCliente=@clientNIF)
    BEGIN -- cliente
        INSERT INTO [SeguradoraSaude].Cliente ([NIFCliente])
        VALUES(@clientNIF);
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@clientNIF)
    BEGIN -- cliente:pessoa
        INSERT INTO [SeguradoraSaude].Pessoa ([Nome], [NIF], [Morada], [Idade], [Sexo])
        VALUES(@nameClient, @clientNIF, @addressClient, @yearsOldClient, @sexClient);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Medico WHERE NIFMedico=@doctorNIF)
    BEGIN -- doctor
        INSERT INTO [SeguradoraSaude].Medico ([NIFMedico], [Ordenado], [Especializacao], [NumClinica])
        VALUES(@doctorNIF, @salary, @specialization, @numClinic);
    END
    
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@doctorNIF)
    BEGIN -- doctor:pessoa
        INSERT INTO [SeguradoraSaude].Pessoa ([Nome], [NIF], [Morada], [Idade], [Sexo])
        VALUES(@nameDoctor, @doctorNIF, @addressDoctor, @yearsOldDoctor, @sexDoctor);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].ClinicaHospitalar WHERE NumClinica=@numClinic)
    BEGIN -- clinica
        INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
        VALUES(@nameClinic, @localization);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Consulta WHERE NumConsulta=@numClinic)
    BEGIN -- consulta
        INSERT INTO [SeguradoraSaude].Consulta ([dataConsulta], [hora], [NIFCliente], [NIFMedico], [NumClinica])
        VALUES(CONVERT(date, @dateAppoint, 105), CAST(@hourAppoint AS TIME), @clientNIF, @doctorNIF, @numClinic);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pagamento WHERE RefPagamento=@refPay)
    BEGIN -- pagamento
        INSERT INTO SeguradoraSaude.Pagamento VALUES(@refPay, @metPay, @codPay, @amountPay, @datePay, @secretaryNIF);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Secretaria WHERE NIFSecretaria=@secretaryNIF)
    BEGIN -- pagamento:secretaria
        INSERT INTO SeguradoraSaude.Secretaria VALUES(@secretaryNIF, @secretaryNum);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@secretaryNIF)
    BEGIN -- pagamento:secretaria:pessoa
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@nameSecretary, @secretaryNIF, @addressSecretary, @yearsOldSecretary, @sexSecretary);
    END



-- Update Insurence
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateInsurence]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateInsurence]
    @id             INT,
    @type           VARCHAR(30),
    @amount         INT,
    @lack           VARCHAR(30),
    @dateInsurence  CHAR(10),
    @clientNIF      VARCHAR(30),
    @name           VARCHAR(30), 
    @address        VARCHAR(30),
    @yearsOld       INT,
    @sex            CHAR(1)
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Seguro WHERE ID=@id)
    BEGIN
        UPDATE [SeguradoraSaude].Seguro
        SET
            Tipo = @type,
            Cota = @amount,
            Carencia = @lack,
            DataSeguro = CONVERT(date, @dateInsurence, 105)
        WHERE ID=@id;
    END
    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].Seguro WHERE ID=@id)
    BEGIN
        INSERT INTO [SeguradoraSaude].Seguro ([ID], [Tipo], [Cota], [Carencia], [DataSeguro])
        VALUES(@id, @type, @amount, @lack, @dateInsurence);
    END

    IF NOT EXISTS(SELECT * FROM [SeguradoraSaude].ClienteTemSeguro WHERE ID=@id AND NIFCliente=@clientNIF)
    BEGIN
        INSERT INTO [SeguradoraSaude].ClienteTemSeguro ([NIFCliente], [ID])
        VALUES(@clientNIF, @id);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Cliente WHERE NIFCliente=@clientNIF)
    BEGIN
        INSERT INTO SeguradoraSaude.Cliente ([NIFCliente]) VALUES(@clientNIF);
    END

    IF NOT EXISTS(SELECT * FROM SeguradoraSaude.Pessoa WHERE NIF=@clientNIF)
    BEGIN
        INSERT INTO SeguradoraSaude.Pessoa VALUES(@name, @clientNIF, @address, @yearsOld, @sex);
    END

-- Update Disease file info (checked)
GO
/****** Object:  StoredProcedure [SeguradoraSaude].[UpdateUserInfo]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SeguradoraSaude].[UpdateUserInfo]
    @name           VARCHAR(30),
    @userNIF        INT,
    @address        VARCHAR(30),
    @yearsOld       INT,
    @sex            CHAR(1),
    @salary         VARCHAR(15),
    @specialization VARCHAR(30), 
    @clinicNumber INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Pessoa WHERE NIF=@userNIF)
    BEGIN
        UPDATE [SeguradoraSaude].Pessoa
        SET
            Nome = @name,
            Morada = @address,
            Idade = @yearsOld,
            Sexo = @sex
        WHERE NIF=@userNIF;
    END
    /*
	IF EXISTS(SELECT * FROM [SeguradoraSaude].Cliente WHERE NIFCliente=@userNIF)
    BEGIN
         
        UPDATE [SeguradoraSaude].Cliente
        SET
        WHERE NIFCliente=@userNIF;
    END
	*/
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Medico WHERE NIFMedico=@userNIF)
    BEGIN
        UPDATE [SeguradoraSaude].Medico
        SET
            Ordenado = CAST(@salary AS INT),
            Especializacao = @specialization,
            NumClinica = @clinicNumber
        WHERE NIFMedico=@userNIF;
    END
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Secretaria WHERE NIFSecretaria=@userNIF)
    BEGIN
        UPDATE [SeguradoraSaude].Secretaria
        SET 
            Ordenado = CAST(@salary AS INT)
        WHERE NIFSecretaria=@userNIF;
    END

-- Update Clinic
GO
/****** Object:  Trigger [SeguradoraSaude].[TrgInsurenceCover]    Script Date: 06/06/2019 23:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [SeguradoraSaude].[TrgInsurenceCover] ON [SeguradoraSaude].[Pagamento]
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @refPay INT;
    DECLARE @method INT;
    DECLARE @dataPay DATE;
    DECLARE @dataInsurence DATE;
    DECLARE @value INT;
    DECLARE @NIFClient INT;
    DECLARE @NIFSecre INT;
    DECLARE @carencia INT;
    DECLARE @code INT;
    --SET @currentData = GETDATE();
    
    SELECT @dataPay = DataPagamento -- payment Date
    FROM SeguradoraSaude.Pagamento AS PAY
    WHERE PAY.RefPagamento=@refPAy;
    
    SELECT @dataInsurence = DataSeguro -- insurence Date
    FROM SeguradoraSaude.Seguro AS S
    JOIN SeguradoraSaude.ClienteTemSeguro AS CTS
    ON S.ID=CTS.ID
    WHERE CTS.NIFCliente=@NIFClient;
    
    SELECT @carencia = Carencia -- periodo carencia
    FROM SeguradoraSaude.Seguro AS S
    JOIN SeguradoraSaude.ClienteTemSeguro AS CTS
    ON S.ID=CTS.ID
    WHERE CTS.NIFCliente=@NIFClient;
    
    IF(DATEDIFF(MONTH, @dataPay,@dataInsurence) > @carencia)
    BEGIN
        PRINT 'Despesas pagas na totalidade pelo seguro!';
    END
    
    ELSE

    BEGIN
        PRINT 'O seguro não cobre as despesas médicas!';
        INSERT INTO [SeguradoraSaude].Pagamento ([RefPagamento], [MetodoPagamento], [Codigo], [Valor], [DataPagamento], [NIFSecretaria]) 
        VALUES (@refPay, @method, @code, @value, @dataPay, @NIFSecre);
    END

END
GO
ALTER TABLE [SeguradoraSaude].[Pagamento] ENABLE TRIGGER [TrgInsurenceCover]
GO
