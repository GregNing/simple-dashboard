class SimpleDashboardSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    "Types::#{obj.class.name}Type".constantize
  rescue NameError
    raise("Unexpected object: #{obj}")
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, _ctx = nil)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  end

  # Given a string UUID, find the object
  def self.object_from_id(id, _ctx)
    type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)

    Object.const_get(type_name).find(object_id)
  end
end
