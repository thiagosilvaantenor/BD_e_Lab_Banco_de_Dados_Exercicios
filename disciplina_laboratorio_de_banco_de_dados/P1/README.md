# Prova 1: Banco de Dados - Sistema Acadêmico

Este projeto contém a resolução da Prova 1, utilizando o esquema de banco de dados acadêmico para manipulação de registros de disciplinas, professores, turmas e salas.

## 🗄️ Esquema do Banco de Dados (bd_academico)

O sistema é baseado em um modelo relacional complexo que gerencia:

*   **Estrutura Acadêmica**: Departamentos (`Depto`) e Títulos de Professores (`Titulacao`).
*   **Corpo Docente**: Cadastro de Professores (`Professor`) e sua vinculação às turmas (`profTurma`).
*   **Grade Curricular**: Disciplinas (`Disciplina`) e suas dependências (`PreReq`).
*   **Infraestrutura**: Prédios (`Predio`), Salas (`Sala`) e o escalonamento de aulas (`Horario`).
*   **Oferta**: Detalhes das turmas por semestre e ano (`Turma`).

---

## 📝 Enunciado (Versão: PROVA TURMA C)
OBS: Enunciado foi ditado e infelizmente eu ouvi 'Salão 9' e o correto era 'Salão Nobre'
O desafio consiste em criar uma **Stored Procedure** que utilize **um único Cursor** para realizar uma consulta filtrada com múltiplas junções.

### Objetivo:
Selecionar o **nome das disciplinas** e o **nome do professor** das turmas que atendam aos seguintes critérios:

1.  **Localização**: A aula deve ocorrer em salas cuja descrição seja exatamente `'Salão 9'`.
2.  **Departamento**: A disciplina deve pertencer ao departamento de `'Informatica'`.
3.  **Limitação**: O resultado deve ser limitado a, no máximo, **3 disciplinas**.

### 🔍 Relacionamentos Chave:
Para resolver a query do cursor, é necessário navegar entre:
`Disciplina` ➔ `Turma` ➔ `Horario` ➔ `Sala` ➔ `profTurma` ➔ `Professor`.

---

## 🛠️ Requisitos de Implementação

Para esta prova, a solução deve demonstrar:
*   **Uso de Joins**: Conectar as tabelas de horários e salas com as de professores e disciplinas.
*   **Cursor Único**: A lógica de busca deve estar encapsulada em um cursor dentro da procedure.
*   **Filtros de String**: Uso correto de cláusulas `WHERE` para strings de descrição e nomes de departamento.
*   **Controle de Fluxo**: Garantir que a restrição de "no máximo 3 disciplinas" seja respeitada (via SQL `LIMIT` ou contador lógico no loop do cursor).

---

## 🚀 Como Executar

1.  Crie o banco de dados utilizando o script de schema fornecido.
2.  Popule as tabelas com dados de teste que incluam a sala 'Salão 9' e o depto 'Informatica'.
3.  Crie a procedure:
    ```sql
    DELIMITER $$CREATE PROCEDURE sp_relatorio_sala_9()
    BEGIN
        -- Implementação do Cursor aqui
    END$$
    DELIMITER ;
    ```
4.  Execute:
    ```sql
    CALL sp_relatorio_sala_9();
    ```

---
> **Identificação:** Prova 1 - Banco de Dados Acadêmico
> **Tópicos:** INNER JOINs, Cursores, Procedures.
