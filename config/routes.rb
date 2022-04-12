Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'top#index'
  get 'users/profile', to: 'users#show'
  get 'users/profile_edit', to: 'users#edit'
  resources :users, only: [:update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
