# frozen_string_literal: true

module Mutations
  class ResetPassword < Mutations::BaseMutation
    graphql_name 'ResetPassword'

    argument :oldpassword, String, required: true
    argument :password,              String, required: true
    argument :password_confirmation, String, required: true

    def resolve(args)
      current_user = context[:current_user]

      raise RecordExistError, 'User not exists' if current_user.nil?

      raise ParamsError, 'Old password not match' unless current_user.valid_password?(args[:oldpassword])
      raise ParamsError, 'Passwords do not match' if args[:password] != args[:password_confirmation]

      MutationResult.call(success: true) if current_user.update(password: args[:password])
    end
  end
end
