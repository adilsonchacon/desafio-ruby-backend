Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'stores#index'

  get '/stores', to: 'stores#index' 
  post '/upload', to: 'stores#upload' 
end
