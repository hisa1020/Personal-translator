Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :personaltranslator do
    get '/', to: 'top#index'
    get 'index', to: 'top#index'
  end
end
