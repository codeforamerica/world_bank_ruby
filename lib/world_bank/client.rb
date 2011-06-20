require 'faraday_middleware'
require File.expand_path(File.join(File.dirname(__FILE__), '/source'))
require File.expand_path(File.join(File.dirname(__FILE__), '/income_level'))
require File.expand_path(File.join(File.dirname(__FILE__), '/lending_type'))
require File.expand_path(File.join(File.dirname(__FILE__), '/country'))
require File.expand_path(File.join(File.dirname(__FILE__), '/indicator'))
require File.expand_path(File.join(File.dirname(__FILE__), '/topic'))

module WorldBank
  class Client

    attr_accessor :query

    def initialize(options={})
      @format = options[:format] || 'json'
      @query = {:params => {}, :dirs => []}
      @query[:params][:format] = @format
    end

    def sources
      WorldBank::Source.all(self)
    end

    def income_levels
      WorldBank::IncomeLevel.all(self)
    end

    def lending_types
      WorldBank::LendingType.all(self)
    end

    def countries
      WorldBank::Country.all(self)
    end

    def indicators
      WorldBank::Indicator.all(self)
    end  

    def topics
      WorldBank::Topic.all(self)
    end    

    def get_query
      @path = @query[:dirs].join('/')
      @path += '?'
      params = []
      @query[:params].each do |key, value|
        params << "#{key.to_s}=#{value.to_s}"
      end
      @path += params.join('&')
      get(@path)
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
        case @format.to_s.downcase
          when 'json'
            connection.use Faraday::Response::ParseJson
          when 'jsonp'
            connection.use Faraday::Response::ParseJson
          when 'xml'
            connection.use Faraday::Response::ParseXml
          when 'raw'
          end
        connection.adapter(Faraday.default_adapter)
      end
    end  
  end
end
