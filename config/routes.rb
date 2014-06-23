Rails.application.routes.draw do
  resources :symptom_details
  resources :symptoms

  get 'symptoms/new/add_detail' => 'symptoms#add_detail', as: :add_detail
  root to: 'welcome#index'
  get 'auth/:provider/callback' => 'sessions#create'

  # as: :logout とすることで、logout_pathとして参照できる。
  get '/logout' => 'sessions#destroy', as: :logout
end
