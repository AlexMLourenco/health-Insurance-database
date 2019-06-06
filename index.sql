GO
-- Indexar Pessoas pelo nome
CREATE INDEX IxPNome ON SeguradoraSaude.Pessoa(Nome)

GO
-- Indexar Pessoas pela morada
CREATE UNIQUE INDEX IxPMor ON SeguradoraSaude.Pessoa(Morada)

GO
-- Indexar clínicas por localização
CREATE UNIQUE INDEX IxCLL ON SeguradoraSaude.ClinicaHospitalar(Localizacao)