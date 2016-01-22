require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'assigns all users as @users' do
      user_list = FactoryGirl.create_list(:user, 10)
      get :index
      expect(assigns(:users)).to eq(user_list)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = FactoryGirl.create(:user)
      get :show, id: user.to_param
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, user: FactoryGirl.attributes_for(:user)
        end.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'returns the created status code' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, user: FactoryGirl.attributes_for(:user, name: '')
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'returns unprocessable entity status code' do
        post :create, user: FactoryGirl.attributes_for(:user, name: '')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: Faker::Name.name }
      end

      it 'updates the requested user' do
        user = FactoryGirl.create(:user)
        put :update, id: user.to_param, user: new_attributes
        user.reload
        expect(user).to have_attributes(new_attributes)
      end

      it 'assigns the requested user as @user' do
        user = FactoryGirl.create(:user)
        put :update, id: user.to_param, user: new_attributes
        expect(assigns(:user)).to eq(user)
      end

      it 'returns the no_content status code' do
        user = FactoryGirl.create(:user)
        put :update, id: user.to_param, user: new_attributes
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '' }
      end
      it 'assigns the user as @user' do
        user = FactoryGirl.create(:user)
        put :update, id: user.to_param, user: invalid_attributes
        expect(assigns(:user)).to eq(user)
      end

      it 'returns unprocessable entity status code' do
        user = FactoryGirl.create(:user)
        put :update, id: user.to_param, user: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = FactoryGirl.create(:user)
      expect do
        delete :destroy, id: user.to_param
      end.to change(User, :count).by(-1)
    end

    it 'returns the no_content status code' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: user.to_param
      expect(response).to have_http_status(:no_content)
    end
  end
end
