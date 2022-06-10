Rails.application.routes.draw do
  resources :retention_emails do 
    collection do 
      get 'search'
      post 'search'
    end
  end
  resources :recipes
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
