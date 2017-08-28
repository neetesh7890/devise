Rails.application.routes.draw do

  get 'dashboards/index'

  devise_scope :user do
    # get 'users/sign_in', to: 'users/sessions#new'
    

    devise_for :users, controllers: { sessions: 'users/sessions' }

    resources :dashboards
    root 'users/sessions#new'
  end
end

