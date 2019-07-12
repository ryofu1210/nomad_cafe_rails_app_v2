Rails.application.routes.draw do
  root 'static_pages#home'
  namespace :back do
    resources :posts, only: %w(index show new edit)
  end
  namespace :api do
    resources :posts, only: %(show)
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
