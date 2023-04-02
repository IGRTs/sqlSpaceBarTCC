CREATE DATABASE SpaceBar
GO
USE SpaceBar
GO
create table tblUsuario
(
    cod_usuario         int identity
        primary key,
    cod_tipo            int
        references tipo_usuario,
    nome_usuario        varchar(30) not null,
    login_usuario       varchar(20) not null,
    senha_usuario       varchar(10) not null,
    email_usuario       varchar(30) not null,
    pais_usuario        char(2),
    cel_usuario         varchar(13),
    icon_usuario        varbinary(max),
    data_criacao        date        not null,
    profissao           varchar(20),
    img_comprovante1    varbinary(max),
    img_comprovante2    varbinary(max),
    data_nasc           date,
    genero              varchar(10),
    desc_perfil_usuario varchar(150)
)
go
SET IDENTITY_INSERT tblUsuario ON;
go
INSERT INTO SpaceBar.dbo.tblUsuario (cod_tipo, nome_usuario, login_usuario, senha_usuario, email_usuario, pais_usuario, cel_usuario, icon_usuario, data_criacao, profissao, img_comprovante1, img_comprovante2, data_nasc, genero, desc_perfil_usuario) VALUES (27, null, N'IgorTeo', N'igor_teo', N'123456', N'igor.teodoro@outlook.com.br', N'br', N'5511955925102', null, N'2023-03-14', N'Programador', null, null, N'2006-03-02', N'fluid', N'Desenvolvedor da SpaceBar!');
INSERT INTO SpaceBar.dbo.tblUsuario (cod_tipo, nome_usuario, login_usuario, senha_usuario, email_usuario, pais_usuario, cel_usuario, icon_usuario, data_criacao, profissao, img_comprovante1, img_comprovante2, data_nasc, genero, desc_perfil_usuario) VALUES (28, null, N'Clara', N'clara_ven', N'123456', N'clarasanson@outlook.com', N'br', N'5511990141476', null, N'2023-03-21', N'Programadora', null, null, N'2005-05-25', N'fluid', N'Desenvolvedora da SpaceBar!');
INSERT INTO SpaceBar.dbo.tblUsuario (cod_tipo, nome_usuario, login_usuario, senha_usuario, email_usuario, pais_usuario, cel_usuario, icon_usuario, data_criacao, profissao, img_comprovante1, img_comprovante2, data_nasc, genero, desc_perfil_usuario) VALUES (29, null, N'Pedro', N'Pedro_Polvi', N'123456', N'pedro_polvidaiko@outlook.com', N'br', N'5511949400597', null, N'2023-03-29', N'programador', null, null, null, N'cis', N'Desenvolvedor da SpaceBar!');
INSERT INTO SpaceBar.dbo.tblUsuario (cod_tipo, nome_usuario, login_usuario, senha_usuario, email_usuario, pais_usuario, cel_usuario, icon_usuario, data_criacao, profissao, img_comprovante1, img_comprovante2, data_nasc, genero, desc_perfil_usuario) VALUES (30, null, N'Marcoli', N'Igor_Marcoli', N'123456', N'igor_marcoli@outlook.com', N'br', N'5511994434106', null, N'2023-03-29', N'programador', null, null, null, N'cis', N'Desenvolvedor da SpaceBar!');
go
create table tblPost
(
    cod_post         int identity
        primary key,
    cod_usuario      int
        references tblUsuario,
    titulo_post      varchar(300)  not null,
    img_post1        varbinary(max),
    img_post2        varbinary(max),
    descricao_post   varchar(100),
    curtidas_post    int,
    comentarios_post int,
    data_post        datetime      not null,
    verificado       bit default 0 not null
)
go
SET IDENTITY_INSERT tblPost ON;
go
INSERT INTO SpaceBar.dbo.tblPost ( cod_usuario, titulo_post, img_post1, img_post2, descricao_post, curtidas_post, comentarios_post, data_post, verificado) VALUES (5, 27, N'Inspirado na obra de Van Gogh “A noite estrelada” criam jogo de astros sobre', null, null, null, null, null, N'2023-03-15 22:24:05.000', 1);
INSERT INTO SpaceBar.dbo.tblPost ( cod_usuario, titulo_post, img_post1, img_post2, descricao_post, curtidas_post, comentarios_post, data_post, verificado) VALUES (6, 27, N'Betelgeuse está destinada a virar supernova...', null, null, null, null, null, N'2023-03-15 22:24:05.000', 1);
INSERT INTO SpaceBar.dbo.tblPost ( cod_usuario, titulo_post, img_post1, img_post2, descricao_post, curtidas_post, comentarios_post, data_post, verificado) VALUES (7, 29, N'Kerbal Space Program 2 está em beta aberta!', null, null, null, null, null, N'2023-03-21 19:55:43.000', 1);
INSERT INTO SpaceBar.dbo.tblPost ( cod_usuario, titulo_post, img_post1, img_post2, descricao_post, curtidas_post, comentarios_post, data_post, verificado) VALUES (8, 30, N'Colisão entre a galáxia de Andromeda e a via lactea???', null, null, null, null, null, N'2023-03-27 17:03:31.000', 0);
go
create table tblSeguidores
(
    indice_segui        int identity
        primary key,
    id_usuario_seguidor int not null
        references tblUsuario,
    id_usuario_seguido  int not null
        references tblUsuario
)
go
SET IDENTITY_INSERT tblSeguidores ON;
go
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (1, 27, 28);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (2, 28, 27);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (3, 27, 29);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (4, 27, 30);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (5, 28, 29);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (6, 28, 30);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (7, 29, 27);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (8, 29, 28);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (9, 29, 30);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (10, 30, 27);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (11, 30, 28);
INSERT INTO SpaceBar.dbo.tblSeguidores ( id_usuario_seguidor, id_usuario_seguido) VALUES (12, 30, 29);
go
create table tipo_usuario
(
    cod_tipo  int identity
        primary key,
    descricao varchar(30)
)
go
SET IDENTITY_INSERT tipo_usuario ON;
go
INSERT INTO SpaceBar.dbo.tipo_usuario ( descricao) VALUES (1, N'Usuário comum');
INSERT INTO SpaceBar.dbo.tipo_usuario ( descricao) VALUES (2, N'Criador de conteúdo');
INSERT INTO SpaceBar.dbo.tipo_usuario ( descricao) VALUES (3, N'Verificado');
INSERT INTO SpaceBar.dbo.tipo_usuario ( descricao) VALUES (4, N'ADM');
go
create table tblDenuncia
(
    cod_denuncia          int identity
        primary key,
    usuario_denunciado    int,
    post_denunciado       int,
    comentario_denunciado int,
    motivo                varchar(255)                   not null,
    status_denuncia       varchar(20) default 'pendente' not null
        check ([status_denuncia] = 'ignorado' OR [status_denuncia] = 'resolvido' OR [status_denuncia] = 'pendente'),
    data_denuncia         date                           not null
)
go
create table tblComentarios
(
    cod_comentario      int identity
        primary key,
    cod_post            int
        references tblPost,
    cod_usuario         int
        references tblUsuario,
    conteudo_comentario varchar(200) not null,
    data_comentario     datetime     not null
)