CREATE DATABASE SpaceBar
GO

Use SpaceBar		
GO

create table tblIcon
(
	cod_icon int identity primary key,
	caminho_img nvarchar(500)
);
GO
create table tblImg_comprovante
(
	cod_img int identity primary key,
	caminho_img nvarchar(500)

);
GO
create table tblImg_post
(
	cod_imgpost int identity primary key,
	caminho_img nvarchar(500)
);
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
	cod_icon int foreign key references tblIcon,
	cod_tipo int,
	nome_usuario varchar(30),
	login_usuario varchar(20),
	senha_usuario varchar(10),
	email_usuario varchar(30),
	pais_usuario char(2),
	cel_usuario varchar(13),
	icon_usuario varbinary(max),
	data_criacao date not null,
	desc_perfil_usuario varchar(150),

	/*verificado*/
	profissao varchar(20),
	cod_img int foreign key references tblImg_comprovante,

	/*criador de conteúdo*/
	data_nasc date,
	genero varchar(10),

	foreign key (cod_tipo) references tipo_usuario
);
GO
create table tblPost
(
	cod_post int primary key identity,
	cod_imgpost int foreign key references tblImg_post,
	cod_usuario int,
	titulo_post varchar(300) not null,
	descricao_post varchar(100),
	curtidas_post int,
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
GO
insert into tipo_usuario(cod_tipo,descricao) values(1, 'Usuário comum')
insert into tipo_usuario(cod_tipo,descricao) values(2, 'Criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(3, 'Verificado')
insert into tipo_usuario(cod_tipo,descricao) values(4, 'ADM')
GO
create table tblPostagemCurtidas
(
    tblPostagemCurtidas_cod_usuario int,
    tblPostagemCurtidas_cod_post int,
    foreign key (tblPostagemCurtidas_cod_usuario) references tblUsuario,
    foreign key (tblPostagemCurtidas_cod_post) references tblPost
)
GO
-- pega todos os cod_post em ordem crescente
CREATE PROCEDURE GetCodPostagensCrescente
AS
    SELECT cod_post FROM tblPost ORDER BY cod_post ASC
GO

-- pega todo o conteúdo de um post junto com as informações de quem o criou
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
-- verificar se um post especifico é verificado (true ou false)

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