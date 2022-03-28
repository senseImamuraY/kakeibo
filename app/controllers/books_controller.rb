class BooksController < ApplicationController

    before_action :set_book, only: [:show, :edit, :update, :destroy]

    def index
        @books = Book.all
            @books = @books.where(year:params[:year])if params[:year].present?
            @books = @books.where(month:params[:month])if params[:month].present?
        # end
    end

    def show
        # @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
    end

    def create
        book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
        @book = Book.new(book_params)
        if @book.save
            flash[:notice] = "家計簿にデータを1件登録しました"
            redirect_to books_path
        else
            flash.now[:alert] = "登録に失敗しました"
            render:new
        end
    end

    def edit
        # @book = Book.find(params[:id])
    end

    def update
        # @book = Book.find(params[:id])
        book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
        if @book.update(book_params)
            flash[:notice] = "データを1件更新しました"
            redirect_to books_path
        else
            flash.now[:alert] = "更新に失敗しました"
            render :edit
        end
    end

    def destroy
        # @book = Book.find(params[:id])
        @book.destroy
        flash[:notice] = "削除しました"
        redirect_to books_path
    end


    private

        def set_book
            @book = Book.find(params[:id])
        end


end
