Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :contacts, only: [:index, :new, :create, :edit, :update, :destroy], path: 'contatos'

  resources :custom_fields, only: [:index, :new, :create, :edit, :update, :destroy], path: 'campos_personalizados'

  root to: 'users/sessions#new'
end
