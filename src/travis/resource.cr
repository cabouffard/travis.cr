require "./resource"

module Travis
  class Resource
    def self.all(key : String? = nil, params : Hash(String, String)? = nil)
      resource = key.nil? ? @@resource : "#{@@resource}/#{key}"
      response = Travis::Client.request(resource, params)

      unless response.success?
        raise Exceptions::Generic.new("Something went wrong")
      end

      Array(self).from_json(response.body)
    end

    def self.find(key : Int32? = nil, params : Hash(String, String)? = nil)
      resource = key.nil? ? @@resource : "#{@@resource}/#{key}"
      response = Travis::Client.request(resource, params)

      unless response.success?
        raise Exceptions::Generic.new("Something went wrong")
      end

      from_json(response.body)
    end
  end
end
