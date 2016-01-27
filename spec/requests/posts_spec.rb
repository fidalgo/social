require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /posts' do
    it 'lists posts' do
      FactoryGirl.create_list(:post, 100)
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(Post.page(1).count)
    end
  end

  describe 'GET /posts/:id' do
    it 'show post' do
      post = FactoryGirl.create(:post)
      get post_path(post)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /posts' do
    it 'creates post' do
      post = FactoryGirl.attributes_for(:post)
      post posts_path, post: post
      expect(response).to have_http_status(:created)
    end
    it 'returns error on invalid post' do
      post = FactoryGirl.attributes_for(:post, media: '', content: '')
      post posts_path, post: post
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /posts' do
    it 'updates post' do
      post = FactoryGirl.create(:post)
      patch post_path(post), post: { content: Faker::Hipster.sentence }
      expect(response).to have_http_status(:no_content)
    end
    it 'returns error on invalid post' do
      post = FactoryGirl.create(:post, media: '')
      patch post_path(post), post: { content: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /postr/:id' do
    it 'delete post' do
      post = FactoryGirl.create(:post)
      delete post_path(post)
      expect(response).to have_http_status(:no_content)
    end
  end
end
