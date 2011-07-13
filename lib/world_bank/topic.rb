module WorldBank

  class Topic
  
    attr_reader :raw, :id, :name, :note, :type
  
    def self.client
      @client ||= WorldBank::Client.new
    end

    def self.all(client)
      client.query[:dirs] = ['topics']
      client.get_query
    end
    
    def self.find(id)
      client.query[:dirs] = ['topics', id.to_s]
      result = client.get_query
      new(result[1][0])
    end
    
    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @note = values['sourceNote']
      @type = 'topics'
    end
    
  end
  
end
