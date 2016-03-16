class UsersController < ApplicationController
#before_action :set_user
before_action :correct_user, only:[:edit,:update]
  def show
   @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
    	redirect_to @user
      flash[:success] = "Welcome to the Sample App!"
    else
      render 'new'
    end
  end
  def edit
  end
  def update
  	if @user.update_attributes(user_params)
  		flash[:success] = "Profile Updated"
  		redirect_to @user
  	else
  	  render 'edit'
    end
  end
  private
  def set_user
  	@user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :screen_name, :bio, :location)
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end	
end
