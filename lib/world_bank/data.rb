module WorldBank

  class Data

    attr_reader :raw

    def self.format(arg)
      find('all').format(arg)
    end

    def self.id(arg)
      find('all').id(arg)
    end

    def self.raw
      find('all').raw
    end

    def self.most_recent_values(arg)
      find('all').most_recent_values(arg)
    end

    def self.page(arg)
      find('all').page(arg)
    end

    def self.per_page
      find('all').per_page(arg)
    end

    def self.language(arg)
      find('all').language(arg)
    end

    def self.income_level(arg)
      find('all').income_level(arg)
    end

    def self.lending_type(arg)
      find('all').lending_type(arg)
    end

    def self.region(arg)
      find('all').region(arg)
    end 

    def self.country(arg)
      find('all').country(arg)
    end

    def self.fetch(arg)
      find(arg).fetch
    end

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::DataQuery.new('indicators', id, self)
    end

    def initialize(values={})
      @raw = values
      @name = values['indicator'].delete('value')
      @id = values['indicator'].delete('id')
      @value = values.delete('value')
      @date = values.delete('date')
      values.delete('indicator')
      @others = values
    end
  end
end
