Rails.application.routes.draw do
  resources :categories
  resources :expenses
  get 'stat', to: 'stat#index'
  get 'stat/:month', to: 'stat#month'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
