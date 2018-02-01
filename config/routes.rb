Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :tickets, :controller => "event_tickets"
      collection do
        post :bulk_update
      end
  end

  namespace :admin do
    root "events#index"
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
    resources :events do
      resources :tickets, :controller => "event_tickets"
      collection do
        post :bulk_update
      end
      member do
       post :reorder
     end
    end
  end

  root "events#index"
  get "/faq" => "pages#faq"
  resource :user

end
