-- Trigger for getting insurece payment
GO
CREATE TRIGGER SeguradoraSaude.TrgInsurenceCover ON SeguradoraSaude.Pagamento
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @refPay INT;
    DECLARE @method INT;
    DECLARE @dataPay DATE;
    DECLARE @dataInsurence DATE;
    DECLARE @value INT;
    DECLARE @NIFClient INT;
    DECLARE @NIFSecre INT;
    DECLARE @carencia INT;
    DECLARE @code INT;
    --SET @currentData = GETDATE();
    
    SELECT @dataPay = DataPagamento -- payment Date
    FROM SeguradoraSaude.Pagamento AS PAY
    WHERE PAY.RefPagamento=@refPAy;
    
    SELECT @dataInsurence = DataSeguro -- insurence Date
    FROM SeguradoraSaude.Seguro AS S
    JOIN SeguradoraSaude.ClienteTemSeguro AS CTS
    ON S.ID=CTS.ID
    WHERE CTS.NIFCliente=@NIFClient;
    
    SELECT @carencia = Carencia -- periodo carencia
    FROM SeguradoraSaude.Seguro AS S
    JOIN SeguradoraSaude.ClienteTemSeguro AS CTS
    ON S.ID=CTS.ID
    WHERE CTS.NIFCliente=@NIFClient;
    
    IF(DATEDIFF(MONTH, @dataPay,@dataInsurence) > @carencia)
    BEGIN
        PRINT 'Despesas pagas na totalidade pelo seguro!';
    END
    
    ELSE

    BEGIN
        PRINT 'O seguro não cobre as despesas médicas!';
        INSERT INTO [SeguradoraSaude].Pagamento ([RefPagamento], [MetodoPagamento], [Codigo], [Valor], [DataPagamento], [NIFSecretaria]) 
        VALUES (@refPay, @method, @code, @value, @dataPay, @NIFSecre);
    END

END