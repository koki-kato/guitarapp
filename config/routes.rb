Rails.application.routes.draw do
#   devise_for :users, controllers: {
#   omniauth_callbacks: "omniauth_callbacks"
# }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    collection {post :import}
  end

  resources :scores do
    resources :beats
  end


end
