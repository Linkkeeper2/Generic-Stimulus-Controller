class AuthorsController < ApplicationController
  before_action :set_book
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET books/1/authors
  def index
    @authors = @book.authors
  end

  # GET books/1/authors/1
  def show
  end

  # GET books/1/authors/new
  def new
    @author = @book.authors.build
  end

  # GET books/1/authors/1/edit
  def edit
  end

  # POST books/1/authors
  def create
    @author = @book.authors.build(author_params)

    if @author.save
      redirect_to([@author.book, @author], notice: 'Author was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT books/1/authors/1
  def update
    if @author.update_attributes(author_params)
      redirect_to([@author.book, @author], notice: 'Author was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE books/1/authors/1
  def destroy
    @author.destroy

    redirect_to book_authors_url(@book)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_author
      @author = @book.authors.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      params.require(:author).permit(:name)
    end
end
