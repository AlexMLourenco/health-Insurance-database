-- Pessoas
INSERT INTO SeguradoraSaude.Pessoa VALUES ('Alexandre Lourenco','15174922','Rua Sao Tiago','22','M');
INSERT INTO SeguradoraSaude.Pessoa VALUES ('Manuel Augusto','11922355','Rua Tivoli', '61','M');
INSERT INTO SeguradoraSaude.Pessoa VALUES ('Ana Lopes','34762323','Avenida da Liberdade','26','F');

-- Clientes
INSERT INTO SeguradoraSaude.Cliente VALUES ('15174922','1');

-- Medicos
INSERT INTO SeguradoraSaude.Medico VALUES ('11922355','1','2500','Cardiologia','200');

-- Secretarias
INSERT INTO SeguradoraSaude.Secretaria VALUES ('34762323','1','700');

-- Clinicas Hospitalares
INSERT INTO SeguradoraSaude.ClinicaHospitalar VALUES ('200','Clinica da Boa Saude','Porto');

-- Consultas
INSERT INTO SeguradoraSaude.Consulta VALUES ('101','2019-05-2','19:00:00','15174922','11922355','200');

-- Pagamentos
INSERT INTO SeguradoraSaude.Pagamento VALUES ('505243456','Numerario','1234','20','2019-05-3','34762323');

-- Fichas
INSERT INTO SeguradoraSaude.Ficha VALUES ('1000','R','C','101','15174922','505243456');

-- Fichas Doencas
INSERT INTO SeguradoraSaude.FichaDoencas VALUES ('1','15174922','Mononucleose','1','2018-06-6');

-- Seguros
INSERT INTO SeguradoraSaude.Seguro VALUES ('1','Individual','25','1','2018-06-6','12','2019-03-1');

-- Relação N para M entre o cliente e o seguro
INSERT INTO SeguradoraSaude.ClienteTemSeguro VALUES ('15174922','1');