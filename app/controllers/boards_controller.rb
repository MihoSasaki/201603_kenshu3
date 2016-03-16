class BoardsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :update, :destroy]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
 #rescue_from ActiveRecord::RecordNotFound do
 #   redirect_to boards_path, notice: 'You are prohibited to do the action.'
 #end 
  def index
    if logged_in?
  	@boards = Board.all
  	@board = current_user.boards.build
  	@board.user_id = current_user.id
  	user_id = @board.user_id
    else
      redirect_to login_path
    end
  end
  def show
  	@comment = Comment.new
  	@comment.user_id = current_user.id
  	#@comment = current_user.comments.build
  	#comment = @board.comment
  	board = @comment.board
  end
  def new
    @board = Board.new
  end
  def edit
  end
  def create
  	@board = Board.new(params_board)
  	@board.user_id = current_user.id
    respond_to do |format|
      if @board.save
        format.html {redirect_to @board, notice: 'Boardはcreateされました!'}
      else
  	    format.html {render :new}
      end
    end
  end
  def update
    #respond_to do |format|
      if @board.update(params_board)
        redirect_to @board, notice: 'Boardはupdateされました!'
      else
  	    render :edit
      end
    #end
  end
  def destroy
  	@board.destroy
  	respond_to do |format|
        format.html {redirect_to boards_url, notice: 'Boardは削除されました!'}
    end
  end
private
  def set_board
    @board = Board.find(params[:id])
  end

  def params_board
    params.require(:board).permit(:title, :user_id)
  end
def logged_in_user
  unless logged_in?
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
    end 
  end
end