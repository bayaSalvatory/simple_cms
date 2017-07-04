Rails.application.routes.draw do

	root'public#index'

	get 'show/:permalink', :to => 'public#show'

	get 'admin', :to => 'access#index'
  # get 'demo/index'

  match ':controller(/:action(/:id))', :via => [:get, :post]
end
