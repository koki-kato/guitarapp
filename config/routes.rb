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

  # google
  post '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/signout' => 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  #ゲスト
  post 'guest_login', to: "guest_sessions#create"

  resources :users do
    collection {post :import}
    resources :scores do
      resources :beats
    end
  end

end
