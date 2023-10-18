Rails.application.routes.draw do
  root "personal_data#index"
  resources :personal_data
  resources :employments, only: [:new, :create]
  post 'add_employment', to: 'employments#add_employment'
end
