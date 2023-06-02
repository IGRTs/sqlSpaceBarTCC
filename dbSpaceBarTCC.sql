CREATE DATABASE SpaceBar
GO

Use SpaceBar		
GO

create table tipo_usuario
(
	cod_tipo int primary key identity,
	descricao varchar(30),
);
GO
create table tblUsuario
(
	cod_usuario int primary key identity,
	cod_tipo int,
	nome_usuario varchar(30),
	login_usuario varchar(20),
	senha_usuario varchar(100),
	email_usuario varchar(30),
	pais_usuario varchar(30),
	cel_usuario varchar(13),
	icon_usuario varbinary(max),
	imgfundo_usuario varbinary (max),
	data_criacao date not null,
	bio_usuario varchar(150),

	/*verificado*/
	status_verificado varchar(20) default 'nenhum' not null,
	profissao varchar(20),
	img_comprovante varbinary (max),
	foreign key (cod_tipo) references tipo_usuario,
	check ([status_verificado]='nenhum' OR [status_verificado]='aceito' OR [status_verificado]='pendente' OR [status_verificado]='negado')
);

GO
create table tblPost
(
	cod_post int primary key identity,
	cod_usuario int,
	titulo_post varchar(300) not null,
	texto_post varchar(100),
	img_post VARBINARY(max),
	comentarios_post int,
	data_post datetime not null,
	verificado bit default 0 not null,
	foreign key (cod_usuario) references tblUsuario,
);
GO
create table tblComentarios
(
	cod_comentario int identity,
	cod_post int,
	cod_usuario int,
	conteudo_comentario varchar(200) not null,
	data_comentario datetime not null,
	primary key (cod_comentario),
	foreign key (cod_post) references tblPost,
	foreign key (cod_usuario) references tblUsuario
);
GO
create table tblSeguidores
(
	indice_segui int identity,
	id_usuario_seguidor int not null,
	id_usuario_alvo int not null,
	primary key (indice_segui),
	foreign key (id_usuario_seguidor) references tblUsuario,
	foreign key (id_usuario_alvo) references tblUsuario
);
GO
create table tblDenuncia
(
	cod_denuncia int identity,
	usuario_denunciado int,
	post_denunciado int,
	comentario_denunciado int,
	motivo varchar(255) not null,
	status_denuncia varchar(20) default 'pendente' not null,
	data_denuncia date not null,
	primary key (cod_denuncia),
	check ([status_denuncia]='ignorado' OR [status_denuncia]='resolvido' OR [status_denuncia]='pendente'),
);
GO
SET IDENTITY_INSERT tipo_usuario ON;

