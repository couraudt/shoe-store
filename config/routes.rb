# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: 'json' } do
    resources :stores, only: %i[index show] do
      resources :models, only: %i[index show]
    end
    match '*path', to: 'base#catch_404', via: :all
  end
end
