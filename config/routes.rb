Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do

    get 'shortened_urls/:url_code', to: 'shortened_urls#show', as: :shortened_url
    resources :shortened_urls, only: [:index, :create]
  end
end
