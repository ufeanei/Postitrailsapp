class UsersController < ApplicationController
  before_action :set_user, only: [:edit,:show, :update]

  before_action :require_same_user, only: [:edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]= @user.id
      flash[:notice] = 'you are now registered'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    #@user = User.find(params[:id]) extracted to before action 
  end

  def show
    #@user = User.find(params[:id]) extracted to before action 
  end

  def update
    #@user = User.find(params[:id]) extracted to before action 
    if @user.update(user_params)
      flash[:notice] = " Your profile was update"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = " you are not allowed to do that"
      redirect_to root_path
    end

  end

  
end
