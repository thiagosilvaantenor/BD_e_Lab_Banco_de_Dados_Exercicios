# Revisão SQL: INNER e OUTER JOINS, Formatação em SELECT e funções de agregações

## Diagrama e constraints:

![image](https://github.com/user-attachments/assets/2c8dd146-edd6-47fe-876e-07e6aa45b5cf)


## Enunciados:

1. Consultar nome, valor unitário, nome da editora e nome do autor dos livros do estoque que foram vendidos. 
Não podem haver repetições.
2. Consultar nome do livro, quantidade comprada e valor de compra da compra 15051.
3. Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site tenha mais de 10 dígitos, remover o www.).
4. Consultar nome do livro e Breve Biografia do David Halliday.
5. Consultar código de compra e quantidade comprada do livro Sistemas Operacionais Modernos.
6. Consultar quais livros não foram vendidos.
7. Consultar quais livros foram vendidos e não estão cadastrados. Caso o nome dos livros terminem com espaço, fazer o trim apropriado.
8. Consultar Nome e site da editora que não tem Livros no estoque (Caso o site tenha mais de 10 dígitos, remover o www.)
9. Consultar Nome e biografia do autor que não tem Livros no estoque (Caso a biografia inicie com Doutorado, substituir por Ph.D.).
10. Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente.
11. Consultar o código da compra, o total de livros comprados e a soma dos valores gastos. Ordenar por Código da Compra ascendente.	
12. Consultar o nome da editora e a média de preços dos livros em estoque. Ordenar pela Média de Valores ascendente.	
13. Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora. (Caso o site tenha mais de 10 dígitos, remover o www.), criar uma coluna status onde:	
	- Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido
	- Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando
	- Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente
	- A Ordenação deve ser por Quantidade ascendente
