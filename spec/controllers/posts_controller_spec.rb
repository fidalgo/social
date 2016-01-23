require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all posts as @posts' do
      posts = FactoryGirl.create_list(:post, 100)
      get :index
      expect(assigns(:posts)).to eq(posts)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = FactoryGirl.create(:post)
      get :show, id: post.to_param
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect do
          post :create, post: FactoryGirl.attributes_for(:post)
        end.to change(Post, :count).by(1)
      end

      it 'assigns a newly created post as @post' do
        post :create, post: FactoryGirl.attributes_for(:post)
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it 'returns the created status code' do
        post :create, post: FactoryGirl.attributes_for(:post)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved post as @post' do
        post :create, post: FactoryGirl.attributes_for(:post, media: '', content: '')
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'returns unprocessable entity status code' do
        post :create, post: FactoryGirl.attributes_for(:post, media: '', content: '')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { content: Faker::Hipster.sentence }
      end

      it 'updates the requested post' do
        post = FactoryGirl.create(:post)
        put :update, id: post.to_param, post: new_attributes
        post.reload
        expect(post).to have_attributes(new_attributes)
      end

      it 'assigns the requested post as @post' do
        post = FactoryGirl.create(:post)
        put :update, id: post.to_param, post: new_attributes
        expect(assigns(:post)).to eq(post)
      end

      it 'returns the no_content status code' do
        post = FactoryGirl.create(:post)
        put :update, id: post.to_param, post: new_attributes
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { content: '', media: '' }
      end
      it 'assigns the post as @post' do
        post = FactoryGirl.create(:post)
        put :update, id: post.to_param, post: invalid_attributes
        expect(assigns(:post)).to eq(post)
      end

      it 'returns unprocessable entity status code' do
        post = FactoryGirl.create(:post)
        put :update, id: post.to_param, post: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post = FactoryGirl.create(:post)
      expect do
        delete :destroy,  id: post.to_param
      end.to change(Post, :count).by(-1)
    end

    it 'returns the no_content status code' do
      post = FactoryGirl.create(:post)
      delete :destroy, id: post.to_param
      expect(response).to have_http_status(:no_content)
    end
  end
end
