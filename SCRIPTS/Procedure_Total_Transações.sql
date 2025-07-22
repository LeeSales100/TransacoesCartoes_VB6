USE [CartoesTC]
GO

/****** Object:  StoredProcedure [dbo].[sp_Total_Transacoes]    Script Date: 22/07/2025 11:41:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Total_Transacoes]
    @Dt_Inicial DATETIME,
    @Dt_Final DATETIME,
    @St_Transacao VARCHAR(20)
AS
BEGIN
    SELECT Nr_Cartao, 
           SUM(Vl_Transacao) AS Vl_Total,
           COUNT(*) AS Qtd_Trans, 
           St_Transacao
    FROM Transacoes
    WHERE Dt_Transacao BETWEEN @Dt_Inicial AND @Dt_Final
      AND St_Transacao = @St_Transacao
    GROUP BY Nr_Cartao, St_Transacao
END
GO


