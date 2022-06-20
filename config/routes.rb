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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :testimonials, only: [:new, :create]
  resources :tenders do
    resources :bids do
      resources :contracs, only: [:index, :new, :create, :edit, :update ]
    end
  end
  resources :testimonials, only: :destroy
end
