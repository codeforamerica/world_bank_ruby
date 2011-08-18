module WorldBank

  class Source

    attr_reader :raw, :id, :name, :description, :url, :type

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::Query.new('sources', id, self)
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['name']
      @description = values['description']
      @url = values['url']
      @type = 'sources'
    end
  end

end
