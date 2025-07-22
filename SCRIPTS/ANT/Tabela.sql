
CREATE TABLE Transacoes_BCLI (
    Id_Trans INT IDENTITY(1,1) PRIMARY KEY,
    Nm_Cartao CHAR(16) NOT NULL,
    Vl_Transacao DECIMAL(18,2) NOT NULL,
    Dt_Transacao DATETIME NOT NULL,
    Descricao VARCHAR(255) NULL,
    St_Transacao VARCHAR(20) NULL
);
