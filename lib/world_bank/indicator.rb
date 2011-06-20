module WorldBank

  class Indicator
  
    def self.all(client)
      client.query[:dirs] = ['indicators']
      client.get_query
    end
  
  end

end
