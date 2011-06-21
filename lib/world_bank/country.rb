module WorldBank

  class Country
  
    attr_reader :raw, :name, :iso2_code, :iso3_code, :region, :income_level, :lending_type, :capital, :type

    def self.client
      @client ||= WorldBank::Client.new
    end

    def self.all(client)
      client.query[:dirs] = ['countries']
      client.get_query
    end

    def self.find(id)
      client.query[:dirs] = ['countries', id.to_s]
      result = client.get_query
      new(result[1][0])
    end
  
    def initialize(values={})
      @raw = values
      @name = values['name']
      @iso2_code = values['iso2Code']
      @iso3_code = values['id']
      @region = WorldBank::Region.new(values['region'])
      @income_level = WorldBank::IncomeLevel.new(values['incomeLevel'])
      @lending_type = WorldBank::LendingType.new(values['lendingType'])
      @capital = values['capitalCity']
      @type = 'countries'
    end
  end

end
