class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    comment_limit = 3

    if params[:tag]
      posts = Post.tagged_with(params[:tag])
    else
      posts = Post.all
    end

    query = "( SELECT * from comments where id = -1 limit #{comment_limit} )"
    post_ids=[]
    posts.each do |p|
	    query += " UNION ALL (SELECT * from comments where commentable_id = #{p.id} and commentable_type = 'Post' ORDER BY created_at DESC limit #{comment_limit} )"
    end
    comments = Comment.find_by_sql query
    @posts = posts.map{ |p| {post_record: p, comments: comments.select{|c| c.commentable_id == p.id} } }

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
	  @comments = Post.find(params[:id]).comments
	  @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list)
    end
end
