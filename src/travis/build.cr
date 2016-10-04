require "./resource"

module Travis
  class Build < Resource
    @@resource = "builds"

    JSON.mapping({
      id: Int32,
      repository_id: Int32,
      commit: String,
      number: String,
      event_type: String,
      author_email: String,
      author_name: String,
      branch: String,
      message: String,
      status: Int16,
      result: Int16,
      state: String,
      committed_at: {type: Time, converter: Time::Format.new("%F")},
      started_at: {type: Time, converter: Time::Format.new("%F")},
      finished_at: {type: Time, converter: Time::Format.new("%F")},
      duration: Int32
    })
  end
end
