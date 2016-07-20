class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index

    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end

    comment_limit = 3

    query = "( SELECT * from comments where id = -1 limit #{comment_limit} )"
    @articles.each do |p|
	    query += " UNION ALL (SELECT * from comments where article_id = #{p.id} ORDER BY created_at DESC limit #{comment_limit} )"
    end
    comments = Comment.find_by_sql query
    @articlesdict = @articles.map{ |a| {article_record: a, comments: comments.select{|c| c.article_id == a.id} } }
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
	  @comments = Article.find(params[:id]).comments
	  @comment = Comment.new
	  
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
	    asd=params.require(:article)
      params.require(:article).permit(:title, :body, :tag_list)
    end
end
