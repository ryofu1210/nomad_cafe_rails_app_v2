Rails.application.routes.draw do
  root 'static_pages#home'
  # root 'posts#index'
  resources :posts, only: %w(index show) do
    resources :favorites, only: %w(create destroy)
  end

  resources :areas, only: %w(show)

  namespace :back do
    resources :posts, only: %w(index show new edit destroy)
  end
  namespace :api, {format: 'json'} do
    resources :posts, only: %w(edit new update create)
  end

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
