Rails.application.routes.draw do

  root 'articles#index'
  
  match 'admin', to: 'admin#show', via: 'get'
  namespace :admin do

    resources :articles do
      member do
        post :publish
        post :draft
      end
    end
    resources :comments

    resource :withdrawals

    namespace :settings do
      resource :profiles
      resource :accounts
      resource :passwords
    end
  end

  devise_for :users, controllers: { 
      :sessions   =>  "users/sessions",
      :registrations => "users/registrations",
      :passwords  =>  "users/passwords"
      
  }

  resources :users, only: [:index, :show]
      
  match '/:id', to: 'articles#show', via: 'get'
  
end
