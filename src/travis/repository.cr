require "./resource"

module Travis
  class Repository < Resource
    @@resource = "repos"

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

    def builds
      Travis::Build.find_all("#{slug}/builds")
    end
  end
end
