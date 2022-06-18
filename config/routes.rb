Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'services', to: 'pages#services'
  get 'projects', to: 'pages#projects'
  get 'contact', to: 'pages#contact'
  get 'construction', to: 'pages#construction'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :testimonials, only: [:new, :create]
  resources :tenders do
    resources :bids do
      resources :contracs, only: [:index, :new, :create, :edit, :update ]
    end
  end
  resources :testimonials, only: :destroy
end
