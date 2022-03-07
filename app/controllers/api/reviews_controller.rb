module API
  class ReviewsController < ApplicationController
    before_action :set_reviewable, only: %i[index create]

    def index
      filter_service = FilterReviews.new(
        @reviewable,
        index_params[:sort_by],
        index_params[:order],
        index_params[:description_only]
      )
      reviews = filter_service.run

      render json: { reviews: reviews }, status: :ok
    end

    def create

      review = @reviewable.reviews.new(review_params)

      if review.save
        render json: { message: "success" }, status: :ok
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_reviewable
      @reviewable = Book.find_by(id: index_params[:book_id]) || Author.find_by(id: index_params[:author_id])

      raise ActiveRecord::RecordNotFound unless @reviewable
    end

    def index_params
      params.permit(
        :book_id,
        :author_id,
        :description_only,
        :sort_by,
        :order
      )
    end

    def review_params
      params.permit(
        :user_id,
        :rating,
        :description
      )
    end
  end
end
