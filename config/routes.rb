Rails.application.routes.draw do
  
  root   'static_pages#home' #defines the root route; then you automatically has access to the named route, root path
                                        #static_pages is the controller, home is the action
  get    '/help',      to: 'static_pages#help' #may also name routed other than defaut using the 'as:' option
  get    '/about',     to: 'static_pages#about'
  get    '/contact',   to: 'static_pages#contact'
  get    '/signup',    to: 'users#new'
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create' # arranges to route POST request to the Sessions#create action.
  delete '/logout',    to: 'sessions#destroy'
  resources :users                           #this one line provides app with ALL the actions needed for a RESTful Users resources, along with a large number of named routes for generating user URLs
                                             #resuitling correspondence of URLs, actions and name routes
  resources :account_activations, only: [:edit] #add a route for the account activations 'edit' action
end

#GET request for the URL/help to the help action in the static_page_controller. This creates 2 name route: help_path and help_url