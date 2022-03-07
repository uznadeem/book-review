RSpec.describe '/api/users' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all users' do
      user = create(:user)

      get api_users_path

      expect(response_hash).to eq(
        [
          {
            created_at: user.created_at.iso8601(3),
            first_name: user.first_name,
            last_name: user.last_name,
            id: user.id,
            updated_at: user.updated_at.iso8601(3)
          }
        ]
      )
    end
  end

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an user' do
        user = create(:user)

        get api_user_path(user)

        expect(response_hash).to eq(
          {
            created_at: user.created_at.iso8601(3),
            first_name: user.first_name,
            last_name: user.last_name,
            id: user.id,
            updated_at: user.updated_at.iso8601(3)
          }
        )
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_user_path(-1)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:params) do
        {
          first_name: 'Harry',
          last_name: 'Potter'
        }
      end

      it 'creates an user' do
        expect { post api_users_path, params: params }.to change { User.count }
      end

      it 'returns the created user' do
        post api_users_path, params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) {}

      it 'returns an error' do
        post api_users_path, params: params

        expect(response_hash).to eq(
          {
            errors: [
              'First name can\'t be blank',
              'Last name can\'t be blank'
            ]
          }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:user) { create(:user) }

    context 'when successful' do
      let(:params) do
        {
          first_name: 'James'
        }
      end

      it 'updates an existing user' do
        put api_user_path(user), params: params

        expect(user.reload.first_name).to eq(params[:first_name])
      end

      it 'returns the updated user' do
        put api_user_path(user), params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          first_name: ''
        }
      end

      it 'returns an error' do
        put api_user_path(user), params: params

        expect(response_hash).to eq(
          {
            errors: [
              'First name can\'t be blank'
            ]
          }
        )
      end
    end
  end
end