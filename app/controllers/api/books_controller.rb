module API
  class BooksController < ApplicationController
    def create
      book = Book.new(allowed_params)

      if book.save
        render json: book
      else
        render json: { errors: book.errors.full_messages }
      end
    end

    def index
      render json: Book.all
    end

    def show
      render json: Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])

      if book.update(allowed_params)
        render json: book
      else
        render json: { errors: book.errors.full_messages }
      end
    end

    private

    def allowed_params
      params.permit(
        :author_id,
        :description,
        :publish_date,
        :rating,
        :title
      )
    end
  end
end