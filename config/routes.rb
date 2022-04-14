Rails.application.routes.draw do
  root 'top#index'
  devise_for :users
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get 'users/profile', to: 'users#show'
  get 'users/profile_edit', to: 'users#edit'
  resources :users, only: :update
  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