insert into tipo_usuario(cod_tipo,descricao) values(1, 'Usuario comum')
insert into tipo_usuario(cod_tipo,descricao) values(2, 'Criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(3, 'Verificado')
insert into tipo_usuario(cod_tipo,descricao) values(4, 'Verificado/criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(5, 'ADM')

create table tblPostagemCurtidas
(
    tblPostagemCurtidas_cod_usuario int,

    tblPostagemCurtidas_cod_post int,
    foreign key (tblPostagemCurtidas_cod_usuario) references tblUsuario,
    foreign key (tblPostagemCurtidas_cod_post) references tblPost
);
GO
-- pega todos os cod_post em ordem crescente
CREATE PROCEDURE GetCodPostagensCrescente
AS
    SELECT cod_post FROM tblPost ORDER BY cod_post ASC
GO

-- pega todo o conteÃºdo de um post junto com as informaÃ§Ãµes de quem o criou
CREATE PROCEDURE GetPostAndAuthor
AS
    SELECT * from tblPost INNER JOIN tblUsuario tU on tU.cod_usuario = tblPost.cod_usuario
GO
-- obtem a quantidade de posts que tem no banco de dados inteiro
CREATE PROCEDURE GetPostsQuantity
AS
    SELECT COUNT(cod_post) FROM tblPost
-- obtem todos os dados de todos os posts
CREATE PROCEDURE GetPost
AS
    SELECT * FROM tblPost
-- verificar se um post especifico Ã© verificado (true ou false)

CREATE PROCEDURE GetPostVerified
    @cod_post int
AS
    SELECT verificado FROM tblPost WHERE cod_post = @cod_post
GO
CREATE PROCEDURE GetPostQuantityLikes
    @postID int
AS
    SELECT COUNT(tblPostagemCurtidas_cod_usuario) FROM tblPostagemCurtidas WHERE tblPostagemCurtidas_cod_post = @postID
GO
CREATE PROCEDURE CheckUserHasLiked
    @postId int,
    @userId int
AS
    SELECT COUNT(*) FROM tblPostagemCurtidas WHERE tblPostagemCurtidas_cod_post = @postId AND tblPostagemCurtidas_cod_usuario = @userId
GO
CREATE PROCEDURE GetAuthorPost
    @postId int
AS
    -- select the cod_usuario from tblUsuario where the cod_usuario equals to the creator of an specific post --
    SELECT cod_usuario FROM tblPost WHERE cod_post = @postId
GO
CREATE PROCEDURE GetUserInformation
    @userId int
AS
    SELECT * FROM tblUsuario WHERE cod_usuario = @userId
GO
CREATE PROCEDURE DeleteLike
    @postId int,
    @userId int
AS
    DELETE FROM tblPostagemCurtidas WHERE tblPostagemCurtidas_cod_post = @postId AND tblPostagemCurtidas_cod_usuario = @userId
GO
CREATE PROCEDURE AddLike
    @postId int,
    @userId int
AS
    INSERT INTO tblPostagemCurtidas (tblPostagemCurtidas_cod_post, tblPostagemCurtidas_cod_usuario) VALUES (@postId, @userId)
GO
CREATE PROCEDURE GetAllInfoAndPostsByAuthor
    @postAuthorID int
AS
    SELECT * FROM tblPost INNER JOIN tblUsuario tU ON tU.cod_usuario = tblPost.cod_usuario WHERE tblPost.[cod_usuario] = @postAuthorID
GO
CREATE PROCEDURE GetuserInformation
    @userId int
AS
    SELECT * FROM tblUsuario WHERE cod_usuario = @userId
GO
CREATE PROCEDURE GetQuantityFollowing
    @userId int
AS
    SELECT COUNT(*) AS FollowingCount FROM tblSeguidores WHERE id_usuario_seguidor = @userId
GO
CREATE PROCEDURE GetQuantityFollowers
    @userId int
AS
    SELECT COUNT(*) AS FollowersCount FROM tblSeguidores WHERE id_usuario_alvo = @userId
GO
CREATE PROCEDURE FollowUser
    @usuario_seguidor int,
    @usuario_alvo int
AS
    INSERT INTO tblSeguidores (id_usuario_seguidor,id_usuario_alvo) VALUES (@usuario_seguidor, @usuario_alvo)
GO

-- verifica se o seguidor_alvo ja está sendo seguindo pelo usuário logado
CREATE PROCEDURE VerifyIfUserIsAlreadyBeingFollowed
    @usuario_seguidor int,
    @usuario_alvo int
AS
    -- verifica se o usuario seguidor (logado) segue o usuario alvo (perfil desejado) --
    SELECT COUNT(id_usuario_seguidor) FROM tblSeguidores WHERE id_usuario_alvo = @usuario_alvo AND id_usuario_seguidor = @usuario_seguidor
GO
CREATE PROCEDURE UnfollowUser
    @usuario_seguidor int,
    @usuario_alvo int
AS
    DELETE FROM tblSeguidores WHERE id_usuario_seguidor = @usuario_seguidor AND id_usuario_alvo = @usuario_alvo
GO
--procedure inscrever--
Create Procedure SelectVerificarLoginEmail
    @login varchar(20),
    @email varchar(30)
as
begin
	select login_usuario, email_usuario
	from tblUsuario
	WHERE login_usuario = @login OR email_usuario = @email
end
GO
Create Procedure InsertInscrever
@tipo_usu int,
@nome varchar (30),
@login varchar(20),
@email varchar(30),
@cel varchar (13),
@pais varchar(30),
@senha varchar (100),
@data date
as
begin
	insert into tblUsuario(cod_tipo,nome_usuario,login_usuario,email_usuario,cel_usuario,pais_usuario,senha_usuario,data_criacao) values (@tipo_usu,@nome, @login, @email, @cel, @pais, @senha, @data);
end
GO
/*Create procedure SelectCodTipo */
Create procedure SelectCodTipo
@codUsuarioConectado int
as
begin
	select cod_tipo
	from tblUsuario
	WHERE cod_usuario = @codUsuarioConectado
end
GO
--  procedure login--
create procedure spacelogin
	@login varchar(20),
	@senha varchar(10)
As
Begin
	Select * from tblUsuario where login_usuario = @loguser and senha_usuario=@senhauser
END