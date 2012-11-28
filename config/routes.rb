Doodlinn::Application.routes.draw do
  root to: "events#new"

  resources :events, only: [:new, :create, :destroy] do
    resources :votes, only: [:new, :create]
  end

  match '/events/:token', to: 'events#show', as: 'token', via: :get
end
