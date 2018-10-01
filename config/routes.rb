Rails.application.routes.draw do

  get 'pages/home'

  devise_for :customers, :controllers => { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  
  resources :posts do
    resources :likes
  end


  root 'pages#home'
end
