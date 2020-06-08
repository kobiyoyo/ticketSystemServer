Rails.application.routes.draw do
	 post 'auth/register', to: 'api/v1/users#register'
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
