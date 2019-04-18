CREATE SCHEMA SeguradoraSaude

GO
CREATE TABLE Pessoa
(
    Nome    NVARCHAR(50) NOT NULL,
    NIF     INT NOT NULL UNIQUE CHECK (NIF >= 000000000 AND NIF <= 999999999),
    Morada  VARCHAR(50),
    Idade   INT CHECK (Idade > 0),
    Sexo    CHAR(1),
    PRIMARY KEY (NIF)
)

GO
CREATE TABLE Cliente
(
    NIFCliente  INT NOT NULL UNIQUE CHECK (NIFCliente >= 000000000 AND NIFCliente <= 999999999),
    NumCliente  INT NOT NULL CHECK (NumCliente > 0),
    PRIMARY KEY (NIFCliente),
    FOREIGN KEY (NIFCliente) REFERENCES SeguradoraSaude.Pessoa(NIF) ON DELETE CASCADE
)

GO
CREATE TABLE Medico
(
    NIFMedico       INT NOT NULL UNIQUE CHECK (NIFMedico >= 000000000 AND NIFMedico <= 999999999),
    NumMedico       INT NOT NULL CHECK (NumMedico > 0),
    Ordenado        INT CHECK (Ordenado > 600),     -- ordenado minimo
    Especializacao  VARCHAR(30) NOT NULL,
    NumClinica      INT NOT NULL UNIQUE,
    PRIMARY KEY (NIFMedico),
    FOREIGN KEY (NIFMedico) REFERENCES SeguradoraSaude.Pessoa(NIF) ON DELETE CASCADE,
    FOREIGN KEY(NumClinica) REFERENCES SeguradoraSaude.ClinicaHospitalar(NumClinica) ON DELETE CASCADE
)

GO
CREATE TABLE Secretaria
(
    NIFSecretaria   INT NOT NULL UNIQUE CHECK (NIFSecretaria >= 000000000 AND NIFSecretaria <= 999999999),
    NumFuncionaria  INT NOT NULL CHECK (NumFuncionaria > 0),
    Ordenado INT CHECK (Ordenado > 600),        -- ordenado minimo
    PRIMARY KEY (NIFSecretaria),
    FOREIGN KEY (NIFSecretaria) REFERENCES SeguradoraSaude.Pessoa(NIF) ON DELETE CASCADE
)

GO
CREATE TABLE ClinicaHospitalar
(
    NumClinica      INT NOT NULL UNIQUE CHECK (NumClinica > 0),
    NomeClinica     NVARCHAR(50) NOT NULL,
    Localizacao     VARCHAR(50),
    PRIMARY KEY (NumClinica)
)

GO
CREATE TABLE Consulta
(
    NumConsulta     INT NOT NULL UNIQUE CHECK (NumConsulta > 0),
    dataConsulta    DATE NOT NULL,
    hora            HOURS NOT NULL,
    NIFCliente      INT NOT NULL UNIQUE CHECK (NIFCliente >= 000000000 AND NIFCliente <= 999999999),
    NIFMedico       INT NOT NULL UNIQUE CHECK (NIFMedico >= 000000000 AND NIFMedico <= 999999999),
    NumClinica      INT NOT NULL UNIQUE CHECK (NumClinica > 0),
    PRIMARY KEY (NumConsulta),
    FOREIGN KEY(NIFCliente) REFERENCES SeguradoraSaude.Cliente(NIFCliente) ON DELETE CASCADE,
    FOREIGN KEY(NIFMedico) REFERENCES SeguradoraSaude.Medico(NIFMedico) ON DELETE CASCADE,
    FOREIGN KEY(NumClinica) REFERENCES SeguradoraSaude.ClinicaHospitalar(NumClinica) ON DELETE CASCADE
)

GO
CREATE TABLE Pagamento
(
    RefPagamento    INT NOT NULL UNIQUE,
    MetodoPagamento VARCHAR(20),
    Codigo          INT NOT NULL UNIQUE CHECK (Codigo > 0),
    Valor           INT NOT NULL CHECK (Valor > 0),
    DataPagamento   DATE,
    NIFSecretaria   INT NOT NULL UNIQUE CHECK (NIFSecretaria >= 000000000 AND NIFSecretaria <= 999999999),
    PRIMARY KEY (RefPagamento),
    FOREIGN KEY (NIFSecretaria) REFERENCES SeguradoraSaude.Secretaria(NIFSecretaria) ON DELETE CASCADE
)

GO
CREATE TABLE Ficha
(
    NumFicha                INT NOT NULL UNIQUE CHECK (NumFicha > 0),
    RelatorioDiagnostico    CHAR(1) NOT NULL,
    ConsultaInternamento    CHAR(1) NOT NULL,
    NumConsulta             INT NOT NULL UNIQUE CHECK (NumConsulta > 0),
    NIFCliente              INT NOT NULL UNIQUE CHECK (NIFCliente >= 000000000 AND NIFCliente <= 999999999),
    RefPagamento            INT NOT NULL UNIQUE,
    PRIMARY KEY (NumFicha),
    FOREIGN KEY(NIFCliente) REFERENCES SeguradoraSaude.Cliente(NIFCliente) ON DELETE CASCADE,
    FOREIGN KEY (NumConsulta) REFERENCES SeguradoraSaude.Consulta(NumConsulta) ON DELETE CASCADE,
    FOREIGN KEY (RefPagamento) REFERENCES SeguradoraSaude.Pagamento(RefPagamento) ON DELETE CASCADE
)

GO
CREATE TABLE FichaDoencas
(
    ID              INT NOT NULL UNIQUE CHECK (ID > 0),
    NIFCliente      INT NOT NULL UNIQUE CHECK (NIFCliente >= 000000000 AND NIFCliente <= 999999999),
    TipoDoenca      VARCHAR(30) NOT NULL,
    Estado          BOOLEAN NOT NULL,
    DataDiagnostico DATE NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY(NIFCliente) REFERENCES SeguradoraSaude.Cliente(NIFCliente) ON DELETE CASCADE
)

GO
CREATE TABLE Seguro
(
    ID          INT NOT NULL UNIQUE CHECK (ID > 0),
    Tipo        VARCHAR(25) NOT NULL,
    Cota        INT NOT NULL CHECK (Cota > 0),
    Carencia    VARCHAR(30) NOT NULL,   -- meses
    DataSeguro  DATE NOT NULL,
    PRIMARY KEY (ID)
)

GO
-- Relação N para M entre o cliente e o Seguro
CREATE TABLE ClienteTemSeguro
(
    NIFCliente  INT NOT NULL UNIQUE CHECK (NIFCliente >= 000000000 AND NIFCliente <= 999999999),
    ID          INT NOT NULL UNIQUE CHECK (ID > 0),
    PRIMARY KEY (NIFCliente, ID),
    FOREIGN KEY (NIFCliente) REFERENCES SeguradoraSaude.Cliente(NIFCliente) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES SeguradoraSaude.Seguro(ID) ON DELETE CASCADE
)