Dicto::Application.routes.draw do

  root :to => "index#index"

  resources :languages

  resources :dictionaries do
    post :sort, :on => :collection
    get :delete, :on => :member
  end


  match '/:from/:to/words/search', :to => 'words#search'

  scope '/:from/:to' do
    resources :words do
      get :search, :on => :collection
      resources :translations
    end
  end

  match "/:from/:to" => redirect("/%{from}/%{to}/words")

end
