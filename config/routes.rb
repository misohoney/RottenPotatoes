Rails.application.routes.draw do
  resources :reviews, only: [:index]
  resources :movies, except: [:new, :edit] do
    resources :reviews, except: [:index]
  end
  get '/home', to: 'static_pages#home', as: 'home'
  get '/about', to: 'static_pages#about', as: 'about'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
