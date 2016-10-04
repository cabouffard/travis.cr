module Travis
  class Client
    BASE_URL = "https://api.travis-ci.org"
    TOKEN = "SET-YOUR-OWN"

    def self.request(resource) : HTTP::Client::Response
      HTTP::Client.get(build_url(resource), headers: default_headers)
    end

    # Return a full url string from built with base domain and url path
    private def self.build_url(resource)
      File.join(BASE_URL, resource)
    end

    # Sets headers and query params for requests
    # private def self.default_options(params : Hash? = nil)
    #   Hash(String, Hash(String, String)).new.tap do |hash|
    #     hash["headers"] = default_headers
    #     hash["params"] = params if params
    #   end
    # end

    private def self.default_headers
      HTTP::Headers{"Authorization" => "token #{TOKEN}"}
    end
  end
end
