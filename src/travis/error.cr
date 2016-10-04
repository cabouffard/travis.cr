module Travis
  module Error
    class Error < Exception; end

    class APIError < Error
      def initialize(@message : String? = nil)
        super(@message)
      end
    end

    class MissingCredentials < APIError; end
  end
end
