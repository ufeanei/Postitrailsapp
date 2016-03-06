class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    #@comment = Comment.new(params.require(:comment).permit(:body)). this can build the object with associations and insert the foreign key
   
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user
    

    if @comment.save
      
      flash[:notice] = " your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, user: current_user, vote: params[:vote])

    if vote.valid?
      flash[:notice] = 'Your vote was counted'
    else
      flash[:error] = 'You have voted already for this'
    end

    
    redirect_to :back
  end
end