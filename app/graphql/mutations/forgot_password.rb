# frozen_string_literal: true

module Mutations
  class ForgotPassword < Mutations::BaseMutation
    graphql_name 'ForgotPassword'

    argument :email, String, required: true

    def resolve(args)
      @user = User.find_for_database_authentication(email: args[:email])

      if @user.present?
        @user.send_reset_password_instructions
        MutationResult.call(success: true)
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
    end
  end
end
