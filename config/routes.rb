Rails.application.routes.draw do
  resources :entries

  resources :entry_types

  resources :expenses

  resources :expense_types

  get "daily_collections/(:date)" => "daily_collections#index",
        :constraints => { :date => /\d{4}-\d{2}-\d{2}/ },
        :as => "daily_collections_date"

  resources :daily_collections

  resources :loans

  resources :customers



  get "dashboard/(:date)" => "dashboard#index",
      :constraints => { :date => /\d{4}-\d{2}-\d{2}/ },
      :as => "dashboard_date"

  resources :dashboard, only: :index
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
