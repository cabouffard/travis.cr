require "./resource"

module Travis
  class Repository < Resource
    @@resource = "repos"

    JSON.mapping({
      id: Int16,
      slug: String
    })
  end
end
