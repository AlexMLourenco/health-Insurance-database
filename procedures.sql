--------------------------------CREATE--------------------------------
----------------------------------------------------------------------

-- Create a new client (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].NewClient 
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
CREATE PROCEDURE [SeguradoraSaude].NewDoctor
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
CREATE PROCEDURE [SeguradoraSaude].NewSecretary
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
CREATE PROCEDURE [SeguradoraSaude].NewAppointment
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
CREATE PROCEDURE [SeguradoraSaude].NewInsurance
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
CREATE PROCEDURE SeguradoraSaude.NewDiseasesFile
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
CREATE PROCEDURE [SeguradoraSaude].NewClinic
    @clinicName VARCHAR(30),
    @localization VARCHAR(30)
AS
BEGIN
    INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
    VALUES (@clinicName, @localization);
END
-- Create File
GO
CREATE PROCEDURE [SeguradoraSaude].NewFile
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
CREATE PROCEDURE SeguradoraSaude.NewPayment
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
CREATE PROCEDURE [SeguradoraSaude].UpdateUserInfo
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
CREATE PROCEDURE [SeguradoraSaude].UpdateClinic
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
CREATE PROCEDURE [SeguradoraSaude].UpdateAppointment
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
CREATE PROCEDURE [SeguradoraSaude].UpdateFile
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
CREATE PROCEDURE [SeguradoraSaude].UpdateInsurence
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
CREATE PROCEDURE [SeguradoraSaude].UpdateDiseaseInfo
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
CREATE PROCEDURE [SeguradoraSaude].DeleteUser @userNIF INT
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
CREATE PROCEDURE [SeguradoraSaude].DeleteAppointment @numAppoint INT
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
CREATE PROCEDURE [SeguradoraSaude].DeleteFile @numFile INT
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
CREATE PROCEDURE [SeguradoraSaude].DeleteDisease @idD INT
AS
    SET NOCOUNT ON;
    IF EXISTS(SELECT * FROM [SeguradoraSaude].FichaDoencas WHERE ID=@idD)
    BEGIN
        DELETE FROM [SeguradoraSaude].FichaDoencas
        WHERE ID=@idD;
    END

-- Delete payment (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].DeletePayment @PayRef INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Pagamento WHERE RefPagamento=@PayRef)
    BEGIN
        DELETE FROM [SeguradoraSaude].Pagamento 
        WHERE RefPagamento=@PayRef;
    END

-- Delete Insurence (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].DeleteInsurence @InsID INT
AS
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Seguro WHERE ID=@InsID)
    BEGIN
        DELETE FROM [SeguradoraSaude].Seguro 
        WHERE ID=@InsID;
    END

-- Delete Clinic (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].DeleteClinic @ClinicNum INT
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
CREATE PROCEDURE [SeguradoraSaude].GetUserList
AS
    SET NOCOUNT ON;
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Pessoa

-- Get clients list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClientList
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Cliente AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF;

-- Get Doctors list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetDoctorList
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Medico AS M
    JOIN [SeguradoraSaude].Pessoa AS P
    ON M.NIFMedico=P.NIF;

-- Get Secretary list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetSecretaryList
AS
    SELECT Nome, NIF
    FROM [SeguradoraSaude].Secretaria AS S
    JOIN [SeguradoraSaude].Pessoa AS P
    ON S.NIFSecretaria=P.NIF;

