require "./resource"

module Travis
  class Resource
    def self.all(key : String? = nil)
      resource = key ? "#{@@resource}/#{key}" : @@resource
      response = Travis::Client.request(resource)

      unless response.success?
        raise Exceptions::Generic.new("Something went wrong")
      end

      Array(Travis::Repository).from_json(response.body)
    end
  end
end
