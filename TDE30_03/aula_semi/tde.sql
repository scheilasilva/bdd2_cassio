/*
Suponha que temos as seguintes tabelas:
Clientes(id, nome)
Livros (id, titulo, valor_unit)
Autores(id, nome)
Autores_livros(id_autor, id_livro)
Vendas(id, data, id_cliente)
vendas_livros(id, id_livro, qtd, valor_unit)

Crie uma view chamada "livros_mais_vendidos" que exiba o título, autor, preço e a quantidade de vezes que cada livro foi vendido.
Crie uma view que lista os autores que nunca venderam livros.
Use a sua criatividade e crie uma view que se aplique nessa modelagem.
*/

CREATE VIEW livros_mais_vendidos AS
SELECT livros.titulo, AS autor, AS livros.valor_unit, SUM(vendas_livros.qtd) AS qtd_vendas
FROM livros
JOIN autores_livros ON autores_livros.id_livro = livro.id
JOIN autores ON autores.id = autores_livros.id_autor
JOIN vendas_livros ON vendas_livros.id_livro = livro.id
GROUP BY livros.titulo, autores.nome, livros.valor_unit
ORDER BY qtd_vendas DESC;

CREATE VIEW autores_sem_vendas AS
SELECT autores.nome
FROM autores
LEFT JOIN autores_livros ON autores_livros.id_autor = autores.id
WHERE altores.id_livro IS NULL;

CREATE VIEW lista_livros AS
SELECT livros.titulo, livros.valor_unit
FROM livros

