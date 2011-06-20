module WorldBank

  class Source
  
    def self.all(client)
      client.query[:dirs] = ['sources']
      client.get_query
    end
  
  end

end
