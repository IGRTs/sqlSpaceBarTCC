CREATE DATABASE SpaceBar
GO

Use SpaceBar		
GO


create table tipo_usuario
(
	cod_tipo int primary key identity,
	descricao varchar(30),
);

create table tblUsuario
(
	cod_usuario int primary key identity,
	cod_tipo int,
	nome_usuario varchar(30),
	login_usuario varchar(20),
	senha_usuario varchar(10),
	email_usuario varchar(30),
	pais_usuario char(2),
	cel_usuario varchar(13),
	icon_usuario varbinary(max),
	imgfundo_usuario varbinary (max),
	data_criacao date not null,
	bio_usuario varchar(150),

	/*verificado*/
	profissao varchar(20),
	img_comprovante varbinary (max),
	img_comprovante2 varbinary (max),

	/*criador de conteúdo*/
	data_nasc date,
	genero varchar(10),

	foreign key (cod_tipo) references tipo_usuario
);

create table tblPost
(
	cod_post int primary key identity,
	cod_usuario int,
	titulo_post varchar(300) not null,
	texto_post varchar(100),
	img_post VARBINARY(max),
	img_post2 VARBINARY(max),
	curtidas_post int,
	comentarios_post int,
	data_post datetime not null,
	verificado bit default 0 not null,
	foreign key (cod_usuario) references tblUsuario,
);

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

create table tblSeguidores
(
	indice_segui int identity,
	id_usuario_seguidor int not null,
	id_usuario_alvo int not null,
	primary key (indice_segui),
	foreign key (id_usuario_seguidor) references tblUsuario,
	foreign key (id_usuario_alvo) references tblUsuario
);

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

SET IDENTITY_INSERT tipo_usuario ON;

insert into tipo_usuario(cod_tipo,descricao) values(1, 'Criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(2, 'Verificado')
insert into tipo_usuario(cod_tipo,descricao) values(3, 'Verificado e criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(4, 'ADM')

select * from tipo_usuario

<<<<<<< HEAD
select * from tblUsuario

=======
create table tblPostagemCurtidas
(
    tblPostagemCurtidas_cod_usuario int,
    tblPostagemCurtidas_cod_post int,
    foreign key (tblPostagemCurtidas_cod_usuario) references tblUsuario,
    foreign key (tblPostagemCurtidas_cod_post) references tblPost
)
>>>>>>> c98940a679e5fdd4b4bc615b90f4227e292af69d
