require 'rails_helper'

RSpec.describe CustomFieldsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user_test = FactoryGirl.create(:user)
    @custom_field_test = FactoryGirl.create(:custom_field, user: @user_test, field_type: "textarea")
  end

  after(:each) do
    sign_out @user_test
    @user_test.destroy
    @custom_field_test.destroy
  end

  describe 'GET index' do
    before(:each) do
      get :index
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should return the right resource' do
      expect(assigns(:custom_fields).to_a).to eq([@custom_field_test])
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
      expect(assigns(:custom_field)).not_to be_nil
      expect(assigns(:custom_field)).to be_a CustomField
    end

    it 'should render the right view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create with correct attributes' do
    before(:each) do
      post :create, custom_field: FactoryGirl.attributes_for(:custom_field, field_type: "text", user_id: @user_test.id)
    end

    it 'should return 302' do
      expect(response.status).to eq(302)
    end

    it 'should set the right resource' do
      expect(assigns(:custom_field)).not_to be_nil
    end

    it 'should redirect to the resource' do
      expect(response).to redirect_to(custom_fields_path)
    end
  end

  describe 'POST create with correct attributes' do
    it 'should create an CustomField' do
      expect do
        post :create, custom_field: FactoryGirl.attributes_for(:custom_field, field_type: "text", user_id: @user_test.id)
      end.to change {
        CustomField.count
      }.by(1)
    end
  end

  describe 'POST create with incorrect attributes' do
    before(:each) do
      post :create, custom_field: FactoryGirl.attributes_for(:custom_field, field_type: nil)
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should set the right resource' do
      expect(assigns(:custom_field)).not_to be_nil
    end

    it 'should render the right view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create with incorrect attributes' do
    it 'should create an CustomField' do
      expect do
        post :create, custom_field: FactoryGirl.attributes_for(:custom_field, field_type: nil)
      end.to change {
        CustomField.count
      }.by(0)
    end
  end

  describe 'GET edit' do
    before(:each) do
      get :edit, id: @custom_field_test.id
    end

    it 'should return 200' do
      expect(response.status).to eq(200)
    end

    it 'should return the right resource' do
      expect(assigns(:custom_field)).to eq(@custom_field_test)
    end

    it 'should render the right view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      before(:each) do
        @new_attributes = { name: 'Novo Nome.', field_type: 'text' }
        patch :update, id: @custom_field_test.id, custom_field: @new_attributes
      end

      it 'should return 302' do
        expect(response.status).to eq(302)
      end

      it 'should return the right resource' do
        expect(assigns(:custom_field)).to eq(@custom_field_test)
      end

      it 'should change the custom_field name' do
        expect(assigns(:custom_field).reload.name).to eq(@new_attributes[:name])
      end

      it 'should change the custom_field field_type' do
        expect(assigns(:custom_field).reload.field_type).to eq(@new_attributes[:field_type])
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        @new_attributes = { name: nil, field_type: nil }
        patch :update, id: @custom_field_test.id, custom_field: @new_attributes
      end

      it 'should return 200' do
        expect(response.status).to eq(200)
      end

      it 'should return the right resource' do
        expect(assigns(:custom_field)).to eq(@custom_field_test)
      end

      it 'should set errors on the custom_field' do
        expect(assigns(:custom_field).errors).not_to be_blank
      end

      it 'should render the right view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      delete :destroy, id: @custom_field_test.id
    end

    it 'should return 302' do
      expect(response.status).to eq(302)
    end

    it 'should set the right variables' do
      expect(assigns(:custom_field)).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'should destroy an CustomField' do
      expect do
        delete :destroy, id: @custom_field_test.id
      end.to change {
        CustomField.count
      }.by(-1)
    end
  end

end