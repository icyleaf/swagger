# module Swagger
#   alias Type = String | Int32 | Float64 | Bool | Time | Nil | Array(Type) | Hash(String, Type)

#   macro object(name, *properties, return_nil = false)
#     struct {{name.id}}
#       include JSON::Serializable

#       {% for property in properties %}
#         {% if property.is_a?(Assign) %}
#           getter {{property.target.id}}
#         {% elsif property.is_a?(TypeDeclaration) %}
#           getter {{property.var}} : {{property.type}}
#         {% else %}
#           getter :{{property.id}}
#         {% end %}
#       {% end %}

#       def initialize({{
#                        *properties.map do |field|
#                          "@#{field.id}".id
#                        end
#                      }})
#       end

#       {{yield}}

#       def to_h
#         Hash(String, Swagger::Type).new.tap do |obj|
#           \{% for ivar in @type.instance_vars %}
#             value = fetch_value(@\{{ ivar.id }})
#             if value.nil?
#               obj["\{{ ivar.id }}"] = nil if {{ return_nil.id }}
#             else
#               obj["\{{ ivar.id }}"] = value
#             end
#           \{% end %}
#         end
#       end

#       private def fetch_value(value)
#         case value
#         when Array
#           value.to_a.map {|v| fetch_value(v) }
#         when URI
#           value.to_s
#         when .responds_to?(:to_h)
#           value.to_h
#         else
#           value
#         end.as(Swagger::Type)
#       end
#     end
#   end
# end

module Swagger
  module Object

  end
end

require "./objects/*"
