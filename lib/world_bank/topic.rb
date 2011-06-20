module WorldBank

  class Topic
  
    attr_reader :raw, :id, :name, :note
  
    def self.all(client)
      client.query[:dirs] = ['topics']
      client.get_query
    end
    
    def self.find(id)
      result = WorldBank::Client.new.get("topics/#{id}")
      new(result[1][0])
    end
    
    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @note = values['sourceNote']
    end
    
  end
  
end
