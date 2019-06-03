USE [SeguradoraSaude]
GO

INSERT INTO [SeguradoraSaude].[Pessoa] ([Nome],[NIF] ,[Morada] ,[Idade] ,[Sexo])
     VALUES ('Alexandre Lourenco','15174922','Rua Sao Tiago','22','M')
         
INSERT INTO [SeguradoraSaude].[Pessoa] ([Nome],[NIF] ,[Morada] ,[Idade] ,[Sexo])
     VALUES ('Manuel Augusto','11922355','Rua Tivoli', '61','M')

INSERT INTO [SeguradoraSaude].[Pessoa] ([Nome],[NIF] ,[Morada] ,[Idade] ,[Sexo])
     VALUES ('Ana Lopes','34762323','Avenida da Liberdade','26','F')
GO

INSERT INTO [SeguradoraSaude].[Cliente]
           ([NIFCliente])
     VALUES
           ('15174922')
GO

INSERT INTO [SeguradoraSaude].[ClinicaHospitalar]
           ([NomeClinica]
           ,[Localizacao])
     VALUES
           ('Clinica da Boa Saude','Porto')
GO

INSERT INTO [SeguradoraSaude].[Medico]
           ([NIFMedico]
           ,[Ordenado]
           ,[Especializacao]
           ,[NumClinica])
     VALUES
           ('11922355',2500,'Cardiologia',1)
GO

INSERT INTO [SeguradoraSaude].[Secretaria]
           ([NIFSecretaria]
           ,[Ordenado])
     VALUES
           ('34762323',700)
GO


INSERT INTO [SeguradoraSaude].[Consulta]
           ([dataConsulta]
           ,[hora]
           ,[NIFCliente]
           ,[NIFMedico]
           ,[NumClinica])
     VALUES
           ('2019-05-02','19:00:00','15174922','11922355',1)
           
           
GO

INSERT INTO [SeguradoraSaude].[Pagamento]
           ([RefPagamento]
           ,[MetodoPagamento]
           ,[Codigo]
           ,[Valor]
           ,[DataPagamento]
           ,[NIFSecretaria])
     VALUES
           ('505243456','Numerario','1234','20','2019-05-3','34762323')
GO

INSERT INTO [SeguradoraSaude].[Ficha]
           ([RelatorioDiagnostico]
           ,[ConsultaInternamento]
           ,[NumConsulta]
           ,[NIFCliente]
           ,[RefPagamento])
     VALUES
           ('R','C','1','15174922','505243456')
GO

INSERT INTO [SeguradoraSaude].[FichaDoencas]
           ([ID]
           ,[NIFCliente]
           ,[TipoDoenca]
           ,[Estado]
           ,[DataDiagnostico]
           ,[NumFicha])
     VALUES
           ('1','15174922','Mononucleose','1','2018-06-6',1)
GO

INSERT INTO [SeguradoraSaude].[Seguro]
           ([ID]
           ,[Tipo]
           ,[Cota]
           ,[Carencia]
           ,[DataSeguro])
     VALUES
           ('1','Individual','25','12','2019-03-1')
GO


INSERT INTO [SeguradoraSaude].[ClienteTemSeguro]
           ([NIFCliente]
           ,[ID])
     VALUES
           ('15174922','1')
GO
