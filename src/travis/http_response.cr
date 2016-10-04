module Travis
  class HTTPResponse
    enum ContentType
      JSON
      HTML
      PlainText
      BinaryStream
      Unknown
    end

    def self.content_type(response)
      case response.content_type
      when /text\/html/
        ContentType::HTML
      when /text\/plain/
        ContentType::PlainText
      when /json/
        ContentType::JSON
      when /application\/octet-stream/
        ContentType::BinaryStream
      else
        ContentType::Unknown
      end
    end
  end
end
