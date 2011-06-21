module WorldBank

  class Indicator
  
    attr_reader :raw, :id, :name, :source, :note, :organization, :topics
    def self.client
      @client ||= WorldBank::Client.new
    end

    def self.all(client)
      client.query[:dirs] = ['indicators']
      client.get_query
    end
  
    def self.find(id)
      client.query[:dirs] = ['indicators', id]
      result = client.get_query
      new(result[1][0])
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['name']
      @source = WorldBank::Source.new(values['source'])
      @note = values['sourceNote']
      @organization = values['sourceOrganization']
      @topics = []
      values['topics'].each do |topic| 
        @topics << WorldBank::Topic.new(topic)
      end
    end
  end

end
