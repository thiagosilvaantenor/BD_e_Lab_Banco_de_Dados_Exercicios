# Exercício 2 de Lab de Banco de Dados - Modelo de Curso

## 📂 Estrutura dos Exercícios

### A. SELECT Básico
Consultas simples para extração de dados fundamentais.

1. **Listar Alunos:** Selecionar todos os alunos cadastrados.
2. **Disciplinas com Nota Mínima > 5:** Selecionar os nomes de disciplinas cuja nota mínima seja superior a 5.
3. **Filtro por Faixa de Nota:** Selecionar todas as disciplinas que tenham nota mínima entre 3 e 5.

### B. Ordenação e Agrupamento
Trabalhando com a organização visual e lógica dos resultados (`ORDER BY` e `GROUP BY`).

1. **Alunos por Ordem Alfabética:** Selecionar todos os alunos (nome) e o número da classe, ordenados de A-Z.
2. **Ordenação Descendente:** Repetir o item anterior, mas ordenando pelo identificador do aluno de forma decrescente (`DESC`).
3. **Agrupamento por Matéria:** Selecionar alunos que cursam Matemática **e** Português, agrupados por aluno e disciplina.

### C. Junção de Tabelas (JOINs)
Consultas que relacionam múltiplas entidades do banco de dados.

1. **Alunos de Português ou Matemática:** Selecionar nomes de alunos matriculados em uma dessas duas disciplinas.
2. **Alunos de Física e Endereços:** Selecionar nomes de alunos de "Física" e seus respectivos endereços.
3. **Localização de Classe (Concatenação):** Selecionar alunos de "Física" e o andar de suas classes.
   * *Nota:* O resultado deve exibir a string "andar" concatenada ao número (ex: "3º andar").

### D. Junções Externas (OUTER JOIN)
Garantindo a exibição de dados mesmo sem correspondência em ambas as tabelas.

1. **Professores e Disciplinas:** Selecionar todos os professores e suas disciplinas, incluindo aqueles que **não** lecionam nenhuma disciplina no momento.

### E. Subconsultas e Cláusula IN
Desafios de lógica sem o uso direto de `JOIN`.

1. **Filtro Multicamadas:** Selecionar nomes de professores que ministraram disciplinas para alunos do estado do **Piauí (PI)**, cujas aulas ocorreram no **terceiro andar**.
   * *Restrição:* Proibido o uso de junções explícitas.
