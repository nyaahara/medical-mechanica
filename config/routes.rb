Rails.application.routes.draw do
  resources :users do
    resources :symptoms do
      resources :parts
    end
  end

  resources :progresses do
    resources :parts
  end

  resources :sicks do
    resources :sick_comments
  end

  root to: 'welcome#index'
  get 'auth/:provider/callback' => 'sessions#create'

  # as: :logout とすることで、logout_pathとして参照できる。
  get '/logout' => 'sessions#destroy', as: :logout
end
