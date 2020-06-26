Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :shortened_urls, only: [:index, :create]
  end
end
