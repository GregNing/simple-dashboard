Rails.application.routes.draw do
  root "application#index"

  # Catch all for HTML 5 history routing. This must be the last route.
  get "/*path", to: "application#index", format: false
end
