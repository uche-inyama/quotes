Rails.application.routes.draw do
  devise_for :users
  resources :quotes

  root to: "pages#home"
end
