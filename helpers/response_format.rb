require "sinatra/base"

module Sinatra
  module ResponseFormat
    def format_response(data, accept)
      accept.each do |type|
        return data.to_xml if type.downcase.eql? "text/xml"
        return data.to_json if type.downcase.eql? "application/json"
        return data.to_json
      end
    end
  end
  #this will enhance sinatra's methods with our own defined methods
  helpers(ResponseFormat)
end
