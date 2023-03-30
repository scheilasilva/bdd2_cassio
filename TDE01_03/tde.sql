---1)Considerando a criação das tabelas no banco de dados, existe alguma restrição quanto a ordem de execução?
-- Se existe, defina uma sequência correta para a criação das tabelas do esquema acima.

create table cidade(
   id_cidade int auto_increment primary key,
   nome varchar(50) not null,
   uf char(2) not null
);
create table filial(
   id_filial int auto_incriment primary key,
   nome varchar(50)not null,
   endereco varchar(100),
   id_cidade int 
   constraint filial_fk_cidade
   foreign key (id_cidade) references cidade(id)
   );
create table empregado(
   id_empregado int auto_increment primary key,
   nome varchar(50) not null,
   endereco varchar(50),
   contato varchar(15),
   RG varchar (20),
   cpf varchar(14) not null
   salario decimal(10,2),
   id_cidade int
   constraint empregado_fk_cidade
   foreign key (id_cidade) references cidade(id)
   id_filial int 
   constraint empregado_fk_filial
   foreign key(id_filial) references filial(id)

);
   create table produto(
      id_produto int auto_increment primary key,
      descricao varchar(100) not null,
      preço decimal (10,2),
      nome_categoria varchar(50),
      descricao_tabela varchar(100)
   );

create table vende(
   id_vende int auto_increment primary key,
   id_produto int 
   constraint vende_fk_produtos
   foreign key (id_produto) references produto(id)
   id_filial int
   constraint vende_fk_filial
   foreign key (id_filial) references filial(id)
);


/*3-Defina a sintaxe SQL para resolver as seguintes questões:
a-Criar as tabelas vende e filial.*/

create table filial(
   id int auto_increment primary key,
   nome varchar (40), not null,
   endereco varchar(100),
   constraint filial_fk_cidade
   foreign key(id_cidade) references cidade(id)
   );

create table vende (
    id_filial int not null
    constraint vende_fk_filial
    foreign key (id_filial) references filial(id)
    on update cascade
    on delete restrict
    id _produto int not null
    constraint vende_fk_produtos
    foreign key (id_produto) references produto(id)
    on update cascade
    on delete restrict
     );

--b-Listar o valor do produto mais caro.

select max(valor) as maior_valor 
from produto

--c- Obter a média dos preços dos produtos.

select avg(valor) media_valores
from produto

--d-Listar o nome dos produtos vendidos pela filial “f3”. (joins)

select produto.descricao 
from produtos p join vende on p.id_produto = vende.id_produto
join filial f on f.id_filial = f.idfilial
where filial.nome = 'f3'


--e- Listar os nomes e números de RG dos funcionários que moram no Rio Grande do Sul e tem salário superior a R$ 500,00. (joins)

select funcionario.nome, funcionario.RG
from funcionario join cidade on funcionario.id_funcionario = cidade.id_funcionario
where cidade = 'rs'and funcionaro.salario>500


--4-Defina a sintaxe SQL para a criação das tabelas LIVRO e CATEGORIA. 
--Na criação das tabelas especifique a seguinte restrição: 
--“Quando uma categoria for excluída, todos os livros da categoria em questão 
--também serão excluídos.

create table categoria(
   id_cat int auto_increment primary key,
   nome varchar(50) not null,
   descricao varchar(100)
);

create table livro(
   id_livro int auto_increment primary key,
   titulo varchar(100) not null,
   num_folhas int,
   editora varchar(50) not null,
   valor decimal(10,2),
   id_autor int
   constraint livro_fk_autor
   foreign key (id_autor) references autor(id)
   id_cat int
   constraint livro_fk_categoria
   foreign key (id_cat) references categoria(id)
   on update restrict 
   on delete cascade
);



--5-Defina a sintaxe SQL para resolver as seguintes consultas:
--(NÃO ESQUEÇA de usar JOINS nas consultas que envolverem mais
-- de uma tabela)

--a-Mostrar o número total de vendas realizadas.

select count (total) total_de_vendas
from venda 

--b-Listar os títulos e valores dos livros da categoria “banco de Dados’. Mostra também o nome da categoria

select livro.titulo, livro.valor, categoria.nome
from livro join categoria on livro.id_cat = cat.id
where categoria.nome = 'banco de dados'

--c-Listar os  títulos e nome dos autores dos livros que custam mais que R$ 300,00.

select titulo.livro, nome.autor, 
from livro join autor on  livro.id_autor = autor.id
where livro.valor > 300

--Listar os nomes dos clientes juntamente com o nome da cidade onde moram e UF.

select cliente.nome, cidade.nome, uf.cidade
from cliente join cidade on cliente.id_ccidade = cidade.id

--d-Listar os nomes dos clientes juntamente com os nomes de todos os livros comprados por ele.

select cliente.nome, livro.nome
from venda join 

--e-Listar o código do livro, o tilulo, o nome do autor, dos livros que foram vendidos no mês de março de 2021. (join)

select id.livro, titulo.livro, nome.autor
from livro join 

--f-Listar o título e o autor dos 5 livros mais vendidos do mês de janeiro.

select titulo.livro, nome.autor
from 

--g-Mostrar o nome do cliente que comprou o livro com o título ‘Banco de dados powerful’).

select nome.cliente
from venda join cliente on cliente.id_cliente = venda.id_cliente 
join livro on livro.id_livro = venda.id_livro
where titulo.livro = 'banco de dados powerful'


--quantas aguas foram vendidas no mes de fevereiro 
select p.nome, sum(vendas.produtos.quantidade) as total 
from produtos
inner join vendas_produtos 
     on p.id = vendas_produtos.produto_id
inner join vendas 
     on vendas.id = vendas_produtos.venda_id
group by produto.nome
     where venda.data => '2023-02-01' and venda.data <= '2023-02-28'
     and produto.nome = 'agua mineral'

     ---ou
     where v.data between '2023-02-01' and '2023-02-28'


     --liste os 5 clientes que mais compraram no mes de fevereiro

     select nome.clientes as cliente, sum(venda_produtos.quantidade * vendas_produtos.valor_unitario) as valor_total
     from clientes 
     inner join vendas 
     on  clientes.id = cliente.id
     inner join vendas_produtos 
     on vendas.id = vendas_produtos.venda_id
     where venda.data between '2023-02-01' and '2023-02-28'
     group by clientes.nome
     order by valor_total desc
     limit 5
  