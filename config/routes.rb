Rails.application.routes.draw do
  root to: "makepatterns#index"

  get "makepatterns/index"
  get "makepatterns/aboutme"

  get "posts/index"

  get "patterns/index"
  
  resources :patterns
  resources :posts

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :patterns do
    resource :bookmarks, only: [:create, :destroy]
  end

  devise_scope :user do
    get 'account_setting', to: 'users/sessions#account_setting', as: :account_setting_user_session
    get 'edit_profile', to: 'users/registrations#edit_profile', as: :edit_profile_user_registration
    get 'edit_account', to: 'users/registrations#edit_account', as: :edit_account_user_registration
    patch 'update', to: 'users/registrations#update', as: :update_user
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
