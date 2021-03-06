require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', confirmations: 'confirmations' }

  root to: 'questions#index'

  concern :votable do
    member do
      post :like
      post :dislike
      delete :unvote
    end
  end

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: [:votable, :commentable], shallow: true, except: [:edit] do
    member do
      post :toogle_notify
    end
    resources :answers, concerns: [:votable, :commentable] do
      member do
        patch :make_best
      end
    end
  end

  resource :subscriptions, only: [:create, :destroy]

  resources :attachments, only: [:destroy]

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resource :search do
    get :start
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions, only: [:index, :show, :create], shallow: true do
        resources :answers
      end
    end
  end


  mount ActionCable.server => '/cable'

end