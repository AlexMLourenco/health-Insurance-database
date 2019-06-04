GO
-- Indexar Clientes pelo NIF (chave única)
CREATE UNIQUE INDEX IxCNIF ON SeguradoraSaude.Cliente(NIFCliente)

GO
-- Indexar Medicos pelo NIF (chave única)
CREATE UNIQUE INDEX IxMNIF ON SeguradoraSaude.Medico(NIFMedico)

GO
-- Indexar Secretarias pelo NIF (chave única)
CREATE UNIQUE INDEX IxSNIF ON SeguradoraSaude.Secretaria(NIFSecretaria)

GO
-- Indexar Clinicas pelo numero de clínica (chave única)
CREATE UNIQUE INDEX IxClinc ON SeguradoraSaude.ClinicaHospitalar(NumClinica)

GO
-- Indexar Pagamentos pela respetiva referencia de pagamento (chave única)
CREATE UNIQUE INDEX IxRefPay ON SeguradoraSaude.Pagamento(RefPagamento)

GO
-- Indexar Seguros pelo numero identificador (chave única)
CREATE UNIQUE INDEX IxIDS ON SeguradoraSaude.Seguro(ID)