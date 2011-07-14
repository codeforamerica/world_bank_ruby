module WorldBank

  class Data

    attr_reader :raw

    def self.format(arg)
      find('all').format(arg)
    end

    def self.id(arg)
      find('all').id(arg)
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

    def self.income_levels(arg)
      find('all').income_levels(arg)
    end

    def self.lending_types(arg)
      find('all').lending_types(arg)
    end

    def self.regions(arg)
      find('all').regions(arg)
    end 

    def self.countries
      find('all').countries(arg)
    end

    def self.indicators(arg)
      find('all').indicators(arg)
    end

    def self.fetch(arg)
      find(arg).fetch
    end

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::Query.new('indicators', id, self)
    end

    def initialize(values={})
      @raw = values
    end
  end
end
