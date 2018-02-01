Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :tickets, :controller => "event_tickets"
  end

  namespace :admin do
    root "events#index"
    resources :events
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
    resources :events do
      resources :tickets, :controller => "event_tickets"
    end
  end

  root "events#index"
  get "/faq" => "pages#faq"
  resource :user

end
