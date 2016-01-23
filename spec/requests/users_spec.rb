require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /users' do
    it 'lists users' do
      users = FactoryGirl.create_list(:user, 25)
      get users_path
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(users.size)
    end
  end

  describe 'GET /users/:id' do
    it 'show user' do
      user = FactoryGirl.create(:user)
      get user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /users' do
    it 'creates user' do
      user = FactoryGirl.attributes_for(:user)
      post users_path, user: user
      expect(response).to have_http_status(:created)
    end
    it 'returns error on invalid user' do
      user = FactoryGirl.attributes_for(:user, name: '')
      post users_path, user: user
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /users' do
    it 'updates user' do
      user = FactoryGirl.create(:user)
      patch user_path(user), user: { name: Faker::Name.name }
      expect(response).to have_http_status(:no_content)
    end
    it 'returns error on invalid user' do
      user = FactoryGirl.create(:user)
      patch user_path(user), user: { name: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /user/:id' do
    it 'delete user' do
      user = FactoryGirl.create(:user)
      delete user_path(user)
      expect(response).to have_http_status(:no_content)
    end
  end
end
