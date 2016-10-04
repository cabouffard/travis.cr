require "./resource"

module Travis
  class Repository < Resource
    @@resource = "repos"

    JSON.mapping({
      id: Int16,
      slug: String,
      description: {type: String, nilable: true},
      last_build_id: {type: Int16, nilable: true},
      last_build_number: {type: String, nilable: true},
      last_build_state:  {type: String, nilable: true},
      last_build_duration: {type: Int16, nilable: true},
      last_build_started_at: {type: Time, nilable: true, converter: Time::Format.new("%F")},
      last_build_finished_at: {type: Time, nilable: true, converter: Time::Format.new("%F")},
      github_language: {type: String, nilable: true}
    })
  end
end
