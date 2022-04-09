Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  get 'users/profile', to: 'users#show'
  get 'users/profile_edit', to: 'users#edit'
  resources :users, only: [:update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
