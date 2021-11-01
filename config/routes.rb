require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords' }

  mount Sidekiq::Web => '/sidekiq'

  root "application#index"

  # Catch all for HTML 5 history routing. This must be the last route.
  get "/*path", to: "application#index", format: false
end
