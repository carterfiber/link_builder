Rails.application.routes.draw do
  resources :links do
  	collection do
  		post :import
  	end
  end

  root 'links#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
