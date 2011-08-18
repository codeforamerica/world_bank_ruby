module WorldBank

  class Indicator

    attr_reader :raw, :id, :name, :source, :note, :organization, :topics, :type

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

    def self.fetch(arg)
      find(arg).fetch
    end

    def self.featured
      find('all').featured_indicators
    end

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::Query.new('indicators', id, self)
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
      @type = 'indicators'
    end
  end
end
