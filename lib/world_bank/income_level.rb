module WorldBank

  class IncomeLevel
  
    def self.all(client)
      client.query[:dirs] = ['incomeLevels']
      client.get_query
    end
  
  end

end
