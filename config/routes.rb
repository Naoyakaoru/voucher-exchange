Rails.application.routes.draw do
  devise_for :users, 
    controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
  get "/exchange", to: "vouchers#new"
  get "/vouchers", to: "vouchers#index"
  resources :vouchers, path: "exchange", only: [:create] 
end
