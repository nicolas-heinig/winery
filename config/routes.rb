Rails.application.routes.draw do
  # People shouldnt be able to register themselves
  get 'users/sign_up', to: redirect('/')
  post 'devise/users', to: redirect('/')

  devise_for :users, path_prefix: 'devise'

  root 'startpage#index'
  post 'role_switch', to: 'startpage#role_switch', as: 'role_switch'

  resources :users, except: :show
end
