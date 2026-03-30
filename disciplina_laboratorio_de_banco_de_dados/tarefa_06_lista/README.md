## ⚙️ Exercícios de Lógica Procedural (Stored Procedures & Cursors)

Esta seção foca na implementação de lógica de negócio diretamente no SGBD, utilizando **Cursores** para iteração de dados e **Stored Procedures** para encapsulamento.

### 📋 Lista de Desafios (Semestre 2002/1)

1. **Departamentos Ativos:** Obter códigos dos diferentes departamentos com turmas no período 2002/1.
2. **Filtro de Docentes (INF01):** Identificar códigos de professores do departamento 'INF01' que ministraram aulas em 2002/1.
3. **Agenda do Professor "Antunes":** * Recuperar dia da semana, hora inicial e carga horária das aulas do prof. Antunes em 2002/1.
   * *Nota: Existe uma variação deste exercício para filtrar turmas na sala 101 do prédio 'Informática - aulas'.*
4. **Doutores Inativos:** Identificar professores com título de 'Doutor' que **não** ministraram aulas em 2002/1.
5. **Uso de Salas Multicritério:** Identificar prédios e salas que atenderam:
   * Segundas-feiras: Turmas do departamento 'Informática'.
   * Quartas-feiras: Turmas ministradas pelo prof. 'Antunes'.
6. **Detalhamento de Grade Localizada:** Obter horários completos de turmas do prof. 'Antunes' (2002/1) especificamente na sala 101 do prédio 43423.
7. **Intercâmbio de Departamentos:** Listar professores que lecionaram disciplinas fora de seu departamento de origem (Exibir: Cód. Professor, Nome, Depto. Origem e Depto. da Disciplina).
8. **Detecção de Conflitos de Horário:** Identificar professores com turmas sobrepostas (mesmo dia, hora e semestre). 
   * *Saída:* Nome do professor e as chaves primárias das turmas conflitantes.

### 🧩 Estrutura de Disciplinas e Pré-requisitos

9. **Mapeamento de Dependências:** Listar nomes de disciplinas acompanhados pelos nomes de seus respectivos pré-requisitos.
10. **Disciplinas de Entrada:** Obter nomes das disciplinas que **não** possuem nenhum pré-requisito.
11. **Alta Complexidade:** Identificar disciplinas que possuem **dois ou mais** pré-requisitos cadastrados.

---

## 💡 Conceitos Aplicados nestas Procedures

> [!IMPORTANT]
> O uso de **CURSORES** nestes exercícios é obrigatório para:
> * Iterar sobre conjuntos de resultados complexos.
> * Realizar validações linha a linha antes da saída final.
> * Gerenciar estados de busca em subconsultas procedurais.

### Exemplo de Estrutura Esperada (Template):
```sql
CREATE PROCEDURE sp_exemplo_cursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE var_nome VARCHAR(255);
    DECLARE cur1 CURSOR FOR SELECT nome FROM professores;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;
    -- Lógica de iteração aqui
    CLOSE cur1;
END;
