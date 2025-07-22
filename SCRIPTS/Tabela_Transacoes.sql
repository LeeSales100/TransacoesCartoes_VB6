USE [CartoesTC]
GO

/****** Object:  Table [dbo].[Transacoes]    Script Date: 22/07/2025 11:37:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Transacoes](
	[Id_Trans] [int] IDENTITY(1,1) NOT NULL,
	[Nr_Cartao] [varchar](16) NOT NULL,
	[Vl_Transacao] [decimal](18, 2) NULL,
	[Dt_Transacao] [datetime] NOT NULL,
	[Descricao] [varchar](255) NULL,
	[St_Transacao] [varchar](10) NULL,
 CONSTRAINT [PK__Transaco__49DA6B399089F80F] PRIMARY KEY CLUSTERED 
(
	[Id_Trans] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Transacoes] ADD  CONSTRAINT [DF__Transacoe__Dt_Tr__5DCAEF64]  DEFAULT (getdate()) FOR [Dt_Transacao]
GO

ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [CK__Transacoe__St_Tr__5EBF139D] CHECK  (([St_Transacao]='Cancelada' OR [St_Transacao]='Pendente' OR [St_Transacao]='Aprovada'))
GO

ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [CK__Transacoe__St_Tr__5EBF139D]
GO

ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [CK__Transacoe__Vl_Tr__5CD6CB2B] CHECK  (([Vl_Transacao]>(0)))
GO

ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [CK__Transacoe__Vl_Tr__5CD6CB2B]
GO

ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [CK_Transacoes] CHECK  (([Vl_Transacao]>=(0)))
GO

ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [CK_Transacoes]
GO

ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [CK_Transacoes_1] CHECK  (([St_Transacao]='Cancelada' OR [St_Transacao]='Pendente' OR [St_Transacao]='Aprovada'))
GO

ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [CK_Transacoes_1]
GO


