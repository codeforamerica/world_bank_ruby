module WorldBank

  class Topic

    attr_reader :raw, :id, :name, :note, :type

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::ParamQuery.new('topics', id, self)
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @note = values['sourceNote']
      @type = 'topics'
    end

  end

end
