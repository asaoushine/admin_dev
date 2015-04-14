Rails.application.routes.draw do
  
  get 'users/index'

  get 'users/show'

  match '/:id', to: 'articles#show', via: 'get'
  
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

  devise_for :users

  resources :users, only: [:index, :show]
      

  root 'articles#index'

end
