class AdminController < AuthorizedController

	def show
		@articles = current_user.articles
	end

end