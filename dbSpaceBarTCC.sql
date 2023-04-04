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

create table tblIcon
(
	cod_icon int identity,
	img nvarchar(100),
	primary key (cod_icon)
);

create table tblImg_comprovante
(
	cod_img int identity,
	img nvarchar(100),
	img2 nvarchar(100),
	primary key (cod_img)
);

create table tblImg_post
(
	cod_imgpost int identity,
	img nvarchar(100),
	img2 nvarchar(100),
	primary key (cod_imgpost)
);

create table tipo_usuario
(
	cod_tipo int identity,
	descricao varchar(30),
	primary key (cod_tipo)
);

create table tblUsuario
(
	cod_usuario int identity,
	cod_tipo int,
	nome_usuario varchar(30) not null,
	login_usuario varchar(20) not null,
	senha_usuario varchar(10) not null,
	email_usuario varchar(30) not null,
	pais_usuario char(2),
	cel_usuario varchar(13),
	icon_usuario varbinary(max),
	data_criacao date not null,
	profissao varchar(20),
	img_comprovante1 varbinary(max),
	img_comprovante2 varbinary(max),
	data_nasc date,
	genero varchar(10),
	desc_perfil_usuario varchar(150),
	primary key (cod_usuario),
	foreign key (cod_tipo) references tipo_usuario
);

create table tblPost
(
	cod_post int identity,
	cod_usuario int,
	titulo_post varchar(300) not null,
	img_post1 varbinary(max),
	img_post2 varbinary(max),
	descricao_post varchar(100),
	curtidas_post int,
	comentarios_post int,
	data_post datetime not null,
	verificado bit default 0 not null,
	primary key (cod_post),
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
	id_usuario_seguido int not null,
	primary key (indice_segui),
	foreign key (id_usuario_seguidor) references tblUsuario,
	foreign key (id_usuario_seguido) references tblUsuario
);

