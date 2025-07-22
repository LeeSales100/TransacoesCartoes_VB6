USE [CartoesTC]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_TransacoesCategorizadasPorPeriodo]    Script Date: 22/07/2025 11:42:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_TransacoesCategorizadasPorPeriodo] (
    @Dt_Inicial DATETIME,
    @Dt_Final DATETIME
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Id_Trans,
        Nr_Cartao,
        Vl_Transacao,
        Dt_Transacao,
        Descricao,
        St_Transacao,
        dbo.fn_CategoriaPorValor(Vl_Transacao) AS Categoria
    FROM Transacoes
    WHERE Dt_Transacao BETWEEN @Dt_Inicial AND @Dt_Final
)
GO


