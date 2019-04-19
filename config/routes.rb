Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations], controllers: { :omniauth_callbacks => "sessions" }
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy'
  end

  root 'home#index'
  # get 'home/index'
  post '/' => 'home#search'
  # post 'home/index' => 'home#search'

  resources :lists
  resources :movies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
