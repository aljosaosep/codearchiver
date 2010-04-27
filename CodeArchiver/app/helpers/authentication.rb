module Authentication
   # vrne TRUE, ce je se ujema id in id sranjen v session
   # vhod: id... id reference objave, session... teh session :)
   def isCurrentUserAuthor(id, session)
	return id == session # TODO: if admin naj bo tudi true
   end

  # vrne TRUE, ce je se ujema id in id sranjen v session
   # vhod: id... id reference objave, session... teh session :)
   def isCurrentUserAuthorOrAdmin(id, session)

	return id == session || User.find(session).group == 1 # TODO: if admin naj bo tudi true
   end

   # vrne TRUE, ce je trenutni user v admin group
   # vhod: id... id reference objave
   def isCurrentUserAdmin(id)
	@user = User.find(id)
        return @user.group == 1
   end
end
