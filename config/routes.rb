Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/texts/new' => 'texts#new'
  post '/texts' => 'texts#create'
  get '/texts/show' => 'texts#show'
end
