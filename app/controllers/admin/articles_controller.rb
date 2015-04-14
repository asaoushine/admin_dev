class Admin::ArticlesController < AuthorizedController
	
	include AddBreadcrumbs

	before_action :set_article, only: [:show, :edit, :update, :destroy, :publish, :draft]

	def index
		@articles = Article.all
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
		  case params[:arg]
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

	def publish
	  @article.publish!
	  flash[:success] = '記事を公開しました。'
	  redirect_to [:admin, @article]
	end

	def draft
	  @article.draft!
	  flash[:success] = '記事を下書きにしました。'
	  redirect_to [:admin, @article]
	end

	def update
	  @article.assign_attributes(article_params)
	  if @article.valid?
	  	@article.save!
	  	flash[:success] = '記事を更新しました！'
	  	redirect_to [:admin, @article]
	  else
	  	render :edit
	  end
	end

	def destroy
	  @article.destroy
	  flash[:success] = '記事を削除しました。'
	  redirect_to admin_url
	end

	private

	  def set_article
	  	@article = Article.find(params[:id])
	  end

	  def article_params
	  	params.require(:article).permit(:title, :body, :image, :remote_image_url)
	  end



end