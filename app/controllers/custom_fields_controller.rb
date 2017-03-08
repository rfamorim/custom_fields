class CustomFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:index]
  before_action :set_resource, only: [:edit, :update, :destroy]

  def index
    
  end

  def new
    @custom_field = CustomField.new
  end

  def create
    @custom_field = CustomField.new custom_field_create_params

    if @custom_field.save
      flash[:success] = "Campo Personalizado criado com sucesso."
      redirect_to custom_fields_path
    else
      flash[:error] = "Ocorreu um problema ao criar o Campo Personalizado."
      render :new
    end
  end

  def edit
    
  end

  def update
    if @custom_field.update_attributes custom_field_update_params
      flash[:success] = "Campo Personalizado atualizado com sucesso."
      redirect_to custom_fields_path
    else
      flash[:error] = "Ocorreu um problema ao atualizar o Campo Personalizado."
      render :edit
    end
  end

  def destroy
    if @custom_field.destroy
      flash[:success] = "Campo Personalizado apagado com sucesso."
    else
      flash[:error] = "Ocorreu um problema ao apagar o Campo Personalizado."
    end
    
    redirect_to custom_fields_path
  end

  private
    def set_collection
      @custom_fields = current_user.custom_fields
    end

    def set_resource
      @custom_field = CustomField.find params[:id]
    end


    def custom_field_create_params
      params.require(:custom_field).permit(
        :user_id,
        :name,
        :field_type,
        :options
      )
    end

    def custom_field_update_params
      params.require(:custom_field).permit(
        :user_id,
        :name,
        :field_type,
        :options
      )
    end
end