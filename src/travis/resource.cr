require "./resource"

module Travis
  class Resource
    def self.all
      response = Travis::Client.request(@@resource)

      unless response.success?
        raise Exceptions::Generic.new("Something went wrong")
      end

      Array(Travis::Repository).from_json(response.body)
      # response.body.map! { |element| from_json(element) }
    end
  end
end
