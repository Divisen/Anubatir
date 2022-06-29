Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  get 'services', to: 'pages#services'
  get 'projects', to: 'pages#projects'
  get 'contact', to: 'pages#contact'
  get 'presignup', to: 'pages#presignup'
  get 'construction', to: 'pages#construction'
  get 'renovation', to: 'pages#renovation'
  get 'design', to: 'pages#design'
  get 'about', to: 'pages#about'
  get 'conditions', to: 'pages#conditions'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: :show
  resources :chatrooms do
    resources :messages, only: :create
  end
  resources :testimonials, only: [:new, :create]
  resources :tenders do
    resources :bids do
      member do
        get 'activate'
        put 'activate'
      end
      collection do
        get 'reject'
        put 'reject'
      end
      resources :contracs, only: [:index, :new, :create, :edit, :update ]
    end
  end
  resources :testimonials, only: :destroy
end
