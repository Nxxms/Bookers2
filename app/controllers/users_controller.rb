class UsersController < ApplicationController


 before_action :correct_user, only: [:edit, :update]
#URL直打ち防止（上記before_actionとセット）
def correct_user
	  user = User.find(params[:id])
   unless user == current_user
      redirect_to user_path(current_user)
    end
end

  def index
  	@users = User.all
  	@book_new = Book.new
  	@user = current_user
  end

  def show
  	@user = current_user
  	# もし@user.currentにするとサイドバー が自分のuser infoになってしまう
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book_new = Book.new 
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  private 
   def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
