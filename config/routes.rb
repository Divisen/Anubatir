Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tenders do
    resources :bids, only: [:index, :new, :create] do
      resources :contracs, only: [:index, :new, :create, :edit, :update ]
    end
  end
  resources :pages, only: [:home, :about_us, :contact]
end
