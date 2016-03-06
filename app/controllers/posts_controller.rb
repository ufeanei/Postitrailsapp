class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote] # set_point runs before any action in this controller.  
                                                          #Without the only section,index and new will have trouble

  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
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
    @post.user = current_user
    
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

  def vote
   #@post = Post.find(params[:id]) this is already in before action so just include vote in that before action to take care of setting this @post instance
   # also always check whether any new action require the login before action. yes we want this to require a logged in before action. if not we except it.
    vote= Vote.create(voteable: @post, user: current_user, vote: params[:vote])
    if vote.valid?
      flash[:notice] = 'Your vote was counted'
    else
      flash[:error] = 'You have voted already for this'
    end

    
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id]) # commented code for setting object in show, edit update placed here. #this is then put in the before action. 
  end

end