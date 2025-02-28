require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  namespace :api do
    namespace :v1 do
      post 'sleep-tracking/clock-in', to: 'sleep_trackings#clock_in'
      patch 'sleep-tracking/clock-out', to: 'sleep_trackings#clock_out'
      get 'sleep-tracking/following', to: 'sleep_trackings#following'
      
      post 'friendship/follow/:user_id', to: 'friendships#follow'
      delete 'friendship/unfollow/:user_id', to: 'friendships#unfollow'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
