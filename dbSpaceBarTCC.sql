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
	senha_usuario varchar(100),
	email_usuario varchar(30),
	pais_usuario varchar(30),
	cel_usuario varchar(13),
	icon_usuario varbinary(max),
	imgfundo_usuario varbinary (max),
	data_criacao date not null,
	bio_usuario varchar(150),

	/*verificado*/
	profissao varchar(20),
	img_comprovante varbinary (max),
	img_comprovante2 varbinary (max),

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

insert into tipo_usuario(cod_tipo,descricao) values(1, 'Usuario comum')
insert into tipo_usuario(cod_tipo,descricao) values(2, 'Criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(3, 'Verificado')
insert into tipo_usuario(cod_tipo,descricao) values(4, 'Verificado/criador de conteúdo')
insert into tipo_usuario(cod_tipo,descricao) values(5, 'ADM')

select * from tipo_usuario



create table tblPostagemCurtidas
(
    tblPostagemCurtidas_cod_usuario int,

    tblPostagemCurtidas_cod_post int,
    foreign key (tblPostagemCurtidas_cod_usuario) references tblUsuario,
    foreign key (tblPostagemCurtidas_cod_post) references tblPost



);


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


/*Create procedure SelectCodTipo */
Create procedure SelectCodTipo
@codUsuarioConectado int
as
begin
	select cod_tipo
	from tblUsuario
	WHERE cod_usuario = @codUsuarioConectado
end


select * from tblUsuario

Update tblUsuario set cod_tipo=3 where cod_usuario=7

Delete from tblUsuario where cod_usuario = 11
