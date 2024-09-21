Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :products, only: %w[index show update] do
        get :compute_price, on: :collection
      end
    end
  end
end
