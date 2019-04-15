Rails.application.routes.draw do
  get 'home/index'
  post 'home/index' => 'home#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
