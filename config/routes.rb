Rails.application.routes.draw do
  devise_for :users, skip: :sessions

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  root "application#index"

  # Catch all for HTML 5 history routing. This must be the last route.
  get "/*path", to: "application#index", format: false
end
