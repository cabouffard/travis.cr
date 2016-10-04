module Travis
  class Client
    BASE_URL = "https://api.travis-ci.org"
    TOKEN = ENV["TRAVIS_ACCESS_TOKEN"]? ? ENV["TRAVIS_ACCESS_TOKEN"] : "SET-YOUR-OWN"

    def self.request(resource, params : Hash? = nil) : HTTP::Client::Response
      path = build_url(resource)
      path += "?#{to_query_string(params)}" unless params.nil?

      HTTP::Client.get(build_url(resource), headers: default_headers)
    end

    # Return a full url string from built with base domain and url path
    private def self.build_url(resource)
      File.join(BASE_URL, resource)
    end

    private def self.default_headers
      error_message = "Please set a TRAVIS_ACCESS_TOKEN in your ENV variables"
      raise Error::MissingCredentials.new(error_message) unless ENV["TRAVIS_ACCESS_TOKEN"]?

      HTTP::Headers{"Authorization" => "token #{TOKEN}"}
    end

    private def self.to_query_string(hash : Hash)
      HTTP::Params.build do |form_builder|
        hash.each do |key, value|
          form_builder.add(key, value)
        end
      end
    end
  end
end
