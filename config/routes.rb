Rails.application.routes.draw do
  get 'lists/new'
  get 'lists/show'
  get 'lists/edit'
  get 'lists/create'
  get 'lists/update'
  get 'lists/destroy'
  devise_for :users, skip: [:sessions, :registrations], controllers: { :omniauth_callbacks => "sessions" }
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy'
  end

  root 'home#index'
  get 'home/index'
  post '/' => 'home#search'
  post 'home/index' => 'home#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
