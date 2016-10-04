require "./resource"

module Travis
  class Resource
    def self.find_all(key : String? = nil, params : Hash(String, String)? = nil, options : Hash(String, Bool)? = nil) Array(self)
      resource = generate_resource_path(key, options)
      response = Travis::Client.request(resource, params)

      Array(self).from_json(response.body)
    end

    def self.find(key : Int32 | String? = nil, params : Hash(String, String)? = nil, options : Hash(String, Bool)? = nil) self
      resource = generate_resource_path(key, options)
      response = Travis::Client.request(resource, params)

      from_json(response.body)
    end

    private def self.generate_resource_path(key : Int32 | String? = nil, options : Hash? = nil) String
      with_resource = options.nil? ? true : options["with_resource"]
      with_resource ? File.join(self.resource_name, key.to_s) : key
    end
  end
end
