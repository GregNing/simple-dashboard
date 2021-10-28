module Types
  class MutationType < Types::BaseObject
    field :omniauth_login, mutation: Mutations::OmniauthLogin
    field :register_user, mutation: Mutations::RegisterUser
    field :log_in, mutation: Mutations::LogIn
    field :log_out, mutation: Mutations::LogOut
  end
end
