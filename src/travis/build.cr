require "./resource"

module Travis
  class Build < Resource
    JSON.mapping({
      id: Int32,
      repository_id: Int32,
      commit: String,
      number: String,
      event_type: String,
      author_email: {type: String, nilable: true},
      author_name: {type: String, nilable: true},
      branch: String,
      message: String,
      result: Int16,
      state: String,
      committed_at: {type: Time, nilable: true, converter: Time::Format.new("%F")},
      started_at: {type: Time, converter: Time::Format.new("%F")},
      finished_at: {type: Time, converter: Time::Format.new("%F")},
      duration: Int32
    })

    def self.resource_name
      "builds"
    end
  end
end
