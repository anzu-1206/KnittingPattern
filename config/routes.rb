Rails.application.routes.draw do
  get "makepatterns/index"
  get "posts/index"
  get "patterns/index"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
