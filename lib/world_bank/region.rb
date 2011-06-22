module WorldBank
  class Region

    attr_reader :raw, :id, :name, :code

    def self.client
      @client ||= WorldBank::Client.new
    end

    def self.all(client)
      client.query[:dirs] = ['regions']
      client.get_query
    end

    def self.find(id)
      client.query[:dirs] = ['regions', id.to_s]
      result = client.get_query
      new(result[1][0])
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @code = values['code']
    end
  end
end
