class PostsController < ApplicationController

  before_action :set_post , only: [:show, :edit, :update] # set_point runs before any action in this controller.  
                                                           #Without the only section,index and new will have trouble

  def index

    @posts = Post.all

  end

  def show

    #@post = Post.find(params[:id]) taken to before action
    @comment = Comment.new

  end

  def new
    @post = Post.new
  end

  def create
    @post =Post.new(post_params)
    
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    #@post = Post.find(params[:id]) 
  end

  def update
    #@post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "this is now updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id]) # commented code for setting object in show, edit update placed here.
                                     #this is then put in the before action. 
  end

end