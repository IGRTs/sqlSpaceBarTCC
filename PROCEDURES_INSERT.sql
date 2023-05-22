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
CREATE PROCEDURE FollowUser
    @usuario_seguidor int,
    @usuario_alvo int
AS
    INSERT INTO tblSeguidores (id_usuario_seguidor,id_usuario_alvo) VALUES (@usuario_seguidor, @usuario_alvo)
GO
CREATE PROCEDURE AddLike
    @postId int,
    @userId int
AS
    INSERT INTO tblPostagemCurtidas (tblPostagemCurtidas_cod_post, tblPostagemCurtidas_cod_usuario) VALUES (@postId, @userId)
GO