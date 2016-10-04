require "./resource"

module Travis
  class Repository < Resource
    JSON.mapping({
      id: Int32,
      slug: String,
      description: {type: String, nilable: true},
      last_build_id: {type: Int32, nilable: true},
      last_build_number: {type: String, nilable: true},
      last_build_state:  {type: Int16, nilable: true},
      last_build_result:  {type: Int16, nilable: true},
      last_build_duration: {type: Int32, nilable: true},
      last_build_language: {type: Int32, nilable: true},
      last_build_started_at: {type: Time, nilable: true, converter: Time::Format.new("%F")},
      last_build_finished_at: {type: Time, nilable: true, converter: Time::Format.new("%F")},
    })

    def builds : Array(Travis::Build)
      Travis::Build.find_all(key: builds_resource_key, options: { "with_resource" => false })
    end

    def self.resource_name : String
      "repos"
    end

    private def builds_resource_key : String
      build_resource_name = Travis::Build.resource_name
      File.join(self.class.resource_name, slug, build_resource_name)
    end
  end
end
