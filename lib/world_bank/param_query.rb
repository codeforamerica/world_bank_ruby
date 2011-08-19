module WorldBank

  class ParamQuery < Query
  
    def initialize(name, id, model)
      super
    end
    
    def lending_type(lending_type)
      parsed = indifferent_number lending_type
      @query[:params].merge!({:lendingTypes => parsed})
      self
    end

    def income_level(income_levels)
      parsed = indifferent_number income_levels
      @query[:params].merge!({:incomeLevels => parsed})
      self
    end

    def region(regions)
      parsed = indifferent_number regions
      @query[:params].merge!({:countries => parsed})
      self
    end

    def country(country)
      parsed = indifferent_type country
      parsed = ensure_country_id parsed
      @query[:params].merge!({:countries => parsed})
      self
    end

    def indicator(indicators)
      parsed = indifferent_number indicators
      @query[:params].merge!({:indicators => parsed})
      self
    end

    def featured_indicators
      @query[:params].merge!({:featured => 1})
      self
    end

    def source(sources)
      parsed = indifferent_number sources
      @query[:params].merge!({:sources => parsed})
      self
    end
  end
end
