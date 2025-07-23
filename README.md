# 📚 Transações de cartão de credito de clientes
O objetivo desta solução é gerenciar as transações de cartão de clientes

---

## 🚀 Pré-requisitos

Antes de rodar o projeto, você precisa ter instalado:

- Visual Basic 6.0
- SQL Server recomendado
- SQL Server Management Studio (opcional, mas recomendado)
  
---

## ⚙️ Preparando o banco de dados

2️⃣ **Verifique o usuário e permissões 

Rode todos os .sql constantes na pasta scripts

--
🖥️ Rodando o Projeto

A seguinte estrutura deverá ser criada na pasta raiz ( C: )
                                                      
- Projeto_Transacoes_Cartoes_Clientes
     - ExcelGerado
     - Projeto
     - Scripts

O projeto deve ser instalado em: C:\Projeto_Transacoes_Cartoes_Clientes\Projeto

1️⃣ Abra o arquivo .vbp no Visual Basic 6.

2️⃣ Verifique se as referências do projeto estão configuradas:

Menu: Project → References

Confirme se a biblioteca Microsoft ActiveX Data Objects x.x Library está marcada.

- Troque **SEU_SERVIDOR**, **NOME_BANCO**, **USUARIO**, **SENHA** para os valores reais ou exemplos no moduloconecta.bas

STRING DE CONEXÃO ATUAL: sStrCon = "Provider=SQLOLEDB;Data Source=NOTE_LM\SQLEXPRESS;Initial Catalog=CartoesTC;User ID=sa;Password=sapo"

3️⃣ Compile ou execute (F5).



