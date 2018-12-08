Rails.application.routes.draw do
  root 'session#new'


  get 'session/new'

  get 'session/create'
  get 'session/destroy'

  get "/login" => "session#new"
  post "/login" => "session#create"
  delete "/login" => "session#destroy"

  get "/solutions/trial" => "solutions#trial"
  resources :solutions

  resources :challenges
  resources :test_pairs
  resources :users
  resources :comments
end
