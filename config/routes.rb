Rails.application.routes.draw do
  # People shouldnt be able to register themselves
  get 'users/sign_up', to: redirect('/')
  post 'devise/users', to: redirect('/')

  devise_for :users, path_prefix: 'devise'

  root 'startpage#index'
  post 'role_switch', to: 'startpage#role_switch', as: 'role_switch'

  resources :users, except: :show

  resources :orders

  resources :wines

  resources :customers

  resource :sendouts, only: [:new, :create]

  scope 'search' do
    get 'customers', to: 'customers#search'
    get 'wines', to: 'wines#search'
  end

  scope 'pdf', controller: 'pdf' do
    get :index, as: 'pdf_index'
    get :customers, as: 'pdf_customers'
    get :orders, as: 'pdf_orders'
  end
end
