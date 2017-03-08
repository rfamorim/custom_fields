class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:index]
  before_action :set_resource, only: [:edit, :update, :destroy]

  def index
    
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new contact_create_params

    if @contact.save
      flash[:success] = "Campo Personalizado criado com sucesso."
      redirect_to contacts_path
    else
      flash[:error] = "Ocorreu um problema ao criar o Campo Personalizado."
      render :new
    end
  end

  def edit
    
  end

  def update
    if @contact.update_attributes contact_update_params
      flash[:success] = "Campo Personalizado atualizado com sucesso."
      redirect_to contacts_path
    else
      flash[:error] = "Ocorreu um problema ao atualizar o Campo Personalizado."
      render :edit
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = "Campo Personalizado apagado com sucesso."
    else
      flash[:error] = "Ocorreu um problema ao apagar o Campo Personalizado."
    end
    
    redirect_to contacts_path
  end

  private
    def set_collection
      @contacts = current_user.contacts
    end

    def set_resource
      @contact = Contact.find params[:id]
    end


    def contact_create_params
      params.require(:contact).permit(
        :user_id,
        :email,
        :name,
        :custom_fields
      )
    end

    def contact_update_params
      params.require(:contact).permit(
        :user_id,
        :email,
        :name,
        :custom_fields
      )
    end
end
