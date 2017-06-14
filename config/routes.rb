Rails.application.routes.draw do
  resources :photos
  
  get 'photos/index'

  get 'photos/show'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
