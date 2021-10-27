module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include ExceptionHandlers

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    field :success, Boolean, null: false
    field :errors, [String], null: true

    protected

    def authorize_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, 'User not signed in'
    end
  end
end
