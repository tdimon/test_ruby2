Rails.application.routes.draw do
  devise_for :models
  root 'companies#index', as: 'home'
  get '/companies', to: 'companies#index'
  post '/companies/load_xls', to: 'companies#load_xls'
  resources :api_settings
end
