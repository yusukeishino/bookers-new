class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = current_user
    @book = Book.find(params[:id])
    render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end
  
  def index
    @books = Book.all
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  private
  
  def book_params
    params.permit(:title, :body)
  end
  
end
