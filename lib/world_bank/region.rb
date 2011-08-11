module WorldBank
  class Region

    attr_reader :raw, :id, :name, :code, :type

    def self.client
      @client ||= WorldBank::Client.new({:dirs => [], :params => {:format => @format}}, false)
    end

    def self.optionally_parse(results, args, many=false)
      opts = args.last || {}
      if many
        results = results[1].map { |result| new result } unless opts[:raw]
      else
        results = new results[1][0] unless opts[:raw]
      end
      results
    end

    def self.all(*args)
      client.query[:dirs] = ['regions']
      results = client.get_query
      optionally_parse results, args, :many
    end

    def self.find(id, *args)
      client.query[:dirs] = ['regions', id.to_s]
      result = client.get_query
      optionally_parse results, args, :many
    end

    def initialize(values={})
      @format = values['format'] || values[:format] || 'json'
      @raw = values
      @id = values['id']
      @name = values['value']
      @type = 'regions'
    end
  end
end
