module WorldBank

  class Source

    attr_reader :raw, :id, :name, :description, :url, :type

    def self.client
      @client ||= WorldBank::Client.new
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
      client.query[:dirs] = ['sources']
      results = client.get_query
      optionally_parse results, args, :many
    end

    def self.find(id, *args)
      client.query[:dirs] = ['sources', id.to_s]
      result = client.get_query
      optionally_parse result, args
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['name']
      @description = values['description']
      @url = values['url']
      @type = 'sources'
    end
  end

end
