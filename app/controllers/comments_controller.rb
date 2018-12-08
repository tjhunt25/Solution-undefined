class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :cors_allow

  def show
  end

  def index
    @comments = Comment.all
    respond_to do |format|

      format.html # show.html.erb
      format.json { render json: @comments }

    end #respond to
  end

  def edit

      @comment = Comment.find params[:id]
      @solution = @comment.solution
      unless @comment.user == @current_user  #check if user id associated with comment, is the same as the currnet user
        flash[:error] = "You must be the owner of this comment to edit."
        redirect_to solution_path(solution)
      end
    end

    def update
      @comment = Comment.find params[:id]  #find comment
      @comment.update comment_params[:comments]  #actual comment is a hash within a hash
      redirect_to solution_path(solution)
    end

  def new
  end

  def create
    # @comment = Comment.create({body:params[:body]})
    # # @comment = Comment.new({body:params[:body]})
    # @comment.user_id = @current_user.id
    # @comment.save
    #
    # if @comment.persisted?
    #   solution = Solution.find params[:solution_id]
    #   solution.comments << @comment
    #   solution.save
    #   redirect_to solution_path(solution)
    # end

    comment = Comment.create(
      body:params[:body],
      user: @current_user,
      solution_id: params[:solution_id]
    )

    render json: comment, include: 'user'
  end

  def destroy
    @comment = Comment.find params[:id]
    unless @comment.user == @current_user
      flash[:error] = "You must be the owner of this comment to delete."
      redirect_to solution_path(@comment.solution_id)
      return
    end
    @comment.destroy
    redirect_to solution_path(@comment.solution_id)
  end

  private
  def comment_params
    params.require(:comments).permit(:body)
  end

  def cors_allow
    headers['Access-Control-Allow-Origin'] = '*';
  end

end
