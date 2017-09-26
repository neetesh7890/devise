Rails.application.routes.draw do

  get 'dashboards/index'

  #To map with user controller
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  get "/contacts/:provider/contact_callback", to:"dashboards#index"
  get "/contacts/failure", to:"dashboards#failure"


  devise_scope :user do

    # devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',passwords: 'users/passwords' }
    root 'users/sessions#new'

    # get 'auth/:provider/callback', to: 'sessions#create'

    scope '/users' do
    
      resources :albums do     
        collection do
          get '/my_album', to: "albums#my_album",as: 'my_album'
          get '/friend_album', to: "albums#friend_album",as: 'friend_album'
        end  
        member do
          delete 'destroy_pic'
        end
        
        resources :comments,only: [:index,:destroy,:new,:create] do
          collection do
            post '/remark', to:'comments#remark', as: 'remark'
            post '/comments_remark', to:'comments#comments_remark', as: 'cmts_remark'
          end
          member do
            delete 'comment_destroy', to: 'comments#comment_destroy', as: 'cmts_destroy'
          end
        end
      end

      resources :friends, only: [:index,:show,:destroy] do
        get :notification
        
        collection do
          get '/:token/accept', to:'friends#accept', as: 'accept'
        end
      end
      post 'friends/search', to:'friends#search'
    end
    resources :dashboards, only: :index
  end
end

