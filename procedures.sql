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


-----------------------------DATABASE INFO----------------------------
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

-- Get a client number when given its NIF (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetClientNIF (@clientNIF INT)
AS
    SELECT C.NumCliente
    FROM [SeguradoraSaude].Cliente AS C
    WHERE C.NIFCliente=@clientNIF;

-- Get a doctor number when given its NIF (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetDoctorNIF (@doctorNIF INT)
AS
    SELECT M.NumMedico
    FROM [SeguradoraSaude].Medico AS M
    WHERE M.NIFMedico=@doctorNIF;

-- Get a secretary number when given its NIF (checked)
GO
CREATE PROCEDURE [SeguradoraSaude].GetSecretaryNIF (@secretaryNIF INT)
AS
    SELECT S.NumFuncionaria
    FROM [SeguradoraSaude].Secretaria AS S
    WHERE S.NIFSecretaria=@secretaryNIF;

/* CREATE A PROCEDURE USING 'PERIODO_CARENCIA' AND 'DATA_DIAGNOSTICO' */