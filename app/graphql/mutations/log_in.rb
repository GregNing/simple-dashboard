# frozen_string_literal: true

module Mutations
  class LogIn < Mutations::BaseMutation
    graphql_name "LogIn"

    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      user = User.find_for_database_authentication(email: args[:email])

      if user.present?
        raise ParamsError, 'Incorrect Email/Password' unless user.valid_password?(args[:password])
        raise ParamsError, 'Email needs to be confirmed' unless user.confirmed?

        context[:current_user] = user
        MutationResult.call(obj: { user: user }, success: true)
      else
        GraphQL::ExecutionError.new('User not registered on this application')
      end
    end
  end
end
