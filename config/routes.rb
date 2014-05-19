require 'sidekiq/web'

AdventureLibrary::Application.routes.draw do

  root to: 'adventures#index'

  resources :libraries, only: [:index]
  post '/libraries/import', to: 'libraries#import', as: 'import_library'

  resources :adventures do
    resources :pages, only: [:show, :create, :update]
  end

  mount Sidekiq::Web, at: "/sidekiq"

end
