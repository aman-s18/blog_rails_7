Rails.application.routes.draw do
  get :search, to: "search#index"
  get 'comments/create'
  get 'comments/destroy'
  get 'create/destroy'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :posts do
    resources :comments
  end
  get 'pages/home'
  get 'pages/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
