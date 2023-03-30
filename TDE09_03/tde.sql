

--quantas alunos tem no curso de ads  

select count() as qtd_alunos
from alunos inner join curso
 on alunos.id_cursos = cursos.id_curso
 where nome.curso ='ads'


 --liste os 10 alunos a tirar maior nota no curso de ads

select nome.alunos nota.nota   
from alunos
 inner join curso 
on alunos.id_curso = curso.id_curso
inner join nota 
on curso.id_curso = nota.id_curso 
where nome.curso='ads'
order by nota.nota desc
limit 10

--quantidade de cursos 
select nome sum(quantidade) as quantidade_cursos
from cursos
group by nome.cursos
having sum(quantidade) > 5



--aula03

--eu tenho uma modelagem assim:
--um cliente tem muitas vendas
--um produto pode estar em muitas vendas
--vendas pode ter muitas formas de pagamento
--forma de pagamento pode estar em muitas vendas 
--1 quantas tabelas eu tenho aqui 
--cliente(id, nome)
--produto(id, nome)
--vendas(id, data, id_cliente)  
--vendas_produtos(id_venda, id_produto, quant, valor_unit)
--formas_pnto(id, nome)
--vendas_forma_pgto(id_venda, id_forma_pgto, valor)

--listar todos os produtos vendidos no mes de fevereiro de 2023





-- listar o valor total de vendas por forma de pagamento no mes de fev 2023


select formas_pgto.nome as formas_pgto, sum(vendas_forrma_pgto.valor) as valor_total
from venda 
join formas_pgto on venda.id_formas_pgto = formas_pgto.id_forma_pgto
join vendas_forma_pgto on vendas_forma_pgto.id_vendas = venda.id_venda
where venda.data between '2023-02-01' and '2023-02-28'
group by formas_pgto.nome 