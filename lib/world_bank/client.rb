require 'faraday_middleware'
require File.expand_path(File.join(File.dirname(__FILE__), 'source'))
require File.expand_path(File.join(File.dirname(__FILE__), 'income_level'))
require File.expand_path(File.join(File.dirname(__FILE__), 'lending_type'))
require File.expand_path(File.join(File.dirname(__FILE__), 'country'))
require File.expand_path(File.join(File.dirname(__FILE__), 'indicator'))
require File.expand_path(File.join(File.dirname(__FILE__), 'topic'))
require File.expand_path(File.join(File.dirname(__FILE__), 'region'))
require File.expand_path(File.join(File.dirname(__FILE__), 'query'))
require File.expand_path(File.join(File.dirname(__FILE__), 'data'))

module WorldBank
  class Client

    attr_accessor :query

    def initialize(query, raw)
      @query = query
      @raw = raw
    end

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

    def regions
      WorldBank::Region.all
    end

    def topics
      WorldBank::Topic.all
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
        unless @raw
          raise @query.to_yaml
          case @query[:params][:format].to_s.downcase
            when 'json'
              connection.use Faraday::Response::ParseJson
            when 'xml'
              connection.use Faraday::Response::ParseXml
            end
        end
        connection.adapter(Faraday.default_adapter)
      end
    end  
  end
end
