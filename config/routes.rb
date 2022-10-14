Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    resources :projects
    get 'members/dashboard'
    get 'checkouts/show'
    get 'checkouts/success'
    resources :categories
    authenticated :user, -> (user) { user.admin? } do
      get :admin, to: "admin#index"
      get 'admin/posts'
      get 'admin/comments'
      get 'admin/users'
      get 'admin/show_post/:id', to: "admin#show_post", as: "admin_post"
    end
    get 'checkout', to: "checkouts#show"
    get 'checkout/success', to: "checkouts#success"
    get 'billing', to: "billing#show"
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
end
