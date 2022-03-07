RSpec.describe '/api/books' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all books' do
      book = create(:book)

      get api_books_path

      expect(response_hash).to eq(
        [
          {
            author_id: book.author_id,
            created_at: book.created_at.iso8601(3),
            description: book.description,
            id: book.id,
            publish_date: book.publish_date,
            rating: book.rating,
            title: book.title,
            updated_at: book.updated_at.iso8601(3)
          }
        ]
      )
    end
  end

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an book' do
        book = create(:book)

        get api_book_path(book)

        expect(response_hash).to eq(
          {
            author_id: book.author_id,
            created_at: book.created_at.iso8601(3),
            description: book.description,
            id: book.id,
            publish_date: book.publish_date,
            rating: book.rating,
            title: book.title,
            updated_at: book.updated_at.iso8601(3)
          }
        )
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_book_path(-1)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:author) { create(:author) }
      let(:params) do
        {
          description: 'It was the best of times',
          title: 'War and Peace',
          author_id: author.id
        }
      end

      it 'creates a book' do
        expect { post api_books_path, params: params }.to change { Book.count }
      end

      it 'returns the created book' do
        post api_books_path, params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          description: 'It was the best of times',
          title: 'War and Peace',
          author_id: -1
        }
      end

      it 'returns an error' do
        post api_books_path, params: params

        expect(response_hash).to eq(
          {
            errors: ['Author must exist']
          }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:book) { create(:book) }

    context 'when successful' do
      let(:params) do
        {
          description: 'I do not like green eggs and ham'
        }
      end

      it 'updates an existing book' do
        put api_book_path(book), params: params

        expect(book.reload.description).to eq(params[:description])
      end

      it 'returns the updated book' do
        put api_book_path(book), params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          description: ''
        }
      end

      it 'returns an error' do
        put api_book_path(book), params: params

        expect(response_hash).to eq(
          {
            errors: ['Description can\'t be blank']
          }
        )
      end
    end
  end
end