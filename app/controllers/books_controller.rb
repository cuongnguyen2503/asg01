class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @books = Book.paginate(page: params[:page])
    respond_to do |format|

      format.html # show.html.erb
      format.xml  { render :xml => @books }      
      format.json { render json: @books }

    end      
  end

  def create
    @book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book) }
        format.xml { render xml: @book }
      else
        format.html { render action: "upload" }
        format.xml { render xml: @book }
      end
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book deleted"
    redirect_to request.referrer || root_url
  end

  def upload
    @book = current_user.books.build if logged_in?
  end

  def show
  	@book = Book.find(params[:id])
    respond_to do |format|

      format.html # show.html.erb
      format.xml  { render :xml => @book }          
      format.json { render json: @book }

    end    	
  end

  private

    def book_params
      params.require(:book).permit(:name, :author, :publisher)
    end  	

     def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to root_url if @book.nil?
    end    
end
