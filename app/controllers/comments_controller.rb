class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :update, :destroy, :edit]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
 #rescue_from ActiveRecord::RecordNotFound do
 #   redirect_to boards_path, notice: 'You are prohibited to do the action.'
 #end
  def show
  @comment = Comment.new
  @comment = current_user.comments.build
  @comment.user_id = current_user.id
  end
def create
  @board = Board.find(params[:board_id])
  @comment = Comment.new(params_comment)
  @comment.user_id = current_user.id
  @comment.board = @board
    #respond_to do |format|
      if @comment.save
        redirect_to board_url(@board), notice: 'commentはcreateされました!'
      else
  	    redirect_to board_url(@board), notice: '字数は4~200文字までです。'
      end
    #end
end
def edit
end
def update
  #respond_to do |format|
    if @comment.update(params_comment)
    	board = @comment.board
    	#comment = @board.comment
      redirect_to board, notice: 'コメントはupdateされました'
    else
    	render :edit
    end
  #end
end
def destroy
	#@board = Board.find(params[:id])
	#@comment = Comment.find(params[:id])
	@comment = current_user.comments.find_by(id: params[:id])
	@comment.destroy
	board = @comment.board
	  respond_to do |format|
        format.html {redirect_to board, notice: 'コメントは削除されました'}
	  end
end
private
def set_comment
  @comment = Comment.find(params[:id])
end
def params_comment
  params.require(:comment).permit(:user_id, :content)
end
  def logged_in_user
    unless logged_in?
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
    end 
  end
end
