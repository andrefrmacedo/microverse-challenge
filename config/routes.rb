# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    get '/users', action: :index, on: :collection
    get '/users/:id', action: :show
  end
end
