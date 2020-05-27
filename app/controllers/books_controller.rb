class BooksController < ApplicationController

 before_action :correct_user, only: [:edit, :update]
#URL直打ち防止（上記before_actionとセット）
def correct_user
	  book = Book.find(params[:id])
   if book.user != current_user
      redirect_to books_path
    end
end

  def index
  	@books = Book.all
  	@book = Book.new
  	@users = User.all
  	@user = current_user
  end

  def create
  	@book = Book.new(book_params)
  	@user = current_user
  	@book.user_id = current_user.id
  	#上記いれないと3errorsになってしまう
  	 if @book.save
  		flash[:notice] = "You have creatad book successfully."
  		redirect_to book_path(@book.id) #book detailへ遷移
  	else
  		@books = Book.all
		render :index
  	end
  end

  def show
  	@book_new = Book.new
  	@book = Book.find(params[:id])
  	# 上記のbookに紐づくuserを下記で引っ張ってくる
  	@user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	@book.update(book_params)

  	if @book.update(book_params)
  		flash[:notice] = "You have updated book successfully."
  		redirect_to book_path(@book.id)
  	else
  		render :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	if book.destroy
  		redirect_to user_path(current_user)
  	else
  		render :edit
  	end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
