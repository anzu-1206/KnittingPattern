Rails.application.routes.draw do
  root to: "makepatterns#index"

  get "makepatterns/index"
  get "posts/index"
  get "patterns/index"
  devise_for :users

  devise_scope :user do
  get 'account_setting', to: 'users/sessions#account_setting', as: :account_setting_user_session
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
