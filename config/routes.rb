Doodlinn::Application.routes.draw do
  root to: "events#new"

  resources :events, only: [:new, :create, :destroy, :index] do
    post 'close_voting'
    resources :votes, only: [:new, :create]
  end

  match '/events/:token', to: 'events#show', as: 'token', via: :get
end
