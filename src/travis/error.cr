module Travis
  module Error
    class Error < Exception; end

    class APIError < Error
      def initialize(@message : String? = nil)
        super(@message)
      end
    end

    class JSONParseError < APIError; end
    class MissingCredentials < APIError; end
    class BadRequest < APIError; end
    class Unauthorized < APIError; end
    class Forbidden < APIError; end
    class NotFound < APIError; end
    class Unprocessable < APIError; end
    class InternalServerError < APIError; end
    class BadGateway < APIError; end
    class ServiceUnavailable < APIError; end
  end
end
