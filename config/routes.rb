Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, 
    controllers: { 
      sessions: :sessions,
      sign_out: 'logout',
      registration: 'signup'
    },
    path_names: { 
      sign_in: :login 
    }

    resource :user, only: [:show, :update, :destroy]
    resources :products
    resources :purchases
  end
end
