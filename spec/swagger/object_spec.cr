require "../spec_helper"

struct Author
  property name

  def initialize(@name : String)
  end
end

enum VCS
  GIT
  SUBVERSION
  MERCURIAL
  FOSSIL
end

struct Project
  property id, name, description, vcs, open_source, author

  def initialize(@id : Int32, @name : String, @vcs : VCS, @open_source : Bool, @author : Author, @description : String? = nil)
  end
end

describe Swagger::Object do
  describe "#new" do
    it "should works" do
      properties = [
        Swagger::Property.new("id", "integer", "int32", example: 1),
        Swagger::Property.new("nickname", example: "icyleaf wang"),
        Swagger::Property.new("username", example: "icyleaf"),
        Swagger::Property.new("email", example: "icyleaf.cn@gmail.com"),
        Swagger::Property.new("bio", "Personal bio"),
      ]
      raw = Swagger::Object.new("User", "object", properties)
      raw.name.should eq "User"
      raw.type.should eq "object"
      raw.properties.should_not be_nil
      raw.properties.try &.size.should eq 5
    end

    it "should supports the type array with items as an object" do
      raw = Swagger::Object.new(
        "CommentList",
        "array",
        items: Swagger::Object.new(
          "Comment",
          "object",
        )
      )
      raw.type.should eq("array")
      raw.properties.should be_nil
      raw.items.class.should eq(Swagger::Object)
    end

    it "should supports the type array with items as a ref" do
      raw = Swagger::Object.new(
        "CommentList",
        "array",
        items: "Comment",
      )
      raw.type.should eq("array")
      raw.properties.should be_nil
      raw.items.should eq("Comment")
    end

    it "should generate schema of object with ref from object instance" do
      author = Author.new("icyleaf")
      raw = Swagger::Object.create_from_instance(
        Project.new(1,
          "swagger", VCS::GIT, true,
          author,
          "Swagger contains a OpenAPI / Swagger universal documentation generator and HTTP server handler."),
        refs: {
          "Author" => Swagger::Object.create_from_instance(
            author
          ),
        },
      )
      raw.name.should eq "Project"
      raw.type.should eq "object"
      raw.items.should be nil
      raw.properties.should eq [
        Swagger::Property.new("id", "integer", "int32", example: 1, required: true),
        Swagger::Property.new("name", example: "swagger", required: true),
        Swagger::Property.new("vcs", "object", example: "GIT", required: true, enum_values: [
          "GIT", "SUBVERSION", "MERCURIAL", "FOSSIL",
        ]),
        Swagger::Property.new("open_source", "boolean", example: true, required: true),
        Swagger::Property.new("author", "object", required: true, ref: "Author"),
        Swagger::Property.new(
          "description",
          example: "Swagger contains a OpenAPI / Swagger universal documentation generator and HTTP server handler.",
          required: false
        ),
      ]
    end

    it "shouldn't generate schema of object without ref from object instance" do
      expect_raises(Swagger::Object::RefResolutionException, "No refs provided !") do
        Swagger::Object.create_from_instance(
          Project.new(1,
            "swagger", VCS::GIT, true,
            Author.new("icyleaf"),
            "Swagger contains a OpenAPI / Swagger universal documentation generator and HTTP server handler.")
        )
      end
    end

    it "shouldn't generate schema of object without correct ref from object instance" do
      expect_raises(Swagger::Object::RefResolutionException, "Ref for Author not found") do
        Swagger::Object.create_from_instance(
          Project.new(1,
            "swagger", VCS::GIT, true,
            Author.new("icyleaf"),
            "Swagger contains a OpenAPI / Swagger universal documentation generator and HTTP server handler."),
          refs: {"SomeStringAlias" => "string"},
        )
      end
    end
  end
end
