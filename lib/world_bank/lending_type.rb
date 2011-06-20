module WorldBank

  class LendingType
  
    def self.all(client)
      client.query[:dirs] = ['lendingTypes']
      client.get_query
    end
  end
end
