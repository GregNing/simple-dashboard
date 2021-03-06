# frozen_string_literal: true

module Mutations
  class LogOut < Mutations::BaseMutation
    graphql_name "LogOut"

    def resolve
      user = context[:current_user]

      if user.present?
        success = user.reset_authentication_token!

        MutationResult.call(success: success, errors: user.errors)
      else
        GraphQL::ExecutionError.new("User not signed in")
      end
    end
  end
end
