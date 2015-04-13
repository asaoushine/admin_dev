class Admin::ArticleController < AuthorizedController
	
	include AddBreadcrumbs

	before_action :set_article, only: [:show, :edit, :update, :destroy, :publish, :draft]

	def index
		@articles = current_user.articles.all
	end

	# GET /articles/1
	def show
		add_breadcrumb @article.title
	end

	def new
		@article = Article.new
	end

	def edit
		add_breadcrumb @article.title, [:home, @article]
		add_breadcrumb '編集'
	end

	def create
		@article = current_user.articles.build(article_params)

		if @article.valid?
		  @article.save!
		  case params[:hoge][:fuga]
		  when 'publish'
		  	@article.publish!
		  	flash[:success] = '記事を公開しました。'
		  when 'save'
		  	flash[:success] = '記事を保存しました。'
		  else
		  	raise
		  end
		  redirect_to [:admin, @article]
		else
			render :new
		end
	end

	private

	  def set_article
	  	@article = current_user.articles.find(params[:id])
	  end

	  def article_params
	  	params.require(:article).permit(:title, :body, :image, :remote_image_url)
	  end



end