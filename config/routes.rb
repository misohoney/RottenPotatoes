Rails.application.routes.draw do
  resources :genres
  resources :movies do
    resources :reviews
  end

  get 'static_pages/home'
  get 'static_pages/about'
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
