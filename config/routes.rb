Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :lists, only: [:new, :create, :index, :show] do
    resources :bookmarks, only: [:new, :create]
  end
end
