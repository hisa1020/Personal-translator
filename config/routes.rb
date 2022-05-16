Rails.application.routes.draw do
  root 'top#index'
  devise_for :users
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get 'users/profile', to: 'users#profile'
  get 'users/profile_edit', to: 'users#profile_edit'
  get 'users/posts', to: 'users#posts'
  get 'users/questions', to: 'users#questions'
  get 'users/favorite_posts', to: 'users#favorite_posts'
  get 'users/favorite_questions', to: 'users#favorite_questions'
  get 'search', to: 'searches#search'
  resources :users, only: [:show, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
  resources :questions do
    resource :q_favorites, only: [:create, :destroy]
  end
  resources :comments, only: [:create]
  resources :q_comments, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
