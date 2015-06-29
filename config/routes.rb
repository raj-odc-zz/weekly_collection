Rails.application.routes.draw do
  resources :entries

  resources :entry_types

  resources :expenses

  resources :expense_types

  resources :daily_collections

  resources :loans

  resources :customers

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'visitors#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
