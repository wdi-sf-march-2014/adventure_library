AdventureLibrary::Application.routes.draw do

  root to: 'adventures#index'

  resources :libraries, only: [:index, :create, :update]

  resources :adventures do
    resources :pages, only: [:show, :create, :update, :destroy ]
  end

end
