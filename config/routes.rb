AdventureLibrary::Application.routes.draw do
  resources :adventures do
    resources :pages
  end

  resources :libraries do
    resources :adventures
  end
 root to: "adventures#index"
         
end