-- Get clinics list (name and number) (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClinicList
AS
    SET NOCOUNT ON;
    SELECT NomeClinica, NumClinica
    FROM [SeguradoraSaude].ClinicaHospitalar;

-- Get appointments list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetAppointmentList
AS
    SET NOCOUNT ON;
    SELECT C.NumConsulta, C.dataConsulta, C.hora, P.Nome
    FROM [SeguradoraSaude].Consulta AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF;

-- Get insurences list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetInsurenceList
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
CREATE PROCEDURE [SeguradoraSaude].GetFileList
AS
    SET NOCOUNT ON;
    SELECT NumFicha, RelatorioDiagnostico, ConsultaInternamento, NumConsulta, NIFCliente, RefPagamento
    FROM [SeguradoraSaude].Ficha

-- Get diseases list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetDiseasesList
AS
    SET NOCOUNT ON;
    SELECT FD.ID, FD.NIFCliente, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico, FD.NumFicha, P.Nome
    FROM [SeguradoraSaude].FichaDoencas AS FD
    JOIN [SeguradoraSaude].Pessoa AS P
    ON FD.NIFCliente=P.NIF
    
-- Get payments list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetPaymentList
AS
    SET NOCOUNT ON;
    SELECT RefPagamento, MetodoPagamento, Codigo, Valor, DataPagamento
    FROM [SeguradoraSaude].Pagamento

--------------------------------GET DATA------------------------------
----------------------------------------------------------------------

-- Get a client (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClientNIF (@clientNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, C.NumCliente
    FROM [SeguradoraSaude].Cliente AS C
    JOIN [SeguradoraSaude].Pessoa AS P
    ON C.NIFCliente=P.NIF
    WHERE C.NIFCliente=@clientNIF;

-- Get a doctor (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetDoctorNIF (@doctorNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, M.Ordenado, M.Especializacao, M.NumClinica, M.NumMedico
    FROM [SeguradoraSaude].Medico AS M
    JOIN [SeguradoraSaude].Pessoa AS P
    ON M.NIFMedico=P.NIF
    WHERE M.NIFMedico=@doctorNIF;

-- Get a secretary (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetSecretaryNIF (@secretaryNIF INT)
AS
    SELECT P.Nome, P.NIF, P.Morada, P.Idade, P.Sexo, S.Ordenado, S.NumFuncionaria
    FROM [SeguradoraSaude].Secretaria AS S
    JOIN [SeguradoraSaude].Pessoa AS P
    ON S.NIFSecretaria=P.NIF
    WHERE S.NIFSecretaria=@secretaryNIF;

-- Get a clinic (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClinicNum (@clinicNum INT)
AS
    SELECT CL.NomeClinica, CL.Localizacao, CL.NumClinica
    FROM [SeguradoraSaude].ClinicaHospitalar AS CL
    WHERE CL.NumClinica=@clinicNum;

-- Get a appointment (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetAppointNum (@appointNum INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetFileNum (@fileNum INT)
AS
    SELECT F.RelatorioDiagnostico, F.ConsultaInternamento, F.NumConsulta, F.NIFCliente, F.RefPagamento, F.NumFicha
    FROM [SeguradoraSaude].Ficha AS F
    WHERE F.NumFicha=@fileNum;

-- Get a diseases file (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetDiseaseID (@diseaseID INT)
AS
    SELECT FD.NIFCliente, FD.TipoDoenca, FD.Estado, FD.DataDiagnostico, FD.NumFicha, FD.ID
    FROM [SeguradoraSaude].FichaDoencas AS FD
    WHERE FD.ID=@diseaseID;

-- Get a insurence (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetInsurenceID (@insurenceID INT)
AS
    SELECT S.Tipo, S.Cota, S.Carencia, S.DataSeguro, TS.NIFCliente, S.ID
    FROM [SeguradoraSaude].Seguro AS S
    JOIN [SeguradoraSaude].ClienteTemSeguro AS TS
    ON S.ID=TS.ID
    WHERE S.ID=@insurenceID;

-- Get a payment (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetPayRef (@payRef INT)
AS
    SELECT P.MetodoPagamento, P.Codigo, P.Valor, P.DataPagamento, P.NIFSecretaria, P.RefPagamento
    FROM [SeguradoraSaude].Pagamento AS P
    WHERE P.RefPagamento=@payRef;
    
---------------------------------LOGIN--------------------------------
----------------------------------------------------------------------

-- Get type [Client, Doctor or Secretary] for login (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetPersonType @userID INT, @output VARCHAR(15) OUTPUT
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
CREATE PROCEDURE [SeguradoraSaude].GetLoginType @userName VARCHAR(15)
AS
    SET NOCOUNT ON;
    SELECT type 
    FROM [SeguradoraSaude].Login 
    WHERE username=@userName
 
 
-- Get person ID (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetPersonID @userName VARCHAR(15)
AS
    SET NOCOUNT ON;
    SELECT PessoaNIF 
    FROM [SeguradoraSaude].Login 
    WHERE username=@userName
 
-- Get Login (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetLogin @username VARCHAR(15), @password VARCHAR(32)
AS
    SET NOCOUNT ON;
    SELECT * 
    FROM [SeguradoraSaude].Login 
    WHERE username=@username and userpass=@password


------------------------DATABASE (MORE) INFO--------------------------
----------------------------------------------------------------------

-- Get appointment info by ID (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetAppointmentInfoID (@appointmentID INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetAppointmentInfoNIF (@appointmentNIF INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetDiseaseInfoID (@diseaseID INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetDiseaseInfoNIF (@diseaseNIF INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetInsurenceInfoID (@insurenceID INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetInsurenceInfoNIF (@insurenceNIF INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetPaymentInfoNIF (@paymentNIF INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetPaymentInfoSec (@paymentSecretaryNIF INT)
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
CREATE PROCEDURE [SeguradoraSaude].GetDoctorClinicNF (@clinicDoctorNum INT)
AS
    SELECT CH.NomeClinica, CH.Localizacao
    FROM [SeguradoraSaude].ClinicaHospitalar AS CH
    JOIN [SeguradoraSaude].Medico AS M
    ON CH.NumClinica=M.NumClinica
    WHERE M.NumMedico=@clinicDoctorNum;

-- Get a clinic name when its given it's number (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClinic (@clinicNum INT)
AS
    SELECT CH.NomeClinica
    FROM [SeguradoraSaude].ClinicaHospitalar AS CH
    WHERE CH.NumClinica=@clinicNum;