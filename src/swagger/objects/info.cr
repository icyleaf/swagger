module Swagger::Objects
  # Info Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#infoObject
  struct Info
    include JSON::Serializable

    getter title : String
    getter version : String
    getter description : String? = nil

    @[JSON::Field(key: "termsOfService")]
    getter terms_url : String? = nil

    getter license : License? = nil
    getter contact : Contact? = nil

    def initialize(@title : String, @version : String, @description : String? = nil,
                   @terms_url : String? = nil, @license : License? = nil, @contact : Contact? = nil)
    end

    # Contact Object
    #
    # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#contactObject
    struct Contact
      include JSON::Serializable

      getter name : String
      getter email : String? = nil
      getter url : String? = nil

      def initialize(@name : String, @email : String? = nil, @url : String? = nil)
      end
    end

    # License Object
    #
    # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#licenseObject
    struct License
      include JSON::Serializable

      # NOTE: To do or not to do.
      # https://opensource.org/licenses/category
      #
      # KNOWN_LICENSES = {
      #   "mit" => "https://opensource.org/licenses/MIT",
      # }

      # {% for ivar, iurl in KNOWN_LICENSES %}
      # def self.{{ ivar.id }}
      #   new({{ ivar.id.upcase.stringify }}, URI.parse({{ iurl.id.stringify }}))
      # end
      # {% end %}

      getter name : String
      getter url : String? = nil

      def initialize(@name : String, @url : String? = nil)
      end
    end
  end
end
