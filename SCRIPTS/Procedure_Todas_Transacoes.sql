USE [CartoesTC]
GO

/****** Object:  StoredProcedure [dbo].[sp_Todas_Transacoes]    Script Date: 22/07/2025 11:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Todas_Transacoes]
    @Dt_Inicial DATETIME,
    @Dt_Final DATETIME
   
AS
BEGIN
    SELECT Nr_Cartao,Vl_transacao,Dt_transacao,Descricao,St_transacao
          
    FROM Transacoes
    WHERE Dt_Transacao BETWEEN @Dt_Inicial AND @Dt_Final
     
  
END
GO


