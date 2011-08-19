module WorldBank
  class Region

    attr_reader :raw, :id, :name, :code, :type

    def self.all
      find('all')
    end

    def self.find(id)
      WorldBank::ParamQuery.new('regions', id, self)
    end

    def initialize(values={})
      @raw = values
      @id = values['id']
      @code = values['code']
      @name = values['name']
      @type = 'regions'
    end
  end
end
