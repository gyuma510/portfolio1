Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  #devise_scope :user do
    #post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    #get '/users', to: 'devise/registrations#new'
    #get 'users/password', to: 'users/passwords#new'
  #end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :remember_you do
    resources :records do
      collection do
        get 'search'
      end
    end
    resources :contacts, only: [:new, :create] do
      collection do
        root to: 'contacts#new'
      end
    end
  end    
end
