Rails.application.routes.draw do
  resources :users, only:[:show, :destroy] do
    resources :symptoms, only:[:create, :show, :new, :edit, :update, :destroy]
  end

  get 'info' => 'info#show'

  root to: 'welcome#index'
  get 'auth/:provider/callback' => 'sessions#create'

  # as: :logout とすることで、logout_pathとして参照できる。
  get '/login' => 'sessions#show', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  match '*path' => 'application#error404', via: :all
end
