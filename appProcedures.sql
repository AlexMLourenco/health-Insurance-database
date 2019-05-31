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
    @sexDoctor CHAR(1)
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

    INSERT INTO [SeguradoraSaude].ClinicaHospitalar ([NomeClinica], [Localizacao])
    VALUES (@clinicName, @clinicLocalization);
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

-- Update Client -- Update Doctor -- Update Secretary
GO
CREATE PROCEDURE [SeguradoraSaude].UpdateUserInfo
    @name           VARCHAR(30),
    @userNIF        INT,
    @address        VARCHAR(30),
    @yearsOld       INT,
    @sex            CHAR(1),
    --@clientNum      INT,
    --@doctorNum      INT,
    --@secretaryNum   INT,
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
            --NumMedico = @doctorNum,
            Ordenado = CAST(@salary AS INT),
            Especializacao = @specialization,
            NumClinica = @clinicNumber
        WHERE NIFMedico=@userNIF;
    END
    IF EXISTS(SELECT * FROM [SeguradoraSaude].Secretaria WHERE NIFSecretaria=@userNIF)
    BEGIN
        UPDATE [SeguradoraSaude].Secretaria
        SET 
            --NumFuncionaria = @secretaryNum,
            Ordenado = CAST(@salary AS INT)
        WHERE NIFSecretaria=@userNIF;
    END

-- Update Clinic
-- Update Appointment
-- Update File
-- Update Insurence

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

-- Delete Client
-- Delete Doctor
-- Delete Secretary
-- Delete Appointment
-- Delete File
-- Delete Disease

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
    SELECT NumConsulta, dataConsulta, hora
    FROM [SeguradoraSaude].Consulta;

-- Get insurences list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetInsurenceList
AS
    SET NOCOUNT ON;
    SELECT ID, Tipo, Cota, Carencia, DataSeguro
    FROM [SeguradoraSaude].Seguro

-- Get files list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetFileList
AS
    SET NOCOUNT ON;
    SELECT NumFicha, RelatorioDiagnostico, ConsultaInternamento, NumConsulta, NIFCliente, RefPagamento
    FROM [SeguradoraSaude].Ficha

-- Get payments list (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetPaymentList
AS
    SET NOCOUNT ON;
    SELECT RefPagamento, MetodoPagamento, Codigo, Valor, DataPagamento
    FROM [SeguradoraSaude].Pagamento