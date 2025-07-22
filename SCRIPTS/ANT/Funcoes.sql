
USE [CartoesBCL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[fn_Transacoes_Categoriz_BCLI] (@dt_Inicial DATETIME, @dt_Final DATETIME)
RETURNS TABLE
AS
RETURN (
    SELECT Id_Trans, Nm_Cartao, Vl_Transacao,
           dbo.fn_Categoria_Vl_BCLI(Vl_Transacao) AS Categoria,
           Dt_Transacao, Descricao, St_Transacao
    FROM Transacoes_BCLI
    WHERE Dt_Transacao BETWEEN @dt_Inicial AND @dt_Final
);

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[fn_Categoria_Vl_BCLI] (@Vl_categoria DECIMAL(18,2))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Categ VARCHAR(20)
    IF (@Vl_categoria > 2000) SET @Categ = 'Premium'
    ELSE IF (@Vl_categoria >= 1000) SET @Categ = 'Alta'
    ELSE IF (@Vl_categoria >= 500) SET @Categ = 'Média'
    ELSE SET @Categ = 'Baixa'
    RETURN @Categ
END;
