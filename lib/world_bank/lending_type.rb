module WorldBank

  class LendingType
  
    attr_reader :raw, :id, :name, :type

    def self.client
      @client ||= WorldBank::Client.new
    end
    
    def self.all(client)
      client.query[:dirs] = ['lendingTypes']
      client.get_query
    end

    def self.find(id)
      client.query[:dirs] = ['lendingTypes', id.to_s]
      result = client.get_query
      new(result[1][0])
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @type = 'lendingTypes'
    end
  end
end

