module WorldBank

  class DataQuery < Query

    def initialize(name, id, model)
      super
      clear_params!
    end
    
    def fetch
      results = super
      clear_params!
      results
    end
    
    def lending_type(lending_type)
      ensure_unconflicting_qualifiers
      parsed = indifferent_number lending_type
      @param_dir = ['lendingTypes', parsed]
      self
    end

    def income_level(income_level)
      ensure_unconflicting_qualifiers
      parsed = indifferent_number income_level
      @param_dir = ['incomeLevels', parsed]
      self
    end

    def region(regions)
      ensure_unconflicting_qualifiers
      parsed = indifferent_number regions
      @param_dir = ['countries', parsed]
      self
    end

    def country(country)
      ensure_unconflicting_qualifiers
      parsed = indifferent_type country
      parsed = ensure_country_id parsed
      @param_dir = ['countries', parsed]
      self
    end

    def indicator(indicators)
      parsed = indifferent_number indicators
      @id = parsed
      self
    end
    alias_method(:find, :indicator)

    def source(sources)
      ensure_unconflicting_qualifiers
      parsed = indifferent_number sources
      @param_dir = ['sources', parsed]
      self
    end

    private

    def ensure_unconflicting_qualifiers
      if @params_filled
        raise ArgumentError,
          "Only one of 'income_level', 'lending_type', 'country', or 'source' can be called on the same query"
      end
      @params_filled = true
    end
    
    def clear_params!
      @param_dir = []
      @params_filled = false      
    end    
  end
end
