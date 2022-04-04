Rails.application.routes.draw do
  root 'top#index'
  get 'users/mypage', to: 'users#show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
