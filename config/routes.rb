Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      post '/subscribe', to: 'subscriptions#create'
      patch '/unsubscribe', to: 'subscriptions#cancel'
      get '/subscriptions', to: 'customers#show'
    end
  end
end
