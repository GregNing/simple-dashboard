# frozen_string_literal: true

module GqlSupport
  def gql_query(query:, variables: {}, context: {})
    query = GraphQL::Query.new(
      SimpleDashboardSchema,
      query,
      variables: variables.deep_stringify_keys,
      context: context
    )

    query.result if query.valid?
  end
end

RSpec.configure do |config|
  config.include GqlSupport, type: :gql
end
