module WorldBank

  class Country
  
    def self.all(client)
      client.query[:dirs] = ['countries']
      client.get_query
    end
  
  end

end
