Rails.application.routes.draw do

  devise_for :user,
             path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup" },
             controllers: { omniauth_callbacks: :omniauth_callbacks}

  # get 'oauth/callback' => 'oauths#callback'
  # get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

  # Редактирование профиля и аккаунта
  scope :my, as: :my do
    resource :profile, controller: 'users', only: [:show, :update]
  end

  # Список пользователей и публичные профили
  resources :users, only: [:index, :show]

  # События
  resources :events, except: [:destroy] do
    patch :publish, on: :member
    patch :cancel_publication, on: :member
  end

  post '/participate_in_event' => 'event_participations#create'
  delete '/cancel_participation' => 'event_participations#destroy'

  root to: redirect('/events')

  get ':id' => 'high_voltage/pages#show', as: :page
end
