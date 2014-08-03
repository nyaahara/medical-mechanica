Rails.application.routes.draw do
  resources :users do
    resources :symptoms
  end

  root to: 'welcome#index'
  get 'auth/:provider/callback' => 'sessions#create'

  # as: :logout とすることで、logout_pathとして参照できる。
  get '/logout' => 'sessions#destroy', as: :logout
end
