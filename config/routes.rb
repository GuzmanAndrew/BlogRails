Rails.application.routes.draw do
  resources :categories
  devise_for :users
  
  resources :articles do 
    resources :comments, only: [:create, :update, :destroy]
  end

  
  get 'articles/new', to: 'articles#new', as: 'new'
  get '/contact', to: 'contact#info', as: 'contact' # el "as" es para darle un nombre a nuestra ruta es decir
  #que desde el "get" hasta antes del "as" es nuestra ruta y es llamada con el apodo "contact" 
  # que se lo damos con el "as" y ese apodo es el que usamos con el _path

  #get '/contact' => 'contact#info'#Aca lo que hacemos es que la accion o metodo 
  # que es "/contact", busca cual es la ruta con el controlador y la vista que la van a ejecutar esto es lo 
  # mismo que colocar el "to" en ves el "=>"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
