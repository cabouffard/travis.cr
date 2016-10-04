module Travis
  class Client
    BASE_URL = "https://api.travis-ci.org"
    TOKEN = ENV["TRAVIS_ACCESS_TOKEN"]? ? ENV["TRAVIS_ACCESS_TOKEN"] : "SET-YOUR-OWN"

    enum ErrorType
      JsonError
      NonJsonError
    end

    def self.request(resource, params : Hash? = nil) : HTTP::Client::Response
      path = build_url(resource)
      path += "?#{to_query_string(params)}" unless params.nil?

      response = HTTP::Client.get(build_url(resource), headers: default_headers)
      handle_response(response)

      response
    end

    private def self.build_url(resource) : String
      File.join(BASE_URL, resource)
    end

    private def self.default_headers : HTTP::Headers
      error_message = "Please set a TRAVIS_ACCESS_TOKEN in your ENV variables"
      raise Error::MissingCredentials.new(error_message) unless ENV["TRAVIS_ACCESS_TOKEN"]?

      HTTP::Headers{"Authorization" => "token #{TOKEN}"}
    end

    private def self.handle_response(response)
      if HTTPResponse.content_type(response) != HTTPResponse::ContentType::JSON
        raise Error::JSONParseError.new(error_message(response, ErrorType::NonJsonError))
      end

      case response.status_code
      when 400 then raise Error::BadRequest.new(error_message(response))
      when 401 then raise Error::Unauthorized.new(error_message(response))
      when 403 then raise Error::Forbidden.new(error_message(response))
      when 404 then raise Error::NotFound.new(error_message(response))
      when 422 then raise Error::Unprocessable.new(error_message(response))
      when 500 then raise Error::InternalServerError.new(error_message(response))
      when 502 then raise Error::BadGateway.new(error_message(response))
      when 503 then raise Error::ServiceUnavailable.new(error_message(response))
      end
    end

    private def self.to_query_string(hash : Hash) : HTTP::Params
      HTTP::Params.build do |form_builder|
        hash.each do |key, value|
          form_builder.add(key, value)
        end
      end
    end

    private def self.error_message(response, type : ErrorType = ErrorType::JsonError) : String
      message = if type == ErrorType::JsonError
                  response_body = JSON.parse(response.body)
                else
                  "body is not JSON format. Body: #{response.body}"
                end

      "Server responded with code #{response.status_code}, " \
        "Message: #{message}. "
    end
  end
end
