# Tarefa 08 - TRIGGERS

## Enunciado
Criar trigger para registrar um LOG das atualizações das Tabela Professor. No Log deve existir:

           1-  código do usuário que fez a alteração;

           2-  chave primaria do registro alterado;

           3-  Tipo de alteração realizado (INSERT ou UPDATE ou DELETE);

           4-  Data e Hora da alteração.



Entregar a estrutura da Tabela de LOG ( pode ser chamada Tabela_Log_Professor ) ;

e o Código da(s) Trigger(s).

-- para selecionar o usuario corrente no mysql
SELECT CURRENT_USER();