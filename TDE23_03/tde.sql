create table produtos{
    id int auto_incremente primary key,
    nome varchar(100) not null, 
    valor decimal(10,2) not null,
    saldo int not null
}

create table orcamentos{
    id int auto_incremente primary key
    data date not null,
    status varchar(30)
}

create table itens_orcamentos{
   id int auto_incremente primary key
  valor_unitario decimal(10,2) not null,
  quantidade int not null,
  valor_total_item decimal(10,2) not null,
  id_produto int 
  foreign key(id_produto) references produto(id)
  id_orcamentos int 
  foreign key (id_orcamentos) references orcamentos(Id)
}


--c) views
--Lista de orçamentos por produto

create view orcamentos_por_produto as
select  produto.nome as nome_produto
        orcamento.id as id_orcamento 
        orcamento.data as data_orcamento 
        io.quantidade as quantidade_io
        io.valor_unitario as valor_unitario_io
        io.valor_total_item as valor_total_item_io 
from    produto 
            left join itens_orcamentos io
                on produtos.id = io.id_produto
            inner join orcamentos 
                on io.id_orcamento  = orcamento.id

               
select nome_produto
from orcamentos_por_produto
where id_orcamento is null
--listar os produtos que nunca foram orçados sem view 

select nome_produto 
from  produtos 
where id not in( select id_produto from io
            where id_produto = produto.id )


--Valor total de produtos orçados por periodo

create view orcados_por_periodo as
select sum(io.valor_total_item) as valor_total,
orcamento.data as data_orcamento
from itens_orcamentos io 
inner join orcamentos
on io.id_orcamento = orcamento.id

group by orcamento.data
 
select *
 from orcados_por_periodo
 where data between '2023-01-01' and '2023-01-31'

--Produtos que tem “Computador” no nome e que tem quantidade em estoque.
create view produto_computador as
select *
from produto
where nome.produto like '%computador%' and saldon>0

--Os 10 produtos mais orçados no mês de setembro de 2014 e que
-- ainda tem saldo em estoque. Somente os produtos com o valor 
--acima de R$ 500.00.

create view produtos_mais_orcados as
select produto.nome as nome_produto 
sum(io.quantidade) as total_orcado
from produtos
inner join itens_orcamentos io
on produto.id = io.id_produto
inner join orcamento 
on io.id_orcamento = orcamento.id
where produto.valor > 500.00 and produto.saldo > 0 
and month (orcamento.data) = 9 and year(orcamento.data) = 2014
group by produto.nome
order by total orcado desc
limit 10

--Faça uma consulta utilizando a view para acrescentar 20% nos
-- produtos que o saldo em estoque é menor ou igual a 5.
create view acrescentar_% as
select produto.id as id_produto
produto.nome as nome_produto
valor* 1.2 as valor_atualizado
from produtos
where produto.saldo <=5

--Delete todos os produtos que não foram orçados.

Delete from produtos 
where id not in(
    select distinct id_produto from itens_orcamentos
)

--Explique quando utilizar o GROUP BY, de um exemplo sql.
--é para selecionar diversas colunas em uma tabela e grupar por mais campos 

--agrupar a media de vendas por cada produto 

media de vendas por produto 
create view media_vendas as 
select produt. nome as nome_produto 
avg(io.quantidade) as media_vendas
from produtos
inner join itens_orcamentos io
on produtos.id = io.id_produto
inner join orcamento 
on io.id_orcamento = orcamento.id
where orcamento.status
group by produto.nome

--Explique quando utilizar o HAVING, de um exemplo sql.
--é usada em conjunto com group by para filtrar grupos
--por exemplo 

--faca uma consulta para saber o nome dos produtos que 
--tiveram um total de 30.000 unidades em orcamento


SELECT produto.nome as nome_produto,
 SUM(io.quantidade) AS total_vendido
FROM produtos 
JOIN orcamentos_itens io ON produto.id = io.id_produto
JOIN orcamento  ON io.id_orcamento = orcamento.id
WHERE orcamento.status
GROUP BY produto.nome
HAVING SUM(io.quantidade) > 30000;

--Explique quando utilizar o LEFT JOIN, de um exemplo sql.
--left join é para juntar todos os orcamentos mesmo que haja um item orcamento null
-- calcular o valor total dos itens mesmo que haja um item orcamento null
select orcamento.id as id_orcamento
orcamento.data as data_orcamento
sum (io.valor_unitario * io.quantidade) as valor_total
from orcamento 
left join itens_orcamentos io
on orcamento.id = io.id_orcamento
group by orcamento.id