Rails.application.routes.draw do
  authenticated :user, -> (user) { user.admin? } do
    get :admin, to: "admin#index"
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_post/:id', to: "admin#show_post", as: "admin_post"
  end
  get :search, to: "search#index"
  get 'comments/create'
  get 'comments/destroy'
  get 'create/destroy'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :after_signup

  resources :posts do
    resources :comments
  end
  get 'pages/home'
  get 'pages/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
