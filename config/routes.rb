Rails.application.routes.draw do
  post "/sign_up", to: "auth#sign_up"
  post "/sign_in", to: "auth#sign_in"
  delete "sign_out", to: "auth#sign_out"
  get "/check_login", to: "auth#check_login"

  resources :boards, defaults: {format: 'json'} do
    member do
      get :select
    end
  end
  resources :lists, defaults: {format: 'json'}
  resources :tasks , defaults: {format: 'json'}
  resources :searches, only: :index, default: {format: 'json'}
  # get "*path" => redirect("/")
  get "*path", to: "exceptions#redirect"
end
