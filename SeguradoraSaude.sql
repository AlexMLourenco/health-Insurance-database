CREATE SCHEMA SeguradoraSaude

GO
CREATE TABLE Pessoa
(
    Nome NVARCHAR(50) NOT NULL,
    NIF CHAR(9) NOT NULL UNIQUE,
    Morada VARCHAR(50),
    Idade INT,
    Sexo CHAR(1),
    PRIMARY KEY (NIF)
)

GO
CREATE TABLE Cliente
(

)

GO
CREATE TABLE Medico
(

)

GO
CREATE TABLE Secretaria
(

)

GO
CREATE TABLE Ficha
(

)

GO
CREATE TABLE FichaDoencas
(

)

GO
CREATE TABLE Seguro
(

)

GO
CREATE TABLE Consulta
(

)

GO
CREATE TABLE ClinicaHospitalar
(

)

GO
CREATE TABLE Pagamento
(
    
)