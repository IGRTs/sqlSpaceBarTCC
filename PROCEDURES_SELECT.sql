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
-- verifica se o seguidor_alvo ja está sendo seguindo pelo usuário logado
CREATE PROCEDURE VerifyIfUserIsAlreadyBeingFollowed
    @usuario_seguidor int,
    @usuario_alvo int
AS
    -- verifica se o usuario seguidor (logado) segue o usuario alvo (perfil desejado) --
    SELECT COUNT(id_usuario_seguidor) FROM tblSeguidores WHERE id_usuario_alvo = @usuario_alvo AND id_usuario_seguidor = @usuario_seguidor
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
/*Create procedure SelectCodTipo */
Create procedure SelectCodTipo
@codUsuarioConectado int
as
begin
	select cod_tipo
	from tblUsuario
	WHERE cod_usuario = @codUsuarioConectado
end