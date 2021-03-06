require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user_test = FactoryGirl.create(:user)
    @contact_test = FactoryGirl.create(:contact, user: @user_test)
  end

  after(:each) do
    sign_out @user_test
    @user_test.destroy
    @contact_test.destroy
  end

  describe 'GET index' do
    before(:each) do
      get :index
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should return the right resource' do
      expect(assigns(:contacts).to_a).to eq([@contact_test])
    end

    it 'should render the right view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    before(:each) do
      get :new
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should return the right resource' do
      expect(assigns(:contact)).not_to be_nil
      expect(assigns(:contact)).to be_a Contact
    end

    it 'should render the right view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create with correct attributes' do
    before(:each) do
      post :create, contact: FactoryGirl.attributes_for(:contact, user_id: @user_test.id)
    end

    it 'should return 302' do
      expect(response.status).to eq(302)
    end

    it 'should set the right resource' do
      expect(assigns(:contact)).not_to be_nil
    end

    it 'should redirect to the resource' do
      expect(response).to redirect_to(contacts_path)
    end
  end

  describe 'POST create with correct attributes' do
    it 'should create an Contact' do
      expect do
        post :create, contact: FactoryGirl.attributes_for(:contact, user_id: @user_test.id)
      end.to change {
        Contact.count
      }.by(1)
    end
  end

  describe 'POST create with incorrect attributes' do
    before(:each) do
      post :create, contact: FactoryGirl.attributes_for(:contact, email: nil)
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should set the right resource' do
      expect(assigns(:contact)).not_to be_nil
    end

    it 'should render the right view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create with incorrect attributes' do
    it 'should create an Contact' do
      expect do
        post :create, contact: FactoryGirl.attributes_for(:contact, email: nil)
      end.to change {
        Contact.count
      }.by(0)
    end
  end

  describe 'GET edit' do
    before(:each) do
      get :edit, id: @contact_test.id
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should return the right resource' do
      expect(assigns(:contact)).to eq(@contact_test)
    end

    it 'should render the right view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      before(:each) do
        @new_attributes = { name: 'Novo Nome.', email: 'novo@email.com' }
        patch :update, id: @contact_test.id, contact: @new_attributes
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should return the right resource' do
        expect(assigns(:contact)).to eq(@contact_test)
      end

      it 'should change the contact name' do
        expect(assigns(:contact).reload.name).to eq(@new_attributes[:name])
      end

      it 'should change the contact email' do
        expect(assigns(:contact).reload.email).to eq(@new_attributes[:email])
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        @new_attributes = { name: nil, email: nil }
        patch :update, id: @contact_test.id, contact: @new_attributes
      end

      it 'should return 200' do
        expect(response.status).to eq(200)
      end

      it 'should return the right resource' do
        expect(assigns(:contact)).to eq(@contact_test)
      end

      it 'should set errors on the contact' do
        expect(assigns(:contact).errors).not_to be_blank
      end

      it 'should render the right view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      delete :destroy, id: @contact_test.id
    end

    it 'should return 302' do
      expect(response.status).to eq(302)
    end

    it 'should set the right variables' do
      expect(assigns(:contact)).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'should destroy an Contact' do
      expect do
        delete :destroy, id: @contact_test.id
      end.to change {
        Contact.count
      }.by(-1)
    end
  end
end
