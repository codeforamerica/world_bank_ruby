module WorldBank

  class Source
  
    attr_reader :raw, :id, :name, :description, :url, :type

    def self.client
      @client ||= WorldBank::Client.new
    end
    def self.all(client)
      client.query[:dirs] = ['sources']
      client.get_query
    end
  
    def self.find(id)
      client.query[:dirs] = ['sources', id.to_s]
      result = client.get_query
      new(result[1][0])
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
