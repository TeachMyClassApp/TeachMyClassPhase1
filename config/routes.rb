Rails.application.routes.draw do

  resources :uploads
  root 'pages#home' 

  get 'pages/about' 
  get 'pages/contact' 
  get 'pages/faqs' 
  get 'pages/for_teachers' 
  get 'pages/for_experts'
  get 'pages/privacy' 
  get 'pages/terms_of_use' 

  devise_for :users,
  			 path: '',
  			 path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
  			 controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show] do 
    member do 
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
    end
  end

  resources :lessons, except: [:edit] do 
  	member do 
  		get 'listing'
  		get 'pricing'
  		get 'description'
  		get 'photo_upload'
  		get 'location'
  		get 'features'
      get 'preload'
      get 'preview'
  	end

    resources :photos, only: [:create, :destroy]
    resources :bookings, only: [:create]
    resources :calendars
 end

  resources :teacher_reviews, only: [:create, :destroy]
  resources :expert_reviews, only: [:create, :destroy]

  get '/your_plans' => 'bookings#your_plans'
  get '/your_bookings' => 'bookings#your_bookings'

  get 'search' => 'pages#search'

  get 'dashboard' => 'dashboards#index'

  resources :bookings, only: [:approve, :decline] do
    member do 
      post '/approve' => "bookings#approve"
      post '/decline' => "bookings#decline"
      end 
    end

  resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index, :create]
  end 
      

    get '/expert_calendar' => "calendars#expert"
    get '/payment_method' => "users#payment"
    post '/add_card' => "users#add_card"

    get '/communications_settings' => "settings#edit"
    post '/communications_settings' => "settings#update"

    get '/notifications' => "notifications#index"

    mount ActionCable.server => '/cable'

end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
