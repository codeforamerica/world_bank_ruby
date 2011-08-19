module WorldBank

  class IncomeLevel

    attr_reader :raw, :id, :name, :type

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::ParamQuery.new('incomeLevels', id, self)
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @name = values['value']
      @type = 'incomeLevels'
    end
  end

end
