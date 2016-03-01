class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #@comment = Comment.new(params.require(:comment).permit(:body)). this can build the object with associations and insert the foreign key
   
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = User.first




    

    if @comment.save
      
      flash[:notice] = " your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end