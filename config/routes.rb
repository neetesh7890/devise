Rails.application.routes.draw do

  get 'dashboards/index'

  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new'
    
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',passwords: 'users/passwords' }
    root 'users/sessions#new'

    #---Added by NG---
    scope '/users' do
      

      resources :albums, except: :show do     
        collection do
          get '/my_album', to: "albums#my_album",as: 'my_album'
          get '/friend_album', to: "albums#friend_album",as: 'friend_album'
        end  
        member do
          get 'my_album_all', to:'albums#my_album_all', as: 'album_all'
          delete 'destroy_pic'
        end
        
        resources :comments,only: [:index,:destroy,:new,:create] do
          collection do
            get 'album_comments', to:'comments#album_comments', as: 'comments'
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

  




  #   resources :users do
  #     # get :verify

  #     resources :albums do     
  #       collection do
  #         get '/my_album', to: "albums#my_album",as: 'my_album'
  #         get '/friend_album', to: "albums#friend_album",as: 'friend_album'
  #       end
        
  #       member do
  #         get 'my_album_all', to:'albums#my_album_all', as: 'album_all'
  #         delete 'destroy_pic'
  #       end
        
  #       resources :comments do
  #         collection do
  #           get 'album_comments', to:'comments#album_comments', as: 'comments'
  #           post '/remark', to:'comments#remark', as: 'remark'
  #           post '/comments_remark', to:'comments#comments_remark', as: 'cmts_remark'
  #         end

  #         member do
  #           delete 'comment_destroy', to: 'comments#comment_destroy', as: 'cmts_destroy'
  #         end
  #       end
  #     end
  #     resources :dashboards
  #     resources :friends do
  #       get :notification

  #       collection do
  #         # get :verify
  #         get '/:token/accept', to:'friends#accept', as: 'accept'
  #       end
  #     end
  #   end
  #   post 'friends/search', to:'friends#search'
      
  #     #---end---


  #   resources :dashboards, only: [:index]
  #   root 'users/sessions#new'
  # end



  # Album-app routes code

  # get 'users/welcome'
  # get 'user_details/new'
  # # get 'users/login'
  # delete 'users/logout', to: 'users#logout'
  # get 'users/new_account_help', to:'users#new_account_help', as: 'new_account_help'
  # post 'users/create_account_help', to:'users#create_account_help', as: 'account_help'
  # get '/users/reset_password/:id', to: "users#reset_password", as: 'reset_password'
  # post '/users/update_password/:id', to: "users#update_password", as: 'update_password'
  
  # resources :sessions
  
 
  # root 'users#login'

  
end

