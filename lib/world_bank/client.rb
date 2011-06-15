require 'faraday_middleware'

module WorldBank

  class Client



  private

    def get(path, headers={})
      response = connection.get do |request|
        request.url(path, headers)
      end
      response.body
    end      
    
    def connection
      Faraday.new(:url => 'http://api.worldbank.org/') do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Response::RaiseError
        connection.use Faraday::Response::Mashify
        connection.adapter(Faraday.default_adapter)
      end
    end  
  end
end
