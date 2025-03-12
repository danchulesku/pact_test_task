# frozen_string_literal: true

describe 'users#create', openapi: { tags: %w[User] }, type: :request do
  subject(:make_request) { post '/users', params: params, as: :json }

  let(:params) do
    {
      data: {
        name: 'John', patronymic: 'Galt', email: 'test@email.com', nationality: 'american',
        country: 'usa', gender: 'male', surname: '', age: 30, interests: %w[money cars], skills: %w[work driving]
      }
    }
  end

  it 'returns response with 201 status' do
    make_request
    expect(response).to have_http_status(:created)
    expect(response.parsed_body['user']).to eq(User.first.as_json)
  end

  context 'when invalid parameters are given' do
    before { params[:data][:name] = nil }

    it 'returns response with 422 status' do
      make_request
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']).to eq({ 'name' => ['is required'] })
    end
  end
end
