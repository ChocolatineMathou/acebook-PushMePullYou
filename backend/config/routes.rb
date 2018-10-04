# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'

  devise_for :customers, controllers: { registrations: 'registrations', sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts

  resources :posts do
    resources :likes
  end
end
