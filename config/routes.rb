Rails.application.routes.draw do
  root 'top#index'
  get 'users/profile', to: 'users#show'
  get 'users/profile_edit', to: 'users#edit'
  resources :users, only: [:update]

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
