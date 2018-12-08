class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.create user_params
    if user.persisted?
      session[:user_id] = user.id
      redirect_to user_path user.id
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
      @comment = Comment.find params[:id]
      unless @comment.user == @current_user  #check if user id associated with comment, is the same as the currnet user
        flash[:error] = "You must be the owner of this comment to edit."
        redirect_to conflict_path(@comment.conflict_id)
      end

    end

    def update
      @comment = Comment.find params[:id]  #find comment
      @comment.update comment:params[:comment][:comment ]  #actual comment is a hash within a hash
      redirect_to conflict_path(@comment.conflict_id)

    end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
