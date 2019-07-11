Rails.application.routes.draw do
  namespace :back do
    resources :posts, only: %w(index show new edit)
  end
  root 'static_pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
