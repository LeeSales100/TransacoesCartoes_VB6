
CREATE VIEW vw_Resumo_Financeiro_BCLI AS
SELECT Nm_Cartao, SUM(Vl_Transacao) AS Total_Valor,
       COUNT(*) AS Qtd, St_Transacao
FROM Transacoes_BCLI
GROUP BY Nm_Cartao, St_Transacao;
