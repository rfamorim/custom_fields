require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET new' do
    describe 'when the user is not logged in' do
      before(:each) do
        get :new
      end

      it 'should return 200' do
        expect(response.status).to eq(200)
      end

      it 'should set the @user' do
        expect(assigns(:user)).not_to be_nil
        expect(assigns(:user).class).to eq(User)
      end

      it 'should render the new view' do
        expect(response).to render_template(:new)
      end
    end

    describe 'when the user is logged in' do
      before(:each) do
        sign_in(@user = FactoryGirl.create(:user))
        get :new
      end

      after(:each) do
        sign_out @user
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should not render the new view' do
        expect(response).not_to render_template(:new)
      end

      it 'should not set the @user' do
        expect(assigns(:user)).to be_nil
        expect(assigns(:user).class).not_to eq(User)
      end

      it 'should set the right current_user' do
        expect(controller.current_user).not_to be_nil
      end
    end
  end

  describe 'POST create' do
    describe 'when the user is not logged in' do
      before(:each) do
        attributes = FactoryGirl.attributes_for(:user)
        @user = User.create(attributes)

        post :create, user: attributes
      end

      it 'should redirect' do
        expect(response.status).to eq(302)
      end

      it 'should set the right current_user' do
        expect(controller.current_user).not_to be_nil
        expect(controller.current_user.class).to eq(User)
      end
    end

    describe 'when the user is logged in' do
      before(:each) do
        sign_in(@user = FactoryGirl.create(:user))
        post :create
      end

      after(:each) do
        sign_out @user
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should set the right current_user' do
        expect(controller.current_user).not_to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'when the user is not logged in' do
      before(:each) do
        delete :destroy
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should set the right current_user' do
        expect(controller.current_user).to be_nil
      end

      it 'should not render the new view' do
        expect(response).not_to render_template(:new)
      end

      it 'should not set the @user' do
        expect(assigns(:user)).to be_nil
        expect(assigns(:user).class).not_to eq(User)
      end
    end

    describe 'when the user is logged in' do
      before(:each) do
        sign_in(@user = FactoryGirl.create(:user))
        delete :destroy
      end

      after(:each) do
        sign_out @user
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should set the right current_user' do
        expect(controller.current_user).to be_nil
      end

      it 'should not set the @user' do
        expect(assigns(:user)).to be_nil
        expect(assigns(:user).class).not_to eq(User)
      end
    end
  end
end