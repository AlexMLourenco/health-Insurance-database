-- Gets client info (checked)
GO
CREATE FUNCTION [SeguradoraSaude].GetClientInfo (@clientID INT)
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
CREATE FUNCTION [SeguradoraSaude].GetDoctorInfo (@doctorID INT)
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
CREATE FUNCTION [SeguradoraSaude].GetSecretaryInfo (@secretaryID INT)
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