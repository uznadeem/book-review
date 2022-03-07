RSpec.describe '/api/books' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all books' do
      review = create(:review)

      get api_book_reviews_path(review.reviewable_id)

      expect(response_hash).to eq(
        {
          reviews: [
            {
              created_at: review.created_at.iso8601(3),
              description: review.description,
              id: review.id,
              rating: review.rating,
              reviewable_id: review.reviewable_id,
              reviewable_type: review.reviewable_type,
              updated_at: review.updated_at.iso8601(3),
              user_id: review.user_id
            }
          ]
        }
      )
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }
      let(:params) do
        {
          rating: 4,
          description: 'It was the best of times',
          user_id: user.id
        }
      end

      it 'creates a review' do
        expect { post api_book_reviews_path(book.id, params: params) }.to change { Review.count }
      end

      it 'returns the success message' do
        post api_book_reviews_path(book.id), params: params

        expect(response_hash).to eq({message: "success"})
      end
    end

    context 'when unsuccessful' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }
      let(:params) do
        {
          rating: 7,
          description: 'It was the best of times',
          user_id: user.id
        }
      end

      it 'returns an error' do
        post api_book_reviews_path(book.id), params: params

        expect(response_hash).to eq(
          {
            errors: ['Rating rating should be in range of 1..5']
          }
        )
      end
    end
  end
end
