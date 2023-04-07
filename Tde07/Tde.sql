1--
CREATE PROCEDURE quantidade_livros_escritos (IN cpf_autor VARCHAR(14), OUT quantidade INT)
BEGIN
    SELECT COUNT(*) INTO quantidade
    FROM livros
    WHERE cpf_autor = cpf_autor;
END

--2
CREATE PROCEDURE atualizar_data_lancamento (IN id_livro INT, IN atualizar_data_lancamento DATE)
BEGIN
    UPDATE livros
    SET data_lancamento = data_lancamento
    WHERE id = id_livro;
END

--3
--a
create procedure InserirLivro
    @titulo varchar(30),
    @autor varchar(50),
    @anoPublicacao int,
    preco decimal(8,2)
as
begin
    insert int Livros(titulo, autor, anoPublicacao, preco)
    values (@titulo, @autor, @anoPublicacao, @preco)
end 


--b

create procedure ExcluirLivro
   @Livro int
as
begin
    delete from Livros where LivroId = @LivroId
end

--c
create procedure AtualizarLivro
    @LivroId int,
    @titulo varchar(30)= null,
    autor varchar(50) = null,
    @anoPublicacao int = null,
    preco decimal (8,2) = null
as
begin
    update Livros seguintes
        titulo = isnull(@titulo, titulo),
        autor = isnull(@autor, autor),
        anoPublicacao = isnull(@anoPublicacao, anoPublicacao),
        preco = isnull(@preco, preco)
    where LivroId = @LivroId
end

--4
create procedure alteracao_preco_editora (in editora varchar(100), in valor float, in percentual boolean )
begin
    if percentual = TRUE then
        update livros
        set preco = preco *(1 + (valor/100))
        where editora = editora;
    else
        update livros
        set preco = preco + valor
        where editora = editora;
    end if;
end