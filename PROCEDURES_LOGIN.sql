create procedure spacelogin
	@loguser varchar(20),
	@senhauser varchar(10)


	As
	Begin
		Select * from tblUsuario where login_usuario = @loguser and senha_usuario=@senhauser
END