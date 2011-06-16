require 'faraday_middleware'
require 'world_bank/source'
require 'world_bank/income_level'
require 'world_bank/lending_type'
require 'world_bank/country'
require 'world_bank/indicator'
require 'world_bank/topic'

module WorldBank

  class Client

    def sources
      WorldBank::Source.all
    end
    
    def income_levels
      WorldBank::IncomeLevel.all
    end
    
    def lending_types
      WorldBank::LendingType.all
    end
    
    def countries
      WorldBank::Country.all
    end
    
    def indicators
      WorldBank::Indicator.all
    end  
    
    def topics
      WorldBank::Topic.all
    end    

    def get(path, headers={})
      response = connection.get do |request|
        request.url(path, headers)
      end
      response.body
    end      

  private
    
    def connection
      Faraday.new(:url => 'http://api.worldbank.org/') do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Response::RaiseError
        connection.use Faraday::Response::Mashify
        connection.use Faraday::Response::ParseJson
        connection.adapter(Faraday.default_adapter)
      end
    end  
  end
end
