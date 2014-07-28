AdventureLibrary::Application.routes.draw do
  resources :libraries, :only => [:index]
  resources :adventures do
    resources :pages
  end
post '/adventures/scrape', to: 'adventures#scrape', as: 'adventures_scrape'
root 'adventures#index'
#              Prefix Verb   URI Pattern                                        Controller#Action
#           libraries GET    /libraries(.:format)                               libraries#index
#     adventure_pages GET    /adventures/:adventure_id/pages(.:format)          pages#index
#                     POST   /adventures/:adventure_id/pages(.:format)          pages#create
#  new_adventure_page GET    /adventures/:adventure_id/pages/new(.:format)      pages#new
# edit_adventure_page GET    /adventures/:adventure_id/pages/:id/edit(.:format) pages#edit
#      adventure_page GET    /adventures/:adventure_id/pages/:id(.:format)      pages#show
#                     PATCH  /adventures/:adventure_id/pages/:id(.:format)      pages#update
#                     PUT    /adventures/:adventure_id/pages/:id(.:format)      pages#update
#                     DELETE /adventures/:adventure_id/pages/:id(.:format)      pages#destroy
#          adventures GET    /adventures(.:format)                              adventures#index
#                     POST   /adventures(.:format)                              adventures#create
#       new_adventure GET    /adventures/new(.:format)                          adventures#new
#      edit_adventure GET    /adventures/:id/edit(.:format)                     adventures#edit
#           adventure GET    /adventures/:id(.:format)                          adventures#show
#                     PATCH  /adventures/:id(.:format)                          adventures#update
#                     PUT    /adventures/:id(.:format)                          adventures#update
#                     DELETE /adventures/:id(.:format)                          adventures#destroy
#                root GET    /                                                  adventures#index

end
