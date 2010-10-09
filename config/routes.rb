ActionController::Routing::Routes.draw do |map|
  map.resources :messages,:only => [:index, :create]
  map.root :controller => 'messages', :action => 'index'
  map.list '/list', :controller => 'messages', :action => 'list'
end
