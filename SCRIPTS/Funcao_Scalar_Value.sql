USE [CartoesTC]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_CategoriaPorValor]    Script Date: 22/07/2025 11:43:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_CategoriaPorValor] (@Valor DECIMAL(18,2))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Categoria VARCHAR(20)

    IF @Valor > 2000
        SET @Categoria = 'Premium'
    ELSE IF @Valor >= 1000 AND @Valor <= 2000
        SET @Categoria = 'Alta'
    ELSE IF @Valor >= 500 AND @Valor < 1000
        SET @Categoria = 'Média'
    ELSE
        SET @Categoria = 'Baixa'

    RETURN @Categoria
END
GO


