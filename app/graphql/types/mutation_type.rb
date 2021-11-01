module Types
  class MutationType < Types::BaseObject
    field :omniauth_login, mutation: Mutations::OmniauthLogin
    field :register_user, mutation: Mutations::RegisterUser
    field :log_in, mutation: Mutations::LogIn
    field :log_out, mutation: Mutations::LogOut
    field :forgot_password, mutation: Mutations::ForgotPassword
    field :update_password_with_token, mutation: Mutations::UpdatePasswordWithToken
    field :reset_password, mutation: Mutations::ResetPassword
  end
end
