Doodlinn::Application.routes.draw do

  resources :events, only: [:new, :create, :destroy]
  match '/:token', to: 'events#show', as: 'token', via: :get
end
