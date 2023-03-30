--Escreva uma consulta que retorne o nome do cliente, a soma do valor total das compras e o 
--número total de pedidos feitos por cada cliente, apenas para aqueles que fizeram pelo menos
-- três pedidos. Use um inner join entre as tabelas "clientes" e "pedidos" e agrupe os resultados pelo nome do cliente.
 
select cliente.nome as nome_cliente
 sum(pedidos.valor_total) as valor_total 
count (pedidos.id) as total_pedidos
from cliente 
inner join pedidos 
on cliente.id = pedidos.id_cliente
group by cliente.nome
having count (pedidos.id) >=3

/*Escreva uma consulta que retorne o nome do produto, a média do preço de venda e
 a soma total de unidades vendidas por categoria de produto.
 Use um left join entre as tabelas "produtos" e "vendas" e agrupe os resultados pela categoria do produto.*/


select produto.nome as nome_produto, produto.categoria as categoria_produto
 avg(venda.preco_venda) preco_venda 
sum(venda.quantidade_vendidas) total_vendidas
from produtos 
left join vendas 
on produto.id = vendas.id_produto
group by produto.nome, produto.categoria



/*Escreva uma consulta que retorne o nome do fornecedor, o nome do produto e o
 número total de unidades compradas por fornecedor e por produto, apenas para
  aqueles com mais de 100 unidades compradas. Use um inner join entre as tabelas 
"fornecedores", "produtos" e "compras" e agrupe os resultados pelo nome do fornecedor e pelo nome do produto.*/

/*fornecedor
id nome    

compras 
id quantidades id_fornecedor id_produto

produto
id nome*/   

select fornecedor.nome as nome_fornecedor
produto.nome as nome_produto 
sum(compras_Produtos.quantidade) as total_unidades_compradas
from fornecedor 
inner join compras 
on fornecedor.id = compras.id_fornecedor 
inner join compras_produtos 
on compras_produtos.id_compra = compras.id
inner join produtos
on produtos.id = compras_Produtos.id_produto 
group by fornecedor.nome, produto.nome
having compras_produtos.quantidade >= 100


/*Escreva uma consulta que retorne o nome do departamento, o nome do funcionário
 e a média do salário dos funcionários em cada departamento, apenas para aqueles
  com uma média de salário superior a R$ 5000. 
Use um left join entre as tabelas "funcionarios" e "departamentos"
 e agrupe os resultados pelo nome do departamento e pelo nome do funcionário.*/


 departamento 
 id nome 

 funcionario  (1,n)
 id nome 

select departamento.nome as nome_departamento
funcionario.nome as nome_funcionario
avg( funcionario.media_salario) as media_salario
from departamento 
left join funcionario
on departamento.id = funcionario.id_departamento
group by departamento.nome, funcionario.nome
having funcionario.media_salario > 5000

/*Escreva uma consulta que retorne o nome do cliente,
 o nome do produto e a soma do valor total das compras feitas por cada cliente para cada produto. Use um right */


cliente 
id nome

compras
id valor_total id cliente id produto 

produto 
id nome 


select cliente.nome as nome_cliente 
produto.nome as nome_produto 
sum(compras.quantidade, compras.valor_unitario) as valor_total
from cliente 
right join compras 
on cliente.id = compras.id_cliente
right join produto 
on compras.id_produto = produto.id
group by cliente.nome, produto.nome




















