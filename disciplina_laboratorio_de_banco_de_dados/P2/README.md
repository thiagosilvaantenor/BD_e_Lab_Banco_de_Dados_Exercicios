# Prova 2: Banco de Dados - Sistema de Oficina Automotiva

Este projeto contém a resolução da Prova 2, focada na implementação de lógica procedural avançada (Stored Procedures e Cursores) aplicada a um sistema de gerenciamento de oficina.

## 🗄️ Esquema do Banco de Dados

O banco de dados `oficina` é composto pelas seguintes tabelas:

* **`veiculos`**: Cadastro de frotas (placa, modelo, ano).
* **`ordens_servico`**: Registro das aberturas de manutenção.
* **`orcamentos`**: Valores estimados e status de aprovação.
* **`servicos_realizados`**: Descrição e valores finais dos serviços.
* **`saidas`**: Registro da data de conclusão e entrega do veículo.

---

## 📝 Enunciado (Versão: PROVA ÍMPAR)

O objetivo desta prova é desenvolver uma **Stored Procedure** utilizando **CURSOR** que atenda aos seguintes requisitos de negócio:

> "Listar a quantidade de ordens de serviço de veículos com **mais de 20 anos de fabricação**, que tenham tido um **orçamento aprovado** e o serviço efetivamente **realizado**, agrupados por **mês**."

### 🔍 Lógica de Filtragem:
1.  **Veículos Antigos**: Filtrar veículos com `ano_fabricacao` inferior a `(ANO_ATUAL - 20)`.
2.  **Fluxo Completo**: A Ordem de Serviço (OS) deve possuir um registro na tabela `orcamentos` com `aprovado = TRUE` e registro correspondente na tabela `servicos_realizados`.
3.  **Agrupamento Temporal**: Os resultados devem ser consolidados mensalmente.

---

## 🚀 Implementação Sugerida

Para resolver este problema, a procedure deve percorrer os registros que atendem aos filtros e utilizar uma estrutura de contagem (contador) dentro do loop do cursor, ou gerar uma tabela temporária/saída formatada.

### Requisitos Técnicos:
* Uso obrigatório de **CURSOR**.
* Tratamento de exceção/final de busca (`CONTINUE HANDLER`).
* Manipulação de datas (`MONTH()` e `YEAR()`).

---

## 🛠️ Como Executar

1.  Certifique-se de que o schema acima foi criado no seu servidor MySQL/MariaDB.
2.  Carregue o script da Stored Procedure.
3.  Execute a chamada:
    ```sql
    CALL sp_relatorio_veiculos_antigos();
    ```

---
> **Identificação:** Prova 2 - Banco de Dados
> **Contexto:** Relatórios Gerenciais de Oficina Automotiva
