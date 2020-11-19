Rails.application.routes.draw do
  

	  namespace :api do
	    namespace :v1 do
	    	resources :departments
	    	resources :users
	    	
	    	get 'tickets/closed', to:'tickets#closed'
	    	get 'tickets/resolved', to:'tickets#resolved'
	    	get 'tickets/working', to:'tickets#working'
	    	get 'tickets/rejected', to:'tickets#rejected'
	    	get 'tickets/ticket_per_month', to:'tickets#closed_ticket_per_month'
    		resources :tickets do

    			resources :comments
    			post :claim, to:'claims#create'
    			delete :unclaim, to:'claims#destroy'
    		end
	   
	    end
	  end
	  post 'auth/register', to: 'api/v1/users#register'
	  post 'auth/login', to: 'api/v1/users#login'

	   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
