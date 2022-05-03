Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root "sessions#new"

    resources :users, only: [:new, :create, :show]
    resource :session, only: [:new, :create, :destroy]
    resources :bands, only: [:new, :create, :edit, :update, :destroy, :show, :index] do 
        resources :albums, only: [:new, :edit]
        resources :albums, only: [:show] do 
            resources :tracks, only: [:new, :edit, :show]
        end
    end 

    resources :albums, only: [:create, :update, :destroy]
    resources :tracks, only: [:create, :update, :destroy]
    resources :notes, only: [:create, :destroy]
end
